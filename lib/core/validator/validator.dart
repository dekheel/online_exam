import 'package:flutter/widgets.dart';
import '../../core/l10n/app_localizations.dart';

abstract class AppValidators {
  static String? validateEmail(BuildContext context, String? val) {
    RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null || val.trim().isEmpty) {
      return AppLocalizations.of(context)!.empty_input_validation;
    } else if (!emailRegex.hasMatch(val)) {
      return AppLocalizations.of(context)!.input_not_valid;
    } else {
      return null;
    }
  }

  static String? validatePassword(BuildContext context, String? val) {
    RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$',
    );
    if (val == null || val.isEmpty) {
      return AppLocalizations.of(context)!.empty_input_validation;
    } else if (val.length < 6 || !passwordRegex.hasMatch(val)) {
      return AppLocalizations.of(context)!.password_requirements;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
    BuildContext context,
    String? val,
    String? password,
  ) {
    if (val == null || val.isEmpty) {
      return AppLocalizations.of(context)!.empty_input_validation;
    } else if (val != password) {
      return AppLocalizations.of(context)!.confirm_password_not_valid;
    } else {
      return null;
    }
  }

  static String? validateUsername(BuildContext context, String? val) {
    RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null || val.isEmpty) {
      return AppLocalizations.of(context)!.empty_input_validation;
    } else if (!usernameRegex.hasMatch(val) || val.length < 3) {
      return AppLocalizations.of(context)!.input_not_valid;
    } else {
      return null;
    }
  }

  static String? validateFullName(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return AppLocalizations.of(context)!.empty_input_validation;
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return AppLocalizations.of(context)!.empty_input_validation;
    } else if (int.tryParse(val.trim()) == null) {
      return AppLocalizations.of(context)!.input_not_valid;
    } else if (val.trim().length != 11) {
      return AppLocalizations.of(context)!.input_not_valid;
    } else {
      return null;
    }
  }
}
