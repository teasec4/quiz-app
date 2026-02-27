class StudySessionDraft {
  // final DateTime endedAt;
  final List<AnswerDraft> answers = [];

  void addAnswer(int cardId, bool isCorrect) {
    answers.add(AnswerDraft(
      cardId: cardId,
      isCorrect: isCorrect
    ));
  }
}

class AnswerDraft {
  final int cardId;
  final bool isCorrect;

  AnswerDraft({required this.cardId, required this.isCorrect});
}
