import 'package:path/path.dart' as p;
import 'package:object_box/object_box.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxProvider {
  /// The Store of this app.
  late final Store _store;
  late final shopOrdersBox = _store.box<ShopOrderEntity>();

  // late SyncClient _syncClient;

  // TODO : boxes here

  ObjectBoxProvider._create(this._store) {
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

  int putOrder(ShopOrderEntity entity) {
    return _store.box<ShopOrderEntity>().put(entity);
  }

  bool removeOrder(int id) {
    return _store.box<ShopOrderEntity>().remove(id);
  }

  /// fails if id not found
  int updateOrder(ShopOrderEntity entity) {
    return _store.box<ShopOrderEntity>().put(entity, mode: PutMode.update);
  }

  ShopOrderEntity? getOrder(int id) {
    return _store.box<ShopOrderEntity>().get(id);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxProvider> create() async {
    final docsDir = await getApplicationDocumentsDirectory();

    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(
      directory: p.join(docsDir.path, "obx-example"),
    );

    return ObjectBoxProvider._create(store);
  }

  void dispose() {
    _store.close();
    // _syncClient.close();
  }
}
