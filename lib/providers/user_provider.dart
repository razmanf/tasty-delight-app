import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _firstName = "";
  String _lastName = "";

  String get firstName => _firstName;
  String get lastName => _lastName;

  void setUser(String firstName, String lastName) {
    _firstName = firstName;
    _lastName = lastName;
    notifyListeners();
  }

  void logout() {
    _firstName = "";
    _lastName = "";
    notifyListeners();
  }
}