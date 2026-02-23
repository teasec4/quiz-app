import 'package:flutter/material.dart';

class CardFormTextFormField {
  final TextEditingController frontController;
  final TextEditingController backController;
  
  CardFormTextFormField(): 
    frontController = TextEditingController(),
    backController = TextEditingController();
  
  void dispose() {
      frontController.dispose();
      backController.dispose();
  }
}