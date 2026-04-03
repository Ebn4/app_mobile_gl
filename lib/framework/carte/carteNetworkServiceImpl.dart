import 'dart:convert';
import 'package:app_mobile/business/models/nfc/carteResponse.dart';
import 'package:app_mobile/business/models/user/authentication.dart';
import 'package:app_mobile/business/models/citizen/citizen.dart';
import 'package:app_mobile/business/services/carte/carteNetworkService.dart';
import 'package:app_mobile/framework/user/userNetworkServiceImpl.dart';
import 'package:app_mobile/framework/utils/http/localHttpUtils.dart';
import 'package:app_mobile/utils/http/HttpUtils.dart';

class CarteNetworkServiceImpl implements CarteNetworkService {
  final String baseUrl;
  final HttpUtils httpUtils;

  CarteNetworkServiceImpl({required this.baseUrl, required this.httpUtils});

  @override
  Future<CarteResponse> getCarteInfo(String cardNumber, String token) async {
    print('🌐 CarteNetworkService: getCarteInfo appelé avec: $cardNumber');

    try {
      final responseString = await httpUtils.getData(
        '$baseUrl/onip/get_active_carte_for_citoyen/$cardNumber',
        token: token,
      );

      print('📡 CarteNetworkService: Réponse API getCarteInfo: ');
      print('📄 CarteNetworkService: Body: $responseString');

      final responseData = jsonDecode(responseString);
      final carteResponse = CarteResponse.fromJson(responseData);
      print(
        '✅ CarteNetworkService: CarteResponse parsé - NNI: ${carteResponse.nni}',
      );
      return carteResponse;
    } catch (e) {
      print('💥 CarteNetworkService: Exception getCarteInfo: $e');
      throw Exception(
        'Erreur lors de la récupération des informations de la carte: $e',
      );
    }
  }

  @override
  Future<Citizen> getCitizenByNni(String nni, String token) async {
    print('🌐 CarteNetworkService: getCitizenByNni appelé avec: $nni');

    try {
      final responseString = await httpUtils.getData(
        '$baseUrl/onip/get_info_citoyen/$nni',
        token: token,
      );

      print('📡 CarteNetworkService: Réponse API getCitizenByNni: ');
      print('📄 CarteNetworkService: Body: $responseString');

      final responseData = jsonDecode(responseString);
      final citizen = Citizen.fromJson(responseData);
      print(
        '✅ CarteNetworkService: Citizen parsé - Nom: ${citizen.prenom} ${citizen.nom} ${citizen.postnom}',
      );
      return citizen;
    } catch (e) {
      print('💥 CarteNetworkService: Exception getCitizenByNni: $e');
      throw Exception(
        'Erreur lors de la récupération des informations du citoyen: $e',
      );
    }
  }
}

void main() async {
  var user = Authentication(
    email: "gais@gmail.com",
    password: "password",
    role: "agent",
    institution: "onip",
  );

  var authData = await UserNetworkServiceImpl(
    baseUrl: "http://127.0.0.1:8001",
    httpUtils: LocalHttpUtils(),
  ).login(user);

  var service = CarteNetworkServiceImpl(
    baseUrl: "http://127.0.0.1:8001",
    httpUtils: LocalHttpUtils(),
  );

  var result = await service.getCarteInfo(
    "CD-2603291902-1058973277",
    authData.token!,
  );

  var citoyen = await service.getCitizenByNni(
    "RDC-19971118-5355425621",
    authData.token!,
  );

  print("Le citoyen :  $citoyen");
}
