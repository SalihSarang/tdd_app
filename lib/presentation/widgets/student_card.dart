import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_app/data/models/student_model.dart';
import 'package:tdd_app/data/repositories/student_repository.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import 'package:tdd_app/presentation/screens/details_screen.dart';
import 'package:tdd_app/presentation/widgets/custom_alertbox.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  StudentBloc(StudentRepository(client: http.Client()))
                    ..add(FetchStudentDetails(student.id)),
              child: DetailScreen(),
            ),
          ),
        );
      },
      child: SizedBox(
        height: 80,
        child: Card(
          color: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 8,
              top: 5,
            ),
            child: ListTile(
              title: Text(student.name, style: TextStyle(color: Colors.white)),
              subtitle: Text(
                student.batch,
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                key: Key('deleteButton'),
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  final studentsBloc = BlocProvider.of<StudentBloc>(context);
                  showDialog(
                    context: context,
                    builder: (_) => DeleteStudentDialog(
                      studentName: student.name,
                      onConfirm: () {
                        studentsBloc.add(DeleteStudent(student.id));
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
