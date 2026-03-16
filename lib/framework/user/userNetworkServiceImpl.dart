import 'package:app_mobile/business/models/user/authentication.dart';
import 'package:app_mobile/business/models/user/user.dart';
import 'package:app_mobile/business/services/user/userNetworkService.dart';
import 'package:app_mobile/utils/http/HttpUtils.dart';

class UserNetworkServiceImpl implements UserNetworkService {
  final String baseUrl;
  final HttpUtils httpUtils;

  UserNetworkServiceImpl({required this.baseUrl, required this.httpUtils});

  @override
  Future<User?> login(Authentication data) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
