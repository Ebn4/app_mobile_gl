import 'dart:convert';

import 'package:app_mobile/business/models/user/user.dart';
import 'package:app_mobile/business/services/user/userLocalService.dart';
import 'package:app_mobile/utils/localManager.dart';

class UserLocalServiceImpl implements UserLocalService{

  LocalManager? box;

  UserLocalServiceImpl({
    this.box
  });

  @override
  Future<bool> clearUser() async{
    await box?.deleteData("user");
    return true;
  }

  @override
  Future<User?> getUser() async{
    var data = await box?.readData("user");
    return data != null ? User.fromJson(jsonDecode(data)) : null;
  }

  @override
  Future<bool> saveUser(User user) async {
    await box?.writeData("user", jsonEncode(user.toJson()));
    return true;
  }
  
}