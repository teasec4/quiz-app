import 'package:bookexample/provider/mock_data_models.dart';
import 'package:uuid/uuid.dart';

class DeckService {
  Deck createDeck(String folderId, String title) {
    return Deck(
      id: const Uuid().v4(),
      folderId: folderId,
      title: title,
      cardCount: 0,
      learnedCount: 0,
    );
  }

  FlashCard createCard(String deckId, String front, String back) {
    return FlashCard(
      id: const Uuid().v4(),
      deckId: deckId,
      front: front,
      back: back,
    );
  }
}
