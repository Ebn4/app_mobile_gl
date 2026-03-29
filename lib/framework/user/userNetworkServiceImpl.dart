import 'dart:convert';
import 'package:app_mobile/business/models/user/authentication.dart';
import 'package:app_mobile/business/models/user/user.dart';
import 'package:app_mobile/business/services/user/userNetworkService.dart';
import 'package:app_mobile/framework/utils/http/localHttpUtils.dart';
import 'package:app_mobile/utils/http/HttpRequestException.dart';
import 'package:app_mobile/utils/http/HttpUtils.dart';

class UserNetworkServiceImpl implements UserNetworkService {
  final String baseUrl;
  final HttpUtils httpUtils;
  

  UserNetworkServiceImpl({required this.baseUrl, required this.httpUtils});

  @override
  Future<User> login(Authentication data) async {
    try {
      // Envoi la requête
      final responseString = await httpUtils.postData(
        '$baseUrl/authentification/login',
        body: data.toJson(),
      );

      // Parser la réponse JSON
      final responseData = jsonDecode(responseString);

      // Vérifie si la réponse contient un token
      if (responseData["access_token"] == null) {
        throw Exception("Login échoué : aucun token reçu");
      }

      // Récupère l'utilisateur courant
      final user = await getCurrentUser(responseData["access_token"]);

      // Crée l'objet User avec token
      final userWithToken = User(
        id_admin: user.id_admin,
        username: user.username,
        email: user.email,
        fullname: user.fullname,
        role: user.role,
        institution: user.institution,
        token: responseData["access_token"],
      );

      return userWithToken;

    } on HttpRequestException catch (e) {
      // Si l'API renvoie une erreur HTTP (ex: 422, 401, 404)
      final statusCode = e.statusCode;
      final message = e.message;

      // Tu peux personnaliser les messages selon le code
      switch (statusCode) {
        case 401:
          throw Exception("Identifiants incorrects");
        case 422:
          throw Exception("Données invalides : $message");
        case 404:
          throw Exception("Endpoint introuvable : $message");
        default:
          throw Exception("Erreur $statusCode : $message");
      }
    } catch (e) {
      // Autres erreurs (JSON invalide, etc.)
      throw Exception("Erreur lors du login : ${e.toString()}");
    }
  }

  @override
  Future<User> getCurrentUser(String token) async {
    final responseString = await httpUtils.getData(
      '$baseUrl/authentification/me',
      headers: {'Authorization': 'Bearer $token'},
    );

    // Parser la réponse JSON
    final responseData = jsonDecode(responseString);
    return User.fromJson(responseData);
  }
}

void main() async {
  var user = Authentication(
    username: 'bertoli',
    password: 'password',
    role: 'agent',
    institution: 'onip',
  );
  var service = UserNetworkServiceImpl(
    baseUrl: 'http://127.0.0.1:8000',
    httpUtils: LocalHttpUtils(),
  );
  var result = await service.login(user);
  print(result);
  // var userData = await service.getCurrentUser(result.accessToken);
  // print(userData);
}
