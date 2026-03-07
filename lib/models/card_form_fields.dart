import 'package:flutter/material.dart';

class CardFormFields {
  final TextEditingController frontController;
  final TextEditingController backController;
  final FocusNode frontFocus;
  final FocusNode backFocus;

  CardFormFields()
    : frontController = TextEditingController(),
      backController = TextEditingController(),
      frontFocus = FocusNode(),
      backFocus = FocusNode();

  void dispose() {
    frontController.dispose();
    backController.dispose();
    frontFocus.dispose();
    backFocus.dispose();
  }
}
