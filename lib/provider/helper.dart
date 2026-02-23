import 'package:uuid/uuid.dart';

// over kill :) 
class Helper {
  static String generateId(){
    return Uuid().v4();
  }
}
