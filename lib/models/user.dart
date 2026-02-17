import 'package:shared_preferences/shared_preferences.dart';

class User {
  static const String _isUserSubscribedKey = 'isUserSubscribed';

  bool isSubscribed;

  User({this.isSubscribed = false});

  static Future<User> fromSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final isSubscribed =
        sharedPreferences.getBool(_isUserSubscribedKey) ?? false;
    return User(isSubscribed: isSubscribed);
  }

  Future<void> setSubscribed(bool value) async {
    isSubscribed = value;
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(_isUserSubscribedKey, value);
  }
}
