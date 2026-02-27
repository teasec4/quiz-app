import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:isar_community/isar.dart';

part 'flashcard_entity.g.dart';

@collection
class FlashCardEntity {
  Id id = Isar.autoIncrement;

  late String front;
  late String back;

  late DateTime createdAt;

  @Index()
  late int deckId;
  
  bool isLearned = false;
  
  final deck = IsarLink<DeckEntity>();
}
