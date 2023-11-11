import '../../databases/object_db/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  Store? _store;
  String? directory;

  static final _instance = ObjectBox._init();

  ObjectBox._init();

  factory ObjectBox() {
    return _instance;
  }

  Future<Store> get store async {
    _store ??= await openStore(directory: directory);
    return _store!;
  }
}
