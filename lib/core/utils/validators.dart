String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter a name';
  }
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return 'Name can only contain letters';
  }
  if (value.length < 2) {
    return 'Name must be at least 2 characters';
  }
  return null;
}

String? validateBatch(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter Batch number';
  }
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Batch number must be numeric';
  }
  return null;
}

String? validateWeek(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter Week';
  }
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Week must be numeric';
  }
  int week = int.parse(value);
  if (week < 1 || week > 28) {
    return 'Week must be between 1 and 28';
  }
  return null;
}

String generateUniqueId() {
  return DateTime.now().microsecondsSinceEpoch.toString();
}
