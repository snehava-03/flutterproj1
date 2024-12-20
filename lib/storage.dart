import 'dart:convert';

import 'package:local_storage/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService{
  // to save the data to prefs
  Future<void> saveUsers(List<User>users)  async{
    final prefs =await SharedPreferences.getInstance();
    // converting data to json to list the store into userJsonList
    final List<String> userJsonList =
    users.map((user) => jsonEncode(user.toJson())).toList();
    // storing the above userJsonList into user which is the key like the format of key value pair
    await prefs.setStringList('users', userJsonList);
  }

  // to get the user
  Future<List<User>> getUsers() async{
    final prefs = await SharedPreferences.getInstance();
    final List<String>? userJsonList = prefs.getStringList('users');

    if(userJsonList == null){
      return [];
    }else{
      return userJsonList.map((jsonString)=>
      User.fromJson(jsonDecode(jsonString))).toList();
    }
    }
    // to remove a particular user
    Future<void>removeUser(String email) async{
      final prefs = await SharedPreferences.getInstance();
      final List<String>? userJsonList = prefs.getStringList('users');

      if(userJsonList != null){
        final List<User> users =userJsonList
        .map((jsonString) => User.fromJson(jsonDecode(jsonString)))
        .toList();
      users.removeWhere((user) => user.email == email);
      await saveUsers(users);
      }   
      
   }
   // to remove all users
   Future<void> clearUsers() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('users');
   }
  }

