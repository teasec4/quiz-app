import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';

class StudySessionDraft {
  final List<FlashCardEntity> cards;
  final List<AnswerDraft> answers = [];
  int currentIndex = 0;
  int correctCount = 0;
  int incorrectCount = 0;
  
  StudySessionDraft(this.cards);

  void addAnswer(int cardId, bool isCorrect) {
    answers.add(AnswerDraft(
      cardId: cardId,
      isCorrect: isCorrect
    ));
  }
  
  factory StudySessionDraft.fromCards(List<FlashCardEntity> cards) {
    final shuffled = List<FlashCardEntity>.from(cards)..shuffle();
    return StudySessionDraft(shuffled);
  }
  
  FlashCardEntity? get currentCard {
    if (currentIndex >= cards.length) return null;
    return cards[currentIndex];
  }
  
  void answerCurrent(bool isCorrect) {
    final card = currentCard;
    if (card == null) return;

    answers.add(
      AnswerDraft(
        cardId: card.id,
        isCorrect: isCorrect,
      ),
    );

    currentIndex++;
  }
  
  bool get isFinished => currentIndex >= cards.length;
}

class AnswerDraft {
  final int cardId;
  final bool isCorrect;

  AnswerDraft({required this.cardId, required this.isCorrect});
}
