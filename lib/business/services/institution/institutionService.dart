import 'package:app_mobile/business/models/institution/transportModel.dart';
import 'package:app_mobile/business/models/institution/justiceModel.dart';
import 'package:app_mobile/business/models/institution/etudeModel.dart';
import 'package:app_mobile/business/models/institution/onipModel.dart';
import 'package:app_mobile/business/models/institution/cnssModel.dart';
import 'package:app_mobile/business/models/institution/communeModel.dart';

abstract class InstitutionService {
  Future<TransportModel?> getTransportInfo(String nni,String token);
  Future<JusticeModel?> getJusticeInfo(String nni, int idCitoyen,String token);
  Future<EtudeModel?> getEtudeInfo(String nni,String token);
  Future<OnipModel?> getOnipInfo(String nni,String token);
  Future<CnssModel?> getCnssInfo(String nni,String token);
  Future<CommuneModel?> getCommuneInfo(String nni,String token);
}
