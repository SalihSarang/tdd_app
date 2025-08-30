import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_app/data/repositories/student_repository.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';

class MockStudentRepository extends Mock implements StudentRepository {}

Widget pumpScreen(StudentBloc studentBloc, Widget screen) {
  return BlocProvider.value(
    value: studentBloc,
    child: MaterialApp(home: screen),
  );
}
