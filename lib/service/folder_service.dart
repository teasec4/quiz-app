import 'package:bookexample/provider/helper.dart';
import 'package:bookexample/provider/mock_data_models.dart';

class FolderService {
  
  Future<Folder> createFolder(String name) async {
    return Folder(
      id: Helper.generateId(),
      name: name,
      deckIds: [],
    );
  }
}


