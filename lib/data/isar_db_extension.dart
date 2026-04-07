import 'package:bookexample/data/models/library/deck_entity.dart';
import 'package:bookexample/data/models/library/flashcard_entity.dart';
import 'package:bookexample/data/models/session/study_answer_entity.dart';
import 'package:bookexample/data/models/session/study_session_entity.dart';
import 'package:isar_community/isar.dart';

extension IsarDbExtension on Isar {
  Future<List<DeckEntity>> getDecksByFolder(int folderId) async {
    return await deckEntitys.filter().folderIdEqualTo(folderId).findAll();
  }

  Future<List<FlashCardEntity>> getCardsByDeck(int deckId) async {
    return await flashCardEntitys.filter().deckIdEqualTo(deckId).findAll();
  }

  Future<List<FlashCardEntity>> getCardsByDecks(List<int> deckIds) async {
    final results = <FlashCardEntity>[];
    for (final deckId in deckIds) {
      final cards = await flashCardEntitys
          .filter()
          .deckIdEqualTo(deckId)
          .findAll();
      results.addAll(cards);
    }
    return results;
  }

  Stream<List<DeckEntity>> watchDecksByFolder(int folderId) {
    return deckEntitys
        .filter()
        .folderIdEqualTo(folderId)
        .watch(fireImmediately: true);
  }

  Future<void> loadDeckLinks(DeckEntity deck) async {
    await deck.cards.load();
    await deck.folder.load();
  }

  Future<void> loadSessionLinks(StudySessionEntity session) async {
    await session.answers.load();
  }

  Future<void> saveDeckLinks(DeckEntity deck) async {
    await deck.cards.save();
    await deck.folder.save();
  }

  Future<void> saveSessionLinks(StudySessionEntity session) async {
    await session.answers.save();
  }

  Future<void> saveCardLinks(FlashCardEntity card) async {
    await card.deck.save();
  }

  Future<void> saveAnswerLinks(StudyAnswerEntity answer) async {
    await answer.session.save();
  }
}
