// UserProvider (Future)
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:provider_future_stream/model/user.dart';

class UserProvider {
  final String _dataPath = "assets/data/users.json";
  List<User> users;
 
  Future<List<User>> loadUserData( ) async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    print('done loading user!' + jsonEncode(users));
    return users;
  }
 
  Future<String> loadAsset() async {
    return await Future.delayed(Duration(seconds: 10), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }
}