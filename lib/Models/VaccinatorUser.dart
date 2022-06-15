import 'package:firebase_database/firebase_database.dart';

class VaccinatorUser {
  String? _uid;
  String? _email;
  String? _password;
  String? _name;

  VaccinatorUser(this._email, this._password, this._name);

  String get uid => _uid ?? '';

  set uid(String value) {
    _uid = value;
  }

  VaccinatorUser.fromSnapshort(DataSnapshot dataSnapshot) {
    _uid = (dataSnapshot.value! as Map)['uid'].toString();
    _email = (dataSnapshot.value! as Map)['email'];
    _password = (dataSnapshot.value! as Map)['password'];
    _name = (dataSnapshot.value! as Map)['name'];
  }

  Map<String, String> getMapOf() {
    Map<String, String> map = {
      'uid': uid,
      'email': email,
      'password': password,
      'name': name
    };

    return map;
  }

  String get email => _email ?? '';

  set email(String value) {
    _email = value;
  }

  String get password => _password ?? '';

  set password(String value) {
    _password = value;
  }

  String get name => _name ?? '';

  set name(String value) {
    _name = value;
  }
}
