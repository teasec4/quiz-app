import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:flutter/foundation.dart';

class LibraryProvider with ChangeNotifier {
  final LibraryRepository repository;

  LibraryProvider(this.repository);
  
  
}
