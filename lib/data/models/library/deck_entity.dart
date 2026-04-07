import 'package:bookexample/data/models/library/flashcard_entity.dart';
import 'package:bookexample/data/models/library/folder_entity.dart';
import 'package:isar_community/isar.dart';

part 'deck_entity.g.dart';

@collection
class DeckEntity {
  Id id = Isar.autoIncrement;

  late String title;

  late DateTime createdAt;

  @Index()
  late int folderId;

  final folder = IsarLink<FolderEntity>();

  @Backlink(to: 'deck')
  final cards = IsarLinks<FlashCardEntity>();
}
