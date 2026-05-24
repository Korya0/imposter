import 'package:imposter/core/constants/app_strings.dart';

abstract class AppValidators {
  static final RegExp alphanumericWithSpaces = RegExp(
    r'[a-zA-Z0-9\u0600-\u06FF\u0660-\u0669\s]',
  );
    
  static String? validatePlayerName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.playerNameEmptyError;
    }
    return null;
  }
}
