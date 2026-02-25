class FlashCard {
  final String id;
  final String deckId;
  final String front;
  final String back;
  final bool isLearned;

  FlashCard({
    required this.id,
    required this.deckId,
    required this.front,
    required this.back,
    this.isLearned = false,
  });

  FlashCard copyWith({
    String? deckId,
    String? front,
    String? back,
    bool? isLearned,
  }) {
    return FlashCard(
      id: id,
      deckId: deckId ?? this.deckId,
      front: front ?? this.front,
      back: back ?? this.back,
      isLearned: isLearned ?? this.isLearned,
    );
  }
}