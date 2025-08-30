import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStudentBloc extends Mock implements StudentBloc {}

class FakeStudentState extends Fake implements StudentState {}

class FakeStudentEvent extends Fake implements StudentEvent {}

Widget pumpScreen(StudentBloc studentBloc, Widget screen) {
  return BlocProvider.value(
    value: studentBloc,
    child: MaterialApp(home: screen),
  );
}
