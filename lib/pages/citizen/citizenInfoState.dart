import 'package:app_mobile/business/models/institution/transportModel.dart';
import 'package:app_mobile/business/models/institution/justiceModel.dart';
import 'package:app_mobile/business/models/institution/etudeModel.dart';
import 'package:app_mobile/business/models/institution/onipModel.dart';
import 'package:app_mobile/business/models/institution/cnssModel.dart';
import 'package:app_mobile/business/models/institution/communeModel.dart';

class CitizenInfoState {
  final bool isLoading;
  final String? error;
  final TransportModel? transportInfo;
  final JusticeModel? justiceInfo;
  final EtudeModel? etudeInfo;
  final OnipModel? onipInfo;
  final CnssModel? cnssInfo;
  final CommuneModel? communeInfo;

  const CitizenInfoState({
    this.isLoading = false,
    this.error,
    this.transportInfo,
    this.justiceInfo,
    this.etudeInfo,
    this.onipInfo,
    this.cnssInfo,
    this.communeInfo,
  });

  CitizenInfoState copyWith({
    bool? isLoading,
    String? error,
    TransportModel? transportInfo,
    JusticeModel? justiceInfo,
    EtudeModel? etudeInfo,
    OnipModel? onipInfo,
    CnssModel? cnssInfo,
    CommuneModel? communeInfo,
  }) {
    return CitizenInfoState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      transportInfo: transportInfo ?? this.transportInfo,
      justiceInfo: justiceInfo ?? this.justiceInfo,
      etudeInfo: etudeInfo ?? this.etudeInfo,
      onipInfo: onipInfo ?? this.onipInfo,
      cnssInfo: cnssInfo ?? this.cnssInfo,
      communeInfo: communeInfo ?? this.communeInfo,
    );
  }
}
