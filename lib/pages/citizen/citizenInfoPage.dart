import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../../pages/intro/appCtrl.dart';
import '../../pages/citizen/citizenInfoCtrl.dart';
import '../../pages/citizen/citizenInfoState.dart';
import '../../business/models/institution/transportModel.dart';
import '../../business/models/institution/justiceModel.dart';
import '../../business/models/institution/etudeModel.dart';
import '../../business/models/institution/onipModel.dart';
import '../../business/models/institution/cnssModel.dart';
import '../../business/models/institution/communeModel.dart';

class CitizenInfoPage extends ConsumerWidget {
  final Map<String, dynamic> citizenData;
  final String cardNumber;
  final String nni;
  final String scanType;

  // Couleurs principales du thème
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1E293B);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color purpleAccent = Color(0xFF8B5CF6);
  static const Color redAccent = Color(0xFFEF4444);

  // Liste des institutions
  static const List<String> institutions = [
    'ONIP - Office National des Impôts et Patentes',
    'CNSS - Caisse Nationale de Sécurité Sociale',
    'Commune - Services municipaux',
    'DGI - Direction Générale des Impôts',
    'DGM - Direction Générale des Douanes',
    'Études - Services d\'études administratives',
    'Justice - Système judiciaire',
    'Santé - Services de santé',
    'Transport - Services de transport',
  ];

  const CitizenInfoPage({
    super.key,
    required this.citizenData,
    required this.cardNumber,
    required this.nni,
    this.scanType = 'nfc',
  });

  Map<String, String> _getRelevantFields(String institution) {
    switch (institution) {
      case 'ONIP - Office National des Impôts et Patentes':
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Email': citizenData['email'] ?? 'N/A',
          'Téléphone': citizenData['telephone'] ?? 'N/A',
          'Date d\'enregistrement': citizenData['date_enregistrement'] ?? 'N/A',
        };
      case 'CNSS - Caisse Nationale de Sécurité Sociale':
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Téléphone': citizenData['telephone'] ?? 'N/A',
          'Nom du père': citizenData['nom_pere'] ?? 'N/A',
          'Nom de la mère': citizenData['nom_mere'] ?? 'N/A',
        };
      case 'Commune - Services municipaux':
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Téléphone': citizenData['telephone'] ?? 'N/A',
          'Email': citizenData['email'] ?? 'N/A',
          'Nom du père': citizenData['nom_pere'] ?? 'N/A',
          'Nom de la mère': citizenData['nom_mere'] ?? 'N/A',
        };
      case 'DGI - Direction Générale des Impôts':
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Email': citizenData['email'] ?? 'N/A',
          'Téléphone': citizenData['telephone'] ?? 'N/A',
          'Date d\'enregistrement': citizenData['date_enregistrement'] ?? 'N/A',
        };
      case 'DGM - Direction Générale des Douanes':
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Téléphone': citizenData['telephone'] ?? 'N/A',
          'Nom du père': citizenData['nom_pere'] ?? 'N/A',
          'Nom de la mère': citizenData['nom_mere'] ?? 'N/A',
        };
      case 'Études - Services d\'études administratives':
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Email': citizenData['email'] ?? 'N/A',
          'Date d\'enregistrement': citizenData['date_enregistrement'] ?? 'N/A',
        };
      case 'Justice - Système judiciaire':
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Nom du père': citizenData['nom_pere'] ?? 'N/A',
          'Nom de la mère': citizenData['nom_mere'] ?? 'N/A',
        };
      case 'Santé - Services de santé':
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Téléphone': citizenData['telephone'] ?? 'N/A',
          'Nom du père': citizenData['nom_pere'] ?? 'N/A',
          'Nom de la mère': citizenData['nom_mere'] ?? 'N/A',
        };
      case 'Transport - Services de transport':
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Téléphone': citizenData['telephone'] ?? 'N/A',
        };
      default:
        return {
          'Nom complet':
              '${citizenData['prenom'] ?? ''} ${citizenData['nom'] ?? ''} ${citizenData['postnom'] ?? ''}',
          'NNI': nni,
          'Numéro de carte': cardNumber,
          'Sexe': citizenData['sexe']?.toUpperCase() ?? 'N/A',
          'Date de naissance': citizenData['date_de_naissance'] ?? 'N/A',
          'Lieu de naissance': citizenData['lieu_de_naissance'] ?? 'N/A',
          'Email': citizenData['email'] ?? 'N/A',
          'Téléphone': citizenData['telephone'] ?? 'N/A',
        };
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appCtrlProvider.select((state) => state.user));
    final currentInstitution = user?.institution ?? institutions.first;
    final relevantFields = _getRelevantFields(currentInstitution);
    final citizenInfoState = ref.watch(citizenInfoCtrlProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // AppBar personnalisée
          SliverAppBar(
            expandedHeight: 200,
            floating: true,
            pinned: true,
            backgroundColor: primaryBlue,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(currentInstitution),
              collapseMode: CollapseMode.parallax,
            ),
            leading: Container(
              margin: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () => _showMenuOptions(context),
                ),
              ),
            ],
          ),

          // Contenu principal
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Badge de scan
                _buildScanBadge(),
                const SizedBox(height: 16),

                // Carte principale
                _buildInfoCard(relevantFields),
                const SizedBox(height: 16),

                // Informations institutionnelles
                _buildInstitutionalInfo(currentInstitution, citizenInfoState),
                const SizedBox(height: 16),

                // Boutons d'action
                _buildActionButtons(context),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstitutionalInfo(
    String agentInstitution,
    dynamic citizenInfoState,
  ) {
    if (citizenInfoState is! CitizenInfoState) {
      return const SizedBox.shrink();
    }

    final state = citizenInfoState as CitizenInfoState;

    if (state.isLoading) {
      return _buildSectionCard(
        'Chargement...',
        Icons.hourglass_empty,
        primaryBlue,
        [
          Container(
            height: 60,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(color: primaryBlue),
          ),
        ],
      );
    }

    if (state.error != null) {
      return _buildSectionCard('Erreur', Icons.error, redAccent, [
        Text(
          state.error!,
          style: const TextStyle(fontSize: 14, color: redAccent),
        ),
      ]);
    }

    // Afficher les informations selon l'institution
    switch (agentInstitution.toLowerCase()) {
      case 'transport':
        if (state.transportInfo != null) {
          final transport = state.transportInfo!;
          return _buildSectionCard(
            'Informations de Transport',
            Icons.directions_car,
            primaryBlue,
            [
              Text(
                'Numéro de permis: ${transport.numero_permis}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryDark,
                ),
              ),
              Text(
                'Date de délivrance: ${transport.date_delivrance}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryDark,
                ),
              ),
              Text(
                'Lieu de délivrance: ${transport.lieu_delivrance}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryDark,
                ),
              ),
              Text(
                'Catégorie: ${transport.id_categorie}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryDark,
                ),
              ),
              Text(
                'Date d\'expiration: ${transport.date_expiration}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryDark,
                ),
              ),
              Text(
                'Statut: ${transport.statut}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryDark,
                ),
              ),
            ],
          );
        }
        break;

      case 'justice':
        if (state.justiceInfo != null) {
          final justice = state.justiceInfo!;
          return _buildSectionCard(
            'Informations Judiciaires',
            Icons.gavel,
            purpleAccent,
            [
              if (justice.casiers.isEmpty)
                const Text(
                  'Aucun casier judiciaire',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryDark,
                  ),
                )
              else
                ...justice.casiers.map(
                  (casier) => Text(
                    'Casier: ${casier.numero_casier ?? ''} - ${casier.nature_infraction ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
                ),
            ],
          );
        }
        break;

      case 'etude':
        if (state.etudeInfo != null) {
          final etude = state.etudeInfo!;
          return _buildSectionCard(
            'Informations Étudiantes',
            Icons.school,
            warningOrange,
            [
              if (etude.cartes.isEmpty)
                const Text(
                  'Aucune carte trouvée',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryDark,
                  ),
                )
              else
                ...etude.cartes.map(
                  (carte) => Text(
                    'Carte: ${carte.numero_carte ?? ''} - ${carte.etablissement ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
                ),
            ],
          );
        }
        break;

      case 'onip':
        if (state.onipInfo != null) {
          final onip = state.onipInfo!;
          return Column(
            children: [
              if (onip.adresse != null)
                _buildSectionCard('Adresse', Icons.location_on, primaryBlue, [
                  Text(
                    'Province: ${onip.adresse!.province ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
                  Text(
                    'Ville: ${onip.adresse!.ville ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
                  Text(
                    'Commune: ${onip.adresse!.commune ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
                ]),
              const SizedBox(height: 16),
              if (onip.photo_passeport != null)
                _buildSectionCard(
                  'Photo Passeport',
                  Icons.photo_camera,
                  successGreen,
                  [
                    if (onip.photo_passeport!.url_photo != null)
                      Text(
                        'URL: ${onip.photo_passeport!.url_photo ?? ''}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryDark,
                        ),
                      ),
                  ],
                ),
            ],
          );
        }
        break;

      case 'cnss':
        if (state.cnssInfo != null) {
          final cnss = state.cnssInfo!;
          return _buildSectionCard(
            'Informations CNSS',
            Icons.security,
            primaryBlue,
            [
              if (cnss.numero_assure != null)
                Text(
                  'Numéro d\'assuré: ${cnss.numero_assure ?? ''}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryDark,
                  ),
                ),
              if (cnss.date_affiliation != null)
                Text(
                  'Date d\'affiliation: ${cnss.date_affiliation ?? ''}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryDark,
                  ),
                ),
              if (cnss.statut_cotisation != null)
                Text(
                  'Statut de cotisation: ${cnss.statut_cotisation ?? ''}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryDark,
                  ),
                ),
            ],
          );
        }
        break;

      case 'commune':
        if (state.communeInfo != null) {
          final commune = state.communeInfo!;
          return _buildSectionCard(
            'Acte de Naissance',
            Icons.description,
            purpleAccent,
            [
              if (commune.acte_naissance != null) ...[
                if (commune.acte_naissance!.numero_acte != null)
                  Text(
                    'Numéro d\'acte: ${commune.acte_naissance!.numero_acte ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
                if (commune.acte_naissance!.date_naissance != null)
                  Text(
                    'Date de naissance: ${commune.acte_naissance!.date_naissance ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
                if (commune.acte_naissance!.lieu_naissance != null)
                  Text(
                    'Lieu de naissance: ${commune.acte_naissance!.lieu_naissance ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
              ] else
                const Text(
                  'Aucun acte trouvé',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryDark,
                  ),
                ),
            ],
          );
        }
        break;
    }

    return const SizedBox.shrink();
  }

  Widget _buildHeader(String institution) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryBlue, purpleAccent],
        ),
      ),
      child: Stack(
        children: [
          // Cercles décoratifs
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Contenu
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.business, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        institution.split(' - ')[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Informations',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'du citoyen',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: successGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: successGreen.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: successGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Scan réussi',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successGreen,
                  ),
                ),
                Text(
                  'Type de scan: ${scanType.toUpperCase()}',
                  style: const TextStyle(fontSize: 12, color: secondaryText),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              cardNumber.substring(cardNumber.length - 8),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(Map<String, String> relevantFields) {
    final fullName = relevantFields['Nom complet'] ?? 'N/A';
    final nniValue = relevantFields['NNI'] ?? nni;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profil
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [primaryBlue, purpleAccent],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryDark,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'NNI: $nniValue',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Détails
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ...relevantFields.entries
                    .where(
                      (entry) =>
                          entry.key != 'Nom complet' &&
                          entry.key != 'NNI' &&
                          entry.value.isNotEmpty,
                    )
                    .map((entry) => _buildInfoRow(entry.key, entry.value))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getIconColor(label).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIconForField(label),
              color: _getIconColor(label),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, size: 20),
            label: const Text(
              'Retour',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showExportDialog(context),
            icon: const Icon(Icons.share, size: 20),
            label: const Text(
              'Exporter',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              side: BorderSide(color: primaryBlue, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  void _showMenuOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Icon(Icons.print, color: primaryBlue),
              title: const Text('Imprimer'),
              onTap: () {
                Navigator.pop(context);
                _showPrintDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.download, color: successGreen),
              title: const Text('Télécharger PDF'),
              onTap: () {
                Navigator.pop(context);
                _showSuccessMessage(context, 'PDF téléchargé avec succès');
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  IconData _getIconForField(String fieldName) {
    switch (fieldName.toLowerCase()) {
      case 'numéro de carte':
        return Icons.credit_card;
      case 'sexe':
        return Icons.person;
      case 'date de naissance':
        return Icons.cake;
      case 'lieu de naissance':
        return Icons.location_on;
      case 'email':
        return Icons.email;
      case 'téléphone':
        return Icons.phone;
      case 'nom du père':
        return Icons.family_restroom;
      case 'nom de la mère':
        return Icons.family_restroom;
      case 'date d\'enregistrement':
        return Icons.calendar_today;
      default:
        return Icons.info;
    }
  }

  Color _getIconColor(String fieldName) {
    switch (fieldName.toLowerCase()) {
      case 'numéro de carte':
        return purpleAccent;
      case 'sexe':
        return primaryBlue;
      case 'date de naissance':
        return warningOrange;
      case 'lieu de naissance':
        return successGreen;
      case 'email':
        return Colors.blue;
      case 'téléphone':
        return successGreen;
      case 'nom du père':
      case 'nom de la mère':
        return purpleAccent;
      case 'date d\'enregistrement':
        return warningOrange;
      default:
        return primaryBlue;
    }
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.share, color: primaryBlue, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'Exporter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Text(
          'Choisissez le format d\'exportation',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ANNULER'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(context, 'Exportation terminée avec succès');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('EXPORTER'),
          ),
        ],
      ),
    );
  }

  void _showPrintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.print, color: primaryBlue, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'Impression',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Text('Préparation du document pour impression...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ANNULER'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(context, 'Impression lancée');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('IMPRIMER'),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: successGreen,
                size: 14,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(fontSize: 13)),
            ),
          ],
        ),
        backgroundColor: successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
