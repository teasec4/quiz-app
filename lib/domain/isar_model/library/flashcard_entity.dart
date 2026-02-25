
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:isar_community/isar.dart';

@collection
class FlashCardEntity {
  Id id = Isar.autoIncrement;

  late String front;
  late String back;

  final deck = IsarLink<DeckEntity>();
}