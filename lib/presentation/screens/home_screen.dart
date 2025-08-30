import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/data/models/student_model.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import 'package:tdd_app/presentation/screens/student_add_screen.dart';
import 'package:tdd_app/presentation/widgets/student_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentAddScreen()),
        ),
        backgroundColor: const Color.fromARGB(255, 45, 88, 161),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is StudentLoaded) {
            List<StudentModel> students = state.students;
            if (students.isEmpty) {
              return Center(child: Text('No Student Added Yet'));
            } else {
              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return StudentCard(student: student);
                },
              );
            }
          } else if (state is StudentError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
