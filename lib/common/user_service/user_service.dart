import 'package:meta/meta.dart';
import 'package:sweet_corn_app/common/user_service/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static User user;

  String get token => user?.token;

  Future<void> logout() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('uuiod');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('token');
  }

  Future<void> save({
    @required String uuid,
    @required String name,
    @required String email,
    @required String token,
  }) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('uuid', uuid);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('token', token);
  }

  Future<User> read() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    final uuid = prefs.getString('uuid');
    final name = prefs.getString('name');
    final email = prefs.getString('email');
    final token = prefs.getString('token');

    if (token == null) return null;
    return User(uuid: uuid, name: name, email: email, token: token);
  }
}
