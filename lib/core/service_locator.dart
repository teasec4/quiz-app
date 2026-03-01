import 'package:bookexample/data/repositories/isar_library_repository_impl.dart';
import 'package:bookexample/data/repositories/stats_repository_impl.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/domain/repositories/stats_repository.dart';
import 'package:bookexample/view_models/library_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'db/db_schema.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  await Isar.initializeIsarCore(download: true);
  final isar = await initDB(dbSchema);

  // DB
  getIt.registerSingleton<Isar>(isar);

  // Repositories
  getIt.registerSingleton<LibraryRepository>(IsarLibraryRepositoryImpl(isar));
  getIt.registerSingleton<StatsRepository>(StatsRepositoryImpl(isar: isar));

  // ViewModels
  getIt.registerSingleton<LibraryViewModel>(
    LibraryViewModel(getIt<LibraryRepository>()),
  );
}

Future<Isar> initDB(List<CollectionSchema> schema) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(schema, directory: dir.path);

  return isar;
}
