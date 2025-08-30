import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/data/models/student_model.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import 'package:tdd_app/presentation/screens/details_screen.dart';

class MockStudentBloc extends MockBloc<StudentEvent, StudentState>
    implements StudentBloc {}

Widget pumpDetailScreen(StudentBloc studentBloc) {
  return BlocProvider.value(
    value: studentBloc,
    child: const MaterialApp(home: DetailScreen()),
  );
}

StudentModel getFakeStudent() {
  return StudentModel(id: '1', name: 'John Doe', batch: 'B1', week: '2');
}

void stubStudentBlocState(MockStudentBloc mockBloc, StudentState state) {
  when(() => mockBloc.state).thenReturn(state);
}
