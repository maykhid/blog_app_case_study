extension StringX on String {
  String get capitalizeFirstLetter {
    if (isEmpty) {
      return this; // Return the original string if it's empty.
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
