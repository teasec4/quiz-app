import 'package:uuid/uuid.dart';

class Helper {
  static String generateId(){
    return Uuid().v4();
  }
}
