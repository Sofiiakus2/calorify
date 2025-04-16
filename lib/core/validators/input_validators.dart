///validators
class InputValidators{

  ///validator for email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введіть email';
    }

    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

    if (!emailRegex.hasMatch(value)) {
      return 'Некоректний email';
    }

    return null;
  }


  ///validator for password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введіть пароль';
    }

    if (value.length < 6) {
      return 'Пароль має бути не менше 6 символів';
    }

    final hasUpperCase = RegExp(r'[A-Z]');
    final hasDigit = RegExp(r'[0-9]');

    if (!hasUpperCase.hasMatch(value)) {
      return 'Пароль має містити хоча б одну велику літеру';
    }

    if (!hasDigit.hasMatch(value)) {
      return 'Пароль має містити хоча б одну цифру';
    }

    return null;
  }
}
