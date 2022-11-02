import 'package:path/path.dart' as p;
import 'package:object_box/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  // late SyncClient _syncClient;

  // TODO : boxes here

  ObjectBox._create(this.store) {
    // TODO : create boxes

    /*if (Sync.isAvailable()) {
      _syncClient = Sync.client(
        store,
        Platform.isAndroid ? 'ws://10.0.2.2:9999' : 'ws://127.0.0.1:9999',
        SyncCredentials.none(),
      );
      _syncClient.start();
    }*/

    // TODO : demo data here
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();

    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(
      directory: p.join(docsDir.path, "obx-example"),
    );

    return ObjectBox._create(store);
  }

  void dispose() {
    store.close();
    // _syncClient.close();
  }
}
