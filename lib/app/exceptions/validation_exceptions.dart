class ValidationException implements Exception {
  final String message;
  ValidationException({required this.message});

  @override
  String toString() {
    return message;
  }
}
