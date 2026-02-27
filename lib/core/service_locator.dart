import 'package:bookexample/data/repositories/isar_library_repository_impl.dart';
import 'package:bookexample/data/repositories/stats_repository_impl.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/domain/repositories/stats_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';

final getIt = GetIt.instance;

void setupServiceLocator(Isar isar) {
  // Repositories
  getIt.registerSingleton<LibraryRepository>(IsarLibraryRepositoryImpl(isar));

  // Isar database
  getIt.registerSingleton<Isar>(isar);

  getIt.registerSingleton<StatsRepository>(
    StatsRepositoryImpl(isar: isar)
  );
}
