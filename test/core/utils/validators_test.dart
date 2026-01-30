// household-management-system/test/core/utils/validators_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:household_management_system/core/utils/validators.dart';

void main() {
  test('isValidEmail returns true for valid email', () {
    expect(Validators.isValidEmail('test@example.com'), isTrue);
  });

  test('isValidEmail returns false for invalid email', () {
    expect(Validators.isValidEmail('invalid'), isFalse);
  });

  test('isValidPassword returns true for valid password', () {
    expect(Validators.isValidPassword('Test1234'), isTrue);
  });

  test('isValidPassword returns false for weak password', () {
    expect(Validators.isValidPassword('123'), isFalse);
  });
}
