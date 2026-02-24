import 'package:flutter/material.dart';

class CardFormTextFormField {
  final TextEditingController frontController;
  final TextEditingController backController;
  final FocusNode frontFocus;
  final FocusNode backFocus;
  
  CardFormTextFormField(): 
    frontController = TextEditingController(),
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