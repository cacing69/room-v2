import 'package:room_v2/src/constants/form_validator.dart';
import 'package:formz/formz.dart';

class UsernameForm extends FormzInput<String, dynamic> {
  const UsernameForm.pure() : super.pure('');
  const UsernameForm.dirty([String value = '']) : super.dirty(value);

  @override
  FormValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : FormValidationError.empty;
  }
}
