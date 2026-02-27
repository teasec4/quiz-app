import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:isar_community/isar.dart';

class IsarLibraryRepositoryImpl implements LibraryRepository {
  final Isar isar;

  IsarLibraryRepositoryImpl(this.isar);

  @override
  Future<List<FolderEntity>> getAllFolders() async {
    return await isar.folderEntitys.where().findAll();
  }

  @override
  Future<FolderEntity> getFolderById(int id) async {
    final folder = await isar.folderEntitys.get(id);
    if (folder == null) {
      throw Exception('Folder not found');
    }
    return folder;
  }

  @override
  Future<void> addFolder(String name) async {
    final folder = FolderEntity()
      ..name = name
      ..createdAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.folderEntitys.put(folder);
    });
  }

  @override
  Future<void> renameFolder(int folderId, String newName) async {
    // need to test it
    await isar.writeTxn(() async {
      final folder = await isar.folderEntitys.get(folderId);
      if (folder == null) return;
      folder.name = newName;
      await isar.folderEntitys.put(folder);
    });
  }

  @override
  Future<void> deleteFolder(int folderId) async {
    await isar.folderEntitys.delete(folderId);
  }

  @override
  Stream<List<FolderEntity>> watchFolders() {
    return isar.folderEntitys.where().watch(fireImmediately: true);
  }

  // StreamBuilder<List<FolderEntity>>(
  //   stream: repository.watchFolders(),
  //   builder: (context, snapshot) {
  //     final folders = snapshot.data ?? [];
  //     return ListView.builder(
  //       itemCount: folders.length,
  //       itemBuilder: (_, i) => Text(folders[i].name),
  //     );
  //   },
  // );
  
  Stream<List<DeckEntity>> watchDecksByFolder(int folderId) {
    return isar.deckEntitys
        .filter()
        .folderIdEqualTo(folderId)
        .watch(fireImmediately: true);
  }
  
  @override
  Future<List<DeckEntity>> getDecksByFolder(int folderId) {
    // TODO: implement getDecksByFolder
    throw UnimplementedError();
  }
  
}
