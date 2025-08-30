import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import 'package:tdd_app/presentation/screens/student_add_screen.dart';

class MockStudentBloc extends Mock implements StudentBloc {}

class FakeStudentState extends Fake implements StudentState {}

class FakeStudentEvent extends Fake implements StudentEvent {}

void registerStudentAddScreenFallbacks() {
  registerFallbackValue(FakeStudentState());
  registerFallbackValue(FakeStudentEvent());
}

Widget makeStudentAddTestableWidget(StudentBloc bloc) {
  return MaterialApp(
    home: BlocProvider<StudentBloc>.value(
      value: bloc,
      child: StudentAddScreen(),
    ),
  );
}

void stubBloc(MockStudentBloc bloc, List<StudentState> states) {
  when(() => bloc.state).thenReturn(states.last);
  when(() => bloc.stream).thenAnswer((_) => Stream.fromIterable(states));
}
