import 'package:app_mobile/business/models/user/authentication.dart';
import 'package:app_mobile/business/models/user/user.dart';

abstract class UserNetworkService {
  Future<User?> login(Authentication data);
}
