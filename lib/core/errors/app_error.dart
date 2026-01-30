// household-management-system/lib/core/errors/app_error.dart

class AppError implements Exception {
  final String message;
  final int? code;

  AppError(this.message, {this.code});

  @override
  String toString() => 'AppError: $message (code: $code)';
}

class ValidationError extends AppError {
  ValidationError(String message, {int? code}) : super(message, code: code);
}
