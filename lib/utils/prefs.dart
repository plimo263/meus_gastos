import 'package:shared_preferences/shared_preferences.dart';

/// Classe com metodos para acesso aos dados no shared preferences.
class Prefs {
  final initLoad = 'INIT_LOAD';

  Prefs();

  Future<bool> isLoadInit() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(initLoad);
    if (value != null) {
      return value;
    }
    return false;
  }

  // Diz que foi feita a primeira carga no sistema.
  Future<void> setLoadInit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(initLoad, true);
  }
}
