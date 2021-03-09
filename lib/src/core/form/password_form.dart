import 'package:room_v2/src/constants/form_validator.dart';
import 'package:formz/formz.dart';

class PasswordForm extends FormzInput<String, dynamic> {
  const PasswordForm.pure() : super.pure('');
  const PasswordForm.dirty([String value = '']) : super.dirty(value);

  @override
  FormValidationError validator(String value) {
    if (value.isEmpty) {
      return FormValidationError.empty;
    }

    if (value.length < 6) {
      return FormValidationError.minimumLength;
    }

    return null;
  }
}
