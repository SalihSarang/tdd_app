import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/core/utils/validators.dart';

import '../test_helpers/validation_test_helper.dart';

void main() {
  group('Validation Tests', () {
    group('validateName', () {
      test('should return null for a valid name', () {
        expectValidInput(validateName, 'Sarang');
      });

      test('should return error message for empty name', () {
        expectInvalidInput(validateName, '', 'Please enter a name');
      });

      test('should return error message for name with numbers', () {
        expectInvalidInput(
          validateName,
          'Salih123',
          'Name can only contain letters',
        );
      });

      test('should return error message for name less than 2 characters', () {
        expectInvalidInput(
          validateName,
          'S',
          'Name must be at least 2 characters',
        );
      });
    });

    group('validateBatch', () {
      test('should return null for a valid batch number', () {
        expectValidInput(validateBatch, '123');
      });

      test('should return error message for empty batch number', () {
        expectInvalidInput(validateBatch, '', 'Please enter Batch number');
      });

      test('should return error message for non-numeric batch number', () {
        expectInvalidInput(
          validateBatch,
          'abc',
          'Batch number must be numeric',
        );
      });
    });

    group('validateWeek', () {
      test('should return null for a valid week number', () {
        expectValidInput(validateWeek, '15');
      });

      test('should return error message for empty week number', () {
        expectInvalidInput(validateWeek, '', 'Please enter Week');
      });

      test('should return error message for non-numeric week number', () {
        expectInvalidInput(validateWeek, 'xyz', 'Week must be numeric');
      });

      test('should return error message for week number less than 1', () {
        expectInvalidInput(validateWeek, '0', 'Week must be between 1 and 28');
      });

      test('should return error message for week number greater than 28', () {
        expectInvalidInput(validateWeek, '29', 'Week must be between 1 and 28');
      });
    });
  });
}
