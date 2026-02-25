class FlashCard {
  final String id;
  final String deckId;
  final String front;
  final String back;

  FlashCard({
    required this.id,
    required this.deckId,
    required this.front,
    required this.back,
  });

  FlashCard copyWith({
    String? deckId,
    String? front,
    String? back,
  }) {
    return FlashCard(
      id: id,
      deckId: deckId ?? this.deckId,
      front: front ?? this.front,
      back: back ?? this.back,
    );
  }
}