import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:go_router/go_router.dart';

/// ================= PAGE D'INFORMATIONS DU CITOYEN =================
/// Page affichant les détails d'un citoyen après scan
/// Adaptée selon le domaine de l'agent connecté
class CitizenInfoPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> citizenData;
  final String
  agentDomain; // 'police', 'immigration', 'sante', 'education', etc.

  const CitizenInfoPage({
    super.key,
    required this.citizenData,
    required this.agentDomain,
  });

  @override
  ConsumerState<CitizenInfoPage> createState() => _CitizenInfoPageState();
}

class _CitizenInfoPageState extends ConsumerState<CitizenInfoPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Couleurs principales
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1E293B);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color purpleAccent = Color(0xFF8B5CF6);

  // Couleurs spécifiques par domaine
  Color get _domainColor {
    switch (widget.agentDomain.toLowerCase()) {
      case 'police':
        return const Color(0xFF1E40AF);
      case 'immigration':
        return const Color(0xFF059669);
      case 'sante':
        return const Color(0xFFDC2626);
      case 'education':
        return const Color(0xFF7C3AED);
      case 'justice':
        return const Color(0xFFEA580C);
      default:
        return primaryBlue;
    }
  }

  String get _domainTitle {
    switch (widget.agentDomain.toLowerCase()) {
      case 'police':
        return 'Services de Police';
      case 'immigration':
        return 'Services d\'Immigration';
      case 'sante':
        return 'Services de Santé';
      case 'education':
        return 'Services de l\'Éducation';
      case 'justice':
        return 'Services de Justice';
      default:
        return 'Services Administratifs';
    }
  }

  String get _domainIcon {
    switch (widget.agentDomain.toLowerCase()) {
      case 'police':
        return '👮';
      case 'immigration':
        return '🛂';
      case 'sante':
        return '🏥';
      case 'education':
        return '🎓';
      case 'justice':
        return '⚖️';
      default:
        return '🏢';
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Header avec SliverAppBar
          _buildSliverAppBar(),

          // Contenu principal
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      // Carte d'identité principale
                      _buildIdentityCard(),

                      const SizedBox(height: 16),

                      // Section spécifique au domaine
                      _buildDomainSpecificInfo(),

                      const SizedBox(height: 16),

                      // Informations détaillées
                      _buildDetailedInfo(),

                      const SizedBox(height: 16),

                      // Actions rapides
                      _buildQuickActions(),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= SLIVER APP BAR =================
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 220,
      floating: false,
      pinned: true,
      backgroundColor: _domainColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_domainColor, _domainColor.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Pattern décoratif
              Positioned(
                top: -50,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              // Contenu du header
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge du domaine
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _domainIcon,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _domainTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipOval(child: _buildAvatar()),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.citizenData['prenom'] ?? 'Jean-Pierre'} ${widget.citizenData['nom'] ?? 'MUKENDI'}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(
                                      widget.citizenData['statut'] ?? 'actif',
                                    ).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    widget.citizenData['statut'] ?? 'Actif',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (widget.citizenData['photo'] != null) {
      return Image.network(
        widget.citizenData['photo'],
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              color: Colors.white,
            ),
          );
        },
      );
    }
    return _buildDefaultAvatar();
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_domainColor, _domainColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(Icons.person, color: Colors.white, size: 40),
      ),
    );
  }

  /// ================= CARTE D'IDENTITÉ PRINCIPALE =================
  Widget _buildIdentityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête de la carte
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.badge, color: primaryBlue, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Carte d\'Identité',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: successGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: successGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Vérifié',
                      style: TextStyle(
                        fontSize: 10,
                        color: successGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Informations principales
          _buildInfoRow(
            icon: Icons.person_outline,
            label: 'Nom complet',
            value:
                '${widget.citizenData['prenom'] ?? 'Jean-Pierre'} ${widget.citizenData['nom'] ?? 'MUKENDI'}',
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            icon: Icons.credit_card,
            label: 'Numéro CNI',
            value: widget.citizenData['cni'] ?? 'CD123456789',
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            icon: Icons.cake,
            label: 'Date de naissance',
            value: _formatDate(widget.citizenData['dateNaissance']),
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: 'Lieu de naissance',
            value: widget.citizenData['lieuNaissance'] ?? 'Kinshasa, RDC',
          ),
        ],
      ),
    );
  }

  /// ================= SECTION SPÉCIFIQUE AU DOMAINE =================
  Widget _buildDomainSpecificInfo() {
    switch (widget.agentDomain.toLowerCase()) {
      case 'police':
        return _buildPoliceInfo();
      case 'immigration':
        return _buildImmigrationInfo();
      case 'sante':
        return _buildSanteInfo();
      case 'education':
        return _buildEducationInfo();
      case 'justice':
        return _buildJusticeInfo();
      default:
        return _buildDefaultDomainInfo();
    }
  }

  Widget _buildPoliceInfo() {
    return _buildDomainCard(
      title: 'Informations Judiciaires',
      icon: Icons.security,
      domainColor: const Color(0xFF1E40AF),
      badgeText: widget.citizenData['casierJudiciaire'] ?? 'Casier vide',
      badgeColor: _getCasierJudiciaireColor(
        widget.citizenData['casierJudiciaire'],
      ),
      children: [
        _buildInfoRow(
          icon: Icons.gavel,
          label: 'Casier judiciaire',
          value: widget.citizenData['casierJudiciaire'] ?? 'Aucun antécédent',
        ),
        _buildInfoRow(
          icon: Icons.local_police,
          label: 'Permis de conduire',
          value: widget.citizenData['permisConduire'] ?? 'Valide',
        ),
        _buildInfoRow(
          icon: Icons.warning,
          label: 'Signalements',
          value: widget.citizenData['signalements'] ?? 'Aucun signalement',
        ),
        _buildInfoRow(
          icon: Icons.verified_user,
          label: 'Statut légal',
          value: widget.citizenData['statutLegal'] ?? 'Régulier',
        ),
      ],
    );
  }

  Widget _buildImmigrationInfo() {
    return _buildDomainCard(
      title: 'Informations d\'Immigration',
      icon: Icons.flight,
      domainColor: const Color(0xFF059669),
      badgeText: widget.citizenData['visaStatus'] ?? 'Résident',
      badgeColor: _getVisaStatusColor(widget.citizenData['visaStatus']),
      children: [
        _buildInfoRow(
          icon: Icons.card_travel,
          label: 'Type de visa',
          value: widget.citizenData['visaType'] ?? 'Touristique',
        ),
        _buildInfoRow(
          icon: Icons.event,
          label: 'Date d\'expiration',
          value: _formatDate(widget.citizenData['visaExpiration']),
        ),
        _buildInfoRow(
          icon: Icons.flag,
          label: 'Nationalité',
          value: widget.citizenData['nationalite'] ?? 'Congolaise',
        ),
        _buildInfoRow(
          icon: Icons.home_work,
          label: 'Statut de résidence',
          value: widget.citizenData['residenceStatus'] ?? 'Permanent',
        ),
      ],
    );
  }

  Widget _buildSanteInfo() {
    return _buildDomainCard(
      title: 'Informations Médicales',
      icon: Icons.local_hospital,
      domainColor: const Color(0xFFDC2626),
      badgeText: widget.citizenData['santeStatus'] ?? 'Bon état',
      badgeColor: _getSanteStatusColor(widget.citizenData['santeStatus']),
      children: [
        _buildInfoRow(
          icon: Icons.bloodtype,
          label: 'Groupe sanguin',
          value: widget.citizenData['groupeSanguin'] ?? 'O+',
        ),
        _buildInfoRow(
          icon: Icons.vaccines,
          label: 'Vaccination',
          value: widget.citizenData['vaccination'] ?? 'À jour',
        ),
        _buildInfoRow(
          icon: Icons.medical_services,
          label: 'Allergies',
          value: widget.citizenData['allergies'] ?? 'Aucune connue',
        ),
        _buildInfoRow(
          icon: Icons.health_and_safety,
          label: 'Assurance maladie',
          value: widget.citizenData['assurance'] ?? 'INSS',
        ),
      ],
    );
  }

  Widget _buildEducationInfo() {
    return _buildDomainCard(
      title: 'Informations Éducatives',
      icon: Icons.school,
      domainColor: const Color(0xFF7C3AED),
      badgeText: widget.citizenData['niveauEtude'] ?? 'Supérieur',
      badgeColor: const Color(0xFF7C3AED),
      children: [
        _buildInfoRow(
          icon: Icons.grade,
          label: 'Niveau d\'étude',
          value: widget.citizenData['niveauEtude'] ?? 'Licence',
        ),
        _buildInfoRow(
          icon: Icons.business_center,
          label: 'Diplôme',
          value: widget.citizenData['diplome'] ?? 'Informatique',
        ),
        _buildInfoRow(
          icon: Icons.language,
          label: 'Langues',
          value: widget.citizenData['langues'] ?? 'Français, Lingala',
        ),
        _buildInfoRow(
          icon: Icons.workspace_premium,
          label: 'Certifications',
          value: widget.citizenData['certifications'] ?? 'Aucune',
        ),
      ],
    );
  }

  Widget _buildJusticeInfo() {
    return _buildDomainCard(
      title: 'Informations Légales',
      icon: Icons.balance,
      domainColor: const Color(0xFFEA580C),
      badgeText: widget.citizenData['legalStatus'] ?? 'Conforme',
      badgeColor: _getLegalStatusColor(widget.citizenData['legalStatus']),
      children: [
        _buildInfoRow(
          icon: Icons.gavel,
          label: 'Statut légal',
          value: widget.citizenData['legalStatus'] ?? 'Conforme',
        ),
        _buildInfoRow(
          icon: Icons.description,
          label: 'Documents légaux',
          value: widget.citizenData['documentsLegaux'] ?? 'Complets',
        ),
        _buildInfoRow(
          icon: Icons.account_balance,
          label: 'Affaires en cours',
          value: widget.citizenData['affairesEnCours'] ?? 'Aucune',
        ),
        _buildInfoRow(
          icon: Icons.verified,
          label: 'Conformité',
          value: widget.citizenData['conformite'] ?? '100%',
        ),
      ],
    );
  }

  Widget _buildDefaultDomainInfo() {
    return _buildDomainCard(
      title: 'Informations Administratives',
      icon: Icons.info,
      domainColor: primaryBlue,
      badgeText: 'Standard',
      badgeColor: primaryBlue,
      children: [
        _buildInfoRow(
          icon: Icons.assignment_ind,
          label: 'Numéro administratif',
          value: widget.citizenData['numeroAdmin'] ?? 'ADM-123456',
        ),
        _buildInfoRow(
          icon: Icons.category,
          label: 'Catégorie',
          value: widget.citizenData['categorie'] ?? 'Standard',
        ),
        _buildInfoRow(
          icon: Icons.check_circle,
          label: 'Statut administratif',
          value: widget.citizenData['statutAdmin'] ?? 'À jour',
        ),
      ],
    );
  }

  Widget _buildDomainCard({
    required String title,
    required IconData icon,
    required Color domainColor,
    required String badgeText,
    required Color badgeColor,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: domainColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: domainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: domainColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 10,
                    color: badgeColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ...children
              .map(
                (child) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: child,
                ),
              )
              .toList()
            ..removeLast(),
        ],
      ),
    );
  }

  /// ================= INFORMATIONS DÉTAILLÉES =================
  Widget _buildDetailedInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: primaryBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Informations Complémentaires',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Contact
          _buildSectionTitle('Contact'),
          const SizedBox(height: 8),
          _buildInfoRow(
            icon: Icons.phone_outlined,
            label: 'Téléphone',
            value: widget.citizenData['telephone'] ?? '+243 123 456 789',
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value:
                widget.citizenData['email'] ?? 'jeanpierre.mukendi@email.com',
          ),

          const SizedBox(height: 16),

          // Adresse
          _buildSectionTitle('Adresse'),
          const SizedBox(height: 8),
          _buildInfoRow(
            icon: Icons.home_outlined,
            label: 'Résidence',
            value:
                widget.citizenData['adresse'] ?? 'Avenue des Nations, Kinshasa',
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            icon: Icons.location_city_outlined,
            label: 'Commune',
            value: widget.citizenData['commune'] ?? 'Lemba',
          ),

          const SizedBox(height: 16),

          // Profession
          _buildSectionTitle('Profession'),
          const SizedBox(height: 8),
          _buildInfoRow(
            icon: Icons.work_outline,
            label: 'Activité',
            value: widget.citizenData['profession'] ?? 'Développeur',
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            icon: Icons.business_outlined,
            label: 'Employeur',
            value: widget.citizenData['employeur'] ?? 'Tech Solutions RDC',
          ),
        ],
      ),
    );
  }

  /// ================= ACTIONS RAPIDES =================
  Widget _buildQuickActions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.flash_on, color: primaryBlue, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Actions Rapides',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Boutons d'action
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.edit,
                  label: 'Modifier',
                  color: primaryBlue,
                  onTap: _editCitizen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.share,
                  label: 'Partager',
                  color: successGreen,
                  onTap: _shareCitizen,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.download,
                  label: 'PDF',
                  color: warningOrange,
                  onTap: _exportPDF,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.history,
                  label: 'Historique',
                  color: secondaryText,
                  onTap: _viewHistory,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= WIDGETS UTILITAIRES =================

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: primaryBlue,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: primaryBlue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: primaryBlue, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: secondaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: primaryDark,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= FONCTIONS UTILITAIRES =================

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'actif':
      case 'validé':
        return successGreen;
      case 'inactif':
      case 'suspendu':
        return warningOrange;
      case 'bloqué':
      case 'annulé':
        return errorRed;
      default:
        return primaryBlue;
    }
  }

  Color _getCasierJudiciaireColor(String? casier) {
    if (casier == null ||
        casier.toLowerCase().contains('vide') ||
        casier.toLowerCase().contains('aucun')) {
      return successGreen;
    } else if (casier.toLowerCase().contains('en cours')) {
      return warningOrange;
    } else {
      return errorRed;
    }
  }

  Color _getVisaStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'valide':
      case 'résident':
      case 'permanent':
        return successGreen;
      case 'expiré':
      case 'en attente':
        return warningOrange;
      case 'refusé':
      case 'annulé':
        return errorRed;
      default:
        return primaryBlue;
    }
  }

  Color _getSanteStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'bon état':
      case 'stable':
      case 'à jour':
        return successGreen;
      case 'surveillance':
      case 'traitement':
        return warningOrange;
      case 'urgent':
      case 'critique':
        return errorRed;
      default:
        return primaryBlue;
    }
  }

  Color _getLegalStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'conforme':
      case 'régulier':
      case 'complet':
        return successGreen;
      case 'irrégulier':
      case 'incomplet':
        return warningOrange;
      case 'non conforme':
      case 'suspendu':
        return errorRed;
      default:
        return primaryBlue;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '15 Janvier 1990';

    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMMM yyyy', 'fr_FR').format(date);
    } catch (e) {
      return dateString;
    }
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              'Options supplémentaires',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryDark,
              ),
            ),
            const SizedBox(height: 20),
            _buildBottomSheetOption(
              icon: Icons.qr_code,
              title: 'Générer QR Code',
              onTap: () {
                context.pop();
                _generateQRCode();
              },
            ),
            _buildBottomSheetOption(
              icon: Icons.print,
              title: 'Imprimer carte',
              onTap: () {
                context.pop();
                _printCard();
              },
            ),
            _buildBottomSheetOption(
              icon: Icons.security,
              title: 'Vérifier authenticité',
              onTap: () {
                context.pop();
                _verifyAuthenticity();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: primaryBlue, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.grey,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  void _editCitizen() {
    _showFeatureSnackBar('Modification des informations');
  }

  void _shareCitizen() {
    _showFeatureSnackBar('Partage des informations', isSuccess: true);
  }

  void _exportPDF() {
    _showFeatureSnackBar('Génération du PDF', color: warningOrange);
  }

  void _viewHistory() {
    _showFeatureSnackBar('Historique des scans', color: secondaryText);
  }

  void _generateQRCode() {
    _showFeatureSnackBar('Génération du QR Code');
  }

  void _printCard() {
    _showFeatureSnackBar('Impression de la carte');
  }

  void _verifyAuthenticity() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Vérification d\'authenticité'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: successGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.verified, color: successGreen, size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ce document est authentique',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'La vérification a confirmé l\'authenticité de ce document d\'identité.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: secondaryText),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            style: TextButton.styleFrom(foregroundColor: primaryBlue),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFeatureSnackBar(
    String message, {
    Color? color,
    bool isSuccess = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.info_outline,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text('$message bientôt disponible!')),
          ],
        ),
        backgroundColor: color ?? primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
