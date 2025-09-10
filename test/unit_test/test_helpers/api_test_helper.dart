import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tdd_app/core/constants/api_endpoints.dart';
import 'package:tdd_app/data/models/student_model.dart';
import '../api_serviece_test/api_serviece_test.mocks.dart';

const List<Map<String, String>> validStudentsJson = [
  {'studentName': 'Salih', 'week': '22', 'batch': '221', 'id': '1'},
  {'studentName': 'Salih', 'week': '20', 'batch': '223', 'id': '2'},
];
const Map<String, String> validStudentJson = {
  'studentName': 'Salih',
  'week': '20',
  'batch': '225',
  'id': '1',
};
final invalidStudent = StudentModel(
  id: '0',
  week: '20',
  batch: '225',
  name: '',
);
const String invalidJson = '{Invalid_JSON}';
const String testStudentId = '1';
const int successStatus = 200;
const int createdStatus = 201;
const int notFoundStatus = 404;
const String timeoutMessage = 'The Connection Has Timed Out';

void stubHttpGet(
  MockClient client, {
  required int statusCode,
  String? body,
  bool isInvalidJson = false,
}) {
  final responseBody = isInvalidJson
      ? invalidJson
      : (body ?? jsonEncode(validStudentsJson));
  when(
    client.get(any),
  ).thenAnswer((_) async => http.Response(responseBody, statusCode));
}

void stubHttpPost(
  MockClient client, {
  required int statusCode,
  String? body,
  bool isInvalidJson = false,
}) {
  final responseBody = isInvalidJson
      ? invalidJson
      : (body ?? jsonEncode(validStudentJson));
  when(
    client.post(url, headers: anyNamed('headers'), body: anyNamed('body')),
  ).thenAnswer((_) async => http.Response(responseBody, statusCode));
}

void stubHttpDelete(
  MockClient client, {
  required String studentId,
  required int statusCode,
}) {
  final deleteUrl = Uri.parse('$url/$studentId');
  when(
    client.delete(deleteUrl),
  ).thenAnswer((_) async => http.Response(jsonEncode({}), statusCode));
}

void expectThrows<T extends Object>(void Function() action) {
  expect(action, throwsA(isA<T>()));
}

void stubNetworkError(MockClient client, String method) {
  switch (method.toUpperCase()) {
    case 'GET':
      when(client.get(any)).thenThrow(http.ClientException(timeoutMessage));
      break;
    case 'POST':
      when(
        client.post(url, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenThrow(TimeoutException(timeoutMessage));
      break;
    case 'DELETE':
      when(client.delete(any)).thenThrow(TimeoutException(timeoutMessage));
      break;
  }
}
