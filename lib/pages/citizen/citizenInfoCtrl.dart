import 'package:app_mobile/business/models/user/user.dart';
import 'package:app_mobile/business/models/citizen/citizen.dart';
import 'package:app_mobile/business/services/institution/institutionService.dart';
import 'package:app_mobile/main.dart';
import 'package:app_mobile/pages/citizen/citizenInfoState.dart';
import 'package:app_mobile/pages/intro/appCtrl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CitizenInfoCtrl extends StateNotifier<CitizenInfoState> {
  final InstitutionService institutionService;
  final Ref ref;

  CitizenInfoCtrl({required this.ref, required this.institutionService})
    : super(const CitizenInfoState());

  Future<void> loadCitizenInfo(
    Citizen citizen,
    String agentInstitution,
    String citizenNni,
  ) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Récupérer le token de l'agent connecté
      final appState = ref.read(appCtrlProvider);
      final agentToken = appState.user?.token;

      if (agentToken == null) {
        throw Exception('Token de l\'agent non disponible');
      }

      // Récupérer les informations institutionnelles selon l'institution de l'agent
      switch (agentInstitution.toLowerCase()) {
        case 'transport':
          final transportInfo = await institutionService.getTransportInfo(
            citizenNni,
            agentToken,
          );
          state = state.copyWith(
            isLoading: false,
            transportInfo: transportInfo,
          );
          break;

        case 'justice':
          final justiceInfo = await institutionService.getJusticeInfo(
            citizenNni,
            0,
            agentToken,
          );
          state = state.copyWith(isLoading: false, justiceInfo: justiceInfo);
          break;

        case 'etude':
          final etudeInfo = await institutionService.getEtudeInfo(
            citizenNni,
            agentToken,
          );
          state = state.copyWith(isLoading: false, etudeInfo: etudeInfo);
          break;

        case 'onip':
          final onipInfo = await institutionService.getOnipInfo(
            citizenNni,
            agentToken,
          );
          state = state.copyWith(isLoading: false, onipInfo: onipInfo);
          break;

        case 'cnss':
          final cnssInfo = await institutionService.getCnssInfo(
            citizenNni,
            agentToken,
          );
          state = state.copyWith(isLoading: false, cnssInfo: cnssInfo);
          break;

        case 'commune':
          final communeInfo = await institutionService.getCommuneInfo(
            citizenNni,
            agentToken,
          );
          state = state.copyWith(isLoading: false, communeInfo: communeInfo);
          break;

        default:
          state = state.copyWith(isLoading: false);
          break;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = const CitizenInfoState();
  }
}

final citizenInfoCtrlProvider =
    StateNotifierProvider<CitizenInfoCtrl, CitizenInfoState>((ref) {
      return CitizenInfoCtrl(
        ref: ref,
        institutionService: getIt.get<InstitutionService>(),
      );
    });
