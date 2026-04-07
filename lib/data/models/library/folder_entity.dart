import 'package:bookexample/data/models/library/deck_entity.dart';
import 'package:isar_community/isar.dart';

part 'folder_entity.g.dart';

@collection
class FolderEntity {
  Id id = Isar.autoIncrement;

  late String name;

  late DateTime createdAt;

  @Backlink(to: 'folder')
  final decks = IsarLinks<DeckEntity>();
}
