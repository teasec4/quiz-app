import 'package:bookexample/provider/mock_data_models.dart';
import 'package:uuid/uuid.dart';

class FolderService {
  
  Folder createFolder(String name) {
    return Folder(
      id: Uuid().v4(),
      name: name,
      deckIds: [],
    );
  }
  
  // List<Deck> getDecks(){
    
  // }
}


