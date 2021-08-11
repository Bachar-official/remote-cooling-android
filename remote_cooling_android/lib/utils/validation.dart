class ValidationUtils {
  static String validateNull(String value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым!';
    }
    return null;
  }
}