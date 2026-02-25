
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:isar_community/isar.dart';

@collection
class DeckEntity {
  Id id = Isar.autoIncrement;

  late String title;

  final folder = IsarLink<FolderEntity>();
  final cards = IsarLinks<FlashCardEntity>();
}