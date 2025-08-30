import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tdd_app/data/models/student_model.dart';
import 'package:tdd_app/data/repositories/student_repository.dart';
import '../test_helpers/api_test_helper.dart';
import 'api_serviece_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late StudentRepository studentRepository;

  setUp(() {
    mockClient = MockClient();
    studentRepository = StudentRepository(client: mockClient);
  });

  group('StudentRepository API Tests', () {
    group('Fetch Students List', () {
      test('Successfully fetches list of students with status 200', () async {
        stubHttpGet(mockClient, statusCode: successStatus);
        final result = await studentRepository.getStudentsList();
        expect(result, isA<List<StudentModel>>());
        expect(result.length, equals(2));
        expect(result[0].name, equals('Salih'));
      });

      test('Throws exception when server returns 404', () async {
        stubHttpGet(mockClient, statusCode: notFoundStatus);
        expectThrows<Exception>(studentRepository.getStudentsList);
      });

      test('Throws FormatException for invalid JSON response', () async {
        stubHttpGet(mockClient, statusCode: successStatus, isInvalidJson: true);
        expectThrows<FormatException>(studentRepository.getStudentsList);
      });

      test('Throws ClientException for network timeout', () async {
        stubNetworkError(mockClient, 'GET');
        expectThrows<http.ClientException>(studentRepository.getStudentsList);
      });
    });

    group('Fetch Student Details', () {
      test('Successfully fetches student details with status 200', () async {
        stubHttpGet(
          mockClient,
          statusCode: successStatus,
          body: jsonEncode(validStudentJson),
        );

        final result = await studentRepository.getStudentDetails(testStudentId);
        expect(result, isA<StudentModel>());
        expect(result.id, equals(testStudentId));
      });

      test('Throws exception when server returns 404', () async {
        stubHttpGet(mockClient, statusCode: notFoundStatus);
        expect(
          () => studentRepository.getStudentDetails(testStudentId),
          throwsException,
        );
      });

      test('Throws FormatException for invalid JSON response', () async {
        stubHttpGet(mockClient, statusCode: successStatus, isInvalidJson: true);
        expectThrows<FormatException>(
          () => studentRepository.getStudentDetails(testStudentId),
        );
      });

      test('Throws ClientException for network timeout', () async {
        stubNetworkError(mockClient, 'GET');
        expect(
          () => studentRepository.getStudentDetails(testStudentId),
          throwsA(isA<http.ClientException>()),
        );
      });
    });

    group('Add Student', () {
      test('Successfully adds student with status 201', () async {
        stubHttpPost(mockClient, statusCode: createdStatus);
        final result = await studentRepository.addStudent(
          StudentModel.fromJson(validStudentJson),
        );
        expect(result, 'Student Added');
      });

      test('Throws exception when server returns 404', () async {
        stubHttpPost(mockClient, statusCode: notFoundStatus);
        expectThrows<Exception>(
          () => studentRepository.addStudent(
            StudentModel.fromJson(validStudentJson),
          ),
        );
      });

      test('Throws TimeoutException for network timeout', () async {
        stubNetworkError(mockClient, 'POST');
        expectThrows<TimeoutException>(
          () => studentRepository.addStudent(
            StudentModel.fromJson(validStudentJson),
          ),
        );
      });
    });

    group('Delete Student', () {
      test('Successfully deletes student with status 204', () async {
        stubHttpDelete(
          mockClient,
          studentId: testStudentId,
          statusCode: noContentStatus,
        );
        final result = await studentRepository.deleteStudent(testStudentId);
        expect(result, 'Delete Success');
      });

      test('Throws exception when server returns 404', () async {
        stubHttpDelete(
          mockClient,
          studentId: testStudentId,
          statusCode: notFoundStatus,
        );
        expectThrows<Exception>(
          () => studentRepository.deleteStudent(testStudentId),
        );
      });

      test('Throws TimeoutException for network timeout', () async {
        stubNetworkError(mockClient, 'DELETE');
        expectThrows<TimeoutException>(
          () => studentRepository.deleteStudent(testStudentId),
        );
      });
    });
  });
}
