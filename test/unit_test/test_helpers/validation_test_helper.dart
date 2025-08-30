import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/data/models/student_model.dart';

StudentModel createValidStudent({
  String? id,
  String? name,
  String? batch,
  String? week,
}) {
  return StudentModel(
    id: id ?? '1',
    name: name ?? 'Salih',
    batch: batch ?? '1',
    week: week ?? '10',
  );
}

void expectStudentProperties(
  StudentModel student, {
  required String id,
  required String name,
  required String batch,
  required String week,
}) {
  expect(student.id, id);
  expect(student.name, name);
  expect(student.batch, batch);
  expect(student.week, week);
}

void expectValidInput(String? Function(String?) validator, String? input) {
  expect(validator(input), isNull);
}

void expectInvalidInput(
  String? Function(String?) validator,
  String? input,
  String errorMessage,
) {
  expect(validator(input), errorMessage);
}
