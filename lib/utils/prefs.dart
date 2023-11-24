import 'package:shared_preferences/shared_preferences.dart';

/// Classe com metodos para acesso aos dados no shared preferences.
class Prefs {
  final initLoad = 'INIT_LOAD';

  Prefs();

  Future<bool> isLoadInit(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? value = prefs.getStringList(initLoad);
    if (value != null && value.contains(uid)) {
      return true;
    }
    return false;
  }

  // Diz que foi feita a primeira carga no sistema.
  Future<void> setLoadInit(String uid) async {
    final List<String> uidsAuth = [];
    final prefs = await SharedPreferences.getInstance();
    final List<String>? value = prefs.getStringList(initLoad);

    if (value != null) {
      uidsAuth.addAll(value);
    }

    if (!uidsAuth.contains(uid)) {
      uidsAuth.add(uid);
    }

    await prefs.setStringList(initLoad, uidsAuth);
  }
}
