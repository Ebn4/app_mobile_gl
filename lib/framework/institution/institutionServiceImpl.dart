import 'dart:convert';
import 'package:app_mobile/business/models/institution/transportModel.dart';
import 'package:app_mobile/business/models/institution/justiceModel.dart';
import 'package:app_mobile/business/models/institution/etudeModel.dart';
import 'package:app_mobile/business/models/institution/onipModel.dart';
import 'package:app_mobile/business/models/institution/cnssModel.dart';
import 'package:app_mobile/business/models/institution/communeModel.dart';
import 'package:app_mobile/business/models/user/authentication.dart';
import 'package:app_mobile/business/services/institution/institutionService.dart';
import 'package:app_mobile/framework/user/userNetworkServiceImpl.dart';
import 'package:app_mobile/framework/utils/http/localHttpUtils.dart';
import 'package:app_mobile/utils/http/HttpUtils.dart';

class InstitutionServiceImpl implements InstitutionService {
  final String baseUrl;
  final HttpUtils httpUtils;

  InstitutionServiceImpl({required this.baseUrl, required this.httpUtils});

  @override
  Future<TransportModel?> getTransportInfo(String nni, String token) async {
    try {
      final responseString = await httpUtils.getData(
        '$baseUrl/transport/get_permis/$nni',
        token: token,
      );
      final responseData = jsonDecode(responseString);
      return TransportModel.fromJson(responseData);
    } catch (e) {
      print('Erreur récupération infos transport: $e');
      return null;
    }
  }

  @override
  Future<JusticeModel?> getJusticeInfo(
    String nni,
    int idCitoyen,
    String token,
  ) async {
    try {
      final responseString = await httpUtils.getData(
        '$baseUrl/justice/get_all_casier_for_person?nni=$nni&id=$idCitoyen',
        token: token,
      );
      final responseData = jsonDecode(responseString);
      return JusticeModel.fromJson(responseData);
    } catch (e) {
      print('Erreur récupération infos justice: $e');
      return null;
    }
  }

  @override
  Future<EtudeModel?> getEtudeInfo(String nni, String token) async {
    try {
      final responseString = await httpUtils.getData(
        '$baseUrl/etude/get_all_carte_etudiant/$nni',
        token: token,
      );
      final responseData = jsonDecode(responseString);
      return EtudeModel.fromJson(responseData);
    } catch (e) {
      print('Erreur récupération infos étude: $e');
      return null;
    }
  }

  @override
  Future<OnipModel?> getOnipInfo(String nni, String token) async {
    try {
      // Récupérer l'adresse
      final adresseResponse = await httpUtils.getData(
        '$baseUrl/onip/get_adresse_citoyen/$nni',
        token: token,
      );
      final adresseData = jsonDecode(adresseResponse);

      // Récupérer la photo passeport
      final photoResponse = await httpUtils.getData(
        '$baseUrl/onip/get_photo_passeport/$nni',
      );
      final photoData = jsonDecode(photoResponse);

      return OnipModel.fromJson({
        'adresse': adresseData,
        'photo_passeport': photoData,
      });
    } catch (e) {
      print('Erreur récupération infos ONIP: $e');
      return null;
    }
  }

  @override
  Future<CnssModel?> getCnssInfo(String nni, String token) async {
    try {
      final responseString = await httpUtils.getData(
        '$baseUrl/cnss/get_assure_by_nni/$nni',
        token: token,
      );
      final responseData = jsonDecode(responseString);
      return CnssModel.fromJson(responseData);
    } catch (e) {
      print('Erreur récupération infos CNSS: $e');
      return null;
    }
  }

  @override
  Future<CommuneModel?> getCommuneInfo(String nni, String token) async {
    try {
      final responseString = await httpUtils.getData(
        '$baseUrl/commune/get_acte-naissance_by_nni/$nni',
        token: token,
      );
      final responseData = jsonDecode(responseString);
      return CommuneModel.fromJson(responseData);
    } catch (e) {
      print('Erreur récupération infos commune: $e');
      return null;
    }
  }
}

void main() async {
  final user = Authentication(
    email: "test@gmail.com",
    password: "password",
    role: "agent",
    institution: "transport",
  );

  var auth = await UserNetworkServiceImpl(
    baseUrl: "http://127.0.0.1:8000",
    httpUtils: LocalHttpUtils(),
  ).login(user);

  var service = await InstitutionServiceImpl(
    baseUrl: "http://127.0.0.1:8000",
    httpUtils: LocalHttpUtils(),
  ).getTransportInfo("RDC-19971118-5355425621", auth.token!);
  print(service);
}
