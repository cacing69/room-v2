import 'package:room_v2/src/constants/form_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String getValidator(FormValidationError error, {dynamic meta}) {
  if (error == FormValidationError.empty) {
    return "cannot empty";
  }

  if (error == FormValidationError.minimumLength) {
    return "too short";
  }
}

void showSnackBar(BuildContext context, {@required String message}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message)),
    );
}
