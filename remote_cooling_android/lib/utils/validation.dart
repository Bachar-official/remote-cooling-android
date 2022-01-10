class ValidationUtils {
  static String? validateNull(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым!';
    }
    return null;
  }

  static String? validateIp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым!';
    }
    else if (RegExp(r'^([0-9]{1,3}[\.]){3}[0-9]{1,3}').hasMatch(value) == false) {
      return 'Введите валидный ip адрес.';
    }
    return null;
  }

  static String? validatePort(String? value) {
    int? port = null;
    if (value != null) {
      port = int.tryParse(value, radix: 10);
    }
    if (value == null) {
      return 'Поле не может быть пустым!';
    }
    else if (port == null) {
      return 'Введите число!';
    }
    else if (port > 65535 || port < 1) {
      return 'Введите валидный порт!';
    }
    return null;
  }

  static String? validateDuration(String? value) {
    int? duration = null;
    if (value != null) {
      duration = int.tryParse(value, radix: 10);
    }
    if (value == null) {
      return 'Поле не может быть пустым!';
    }
    else if (duration == null) {
      return 'Введите число!';
    }
    else if (duration > 10 || duration < 0) {
      return 'Длительность ожидания может быть от 1 до 10 секунд!';
    }
    return null;
  }

  static String? validateEnglish(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым!';
    }
    else if (RegExp(r'^[a-zA-Z]+$').hasMatch(value) == false) {
      return 'Только латинница';
    }
    return null;
  }
}