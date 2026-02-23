import 'package:bookexample/provider/mock_data_models.dart';
import 'package:uuid/uuid.dart';

class FolderService {
  
  Future<Folder> createFolder(String name) async {
    return Folder(
      id: Uuid().v4(),
      name: name,
      deckIds: [],
    );
  }
}


