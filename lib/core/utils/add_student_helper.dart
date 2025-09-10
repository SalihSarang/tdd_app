import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tdd_app/core/utils/validators.dart';
import 'package:tdd_app/data/models/student_model.dart';

String jsonEnc(StudentModel student) {
  return jsonEncode({
    'studentName': student.name,
    'batch': student.batch,
    'week': student.week,
  });
}

StudentModel createStudent({
  required String name,
  required String batch,
  required String week,
}) {
  return StudentModel(
    name: name,
    batch: batch,
    week: week,
    id: generateUniqueId(),
  );
}

bool validateForm(GlobalKey<FormState> key) {
  if (key.currentState!.validate()) return true;

  return false;
}
