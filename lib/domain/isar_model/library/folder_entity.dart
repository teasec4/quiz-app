
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:isar_community/isar.dart';

@collection
class FolderEntity {
  Id id = Isar.autoIncrement;

  late String name;

  final decks = IsarLinks<DeckEntity>();
}