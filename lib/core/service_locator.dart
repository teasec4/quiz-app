import 'package:bookexample/data/repositories/in_memory_library_repository_impl.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  getIt.registerSingleton<LibraryRepository>(
    InMemoryLibraryRepositoryImpl(),
  );
}
