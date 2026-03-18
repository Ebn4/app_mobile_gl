import 'package:app_mobile/main.dart';
import 'package:app_mobile/utils/navigationUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/mainLayout.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // Couleurs principales
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1E293B);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color purpleAccent = Color(0xFF8B5CF6);
  var navigation = getIt<NavigationUtils>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // AppBar toujours visible avec effet de profondeur
          SliverAppBar(
            expandedHeight: 180,
            floating: true,
            pinned: true,
            snap: true,
            backgroundColor: primaryBlue,
            elevation: 4,
            shadowColor: primaryBlue.withOpacity(0.3),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildHeader(),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.nfc_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: () {},
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            title: const Text(
              'NFC RDC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
                  icon: const Icon(Icons.menu, color: Colors.white, size: 20),
                  onPressed: () {
                    _showMainMenu(context);
                  },
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),

          // Contenu principal avec padding ajusté
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quick Actions en premier
                _buildQuickActions(),

                const SizedBox(height: 24),

                // Section des statistiques - CORRIGÉE
                _buildDetailedStats(),

                const SizedBox(height: 24),

                // Activités récentes
                _buildRecentActivities(),

                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= HEADER COMPACT =================
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryBlue, Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Bonjour, Agent',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Jean-Pierre MUKENDI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Police',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= STATISTIQUES CORRIGÉES =================
  Widget _buildDetailedStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.trending_up, color: primaryBlue, size: 18),
            ),
            const SizedBox(width: 12),
            const Text(
              'Statistiques du jour',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Grille de statistiques avec contraintes de taille
        LayoutBuilder(
          builder: (context, constraints) {
            // Calculer la largeur disponible pour chaque carte
            double cardWidth =
                (constraints.maxWidth - 12) / 2; // 12 = espacement

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _buildStatCard(
                    icon: Icons.qr_code_scanner,
                    iconColor: primaryBlue,
                    value: '247',
                    label: 'Scans',
                    change: '+12%',
                    gradientColors: [primaryBlue, const Color(0xFF3B82F6)],
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildStatCard(
                    icon: Icons.error_outline,
                    iconColor: warningOrange,
                    value: '18',
                    label: 'Expirés',
                    change: '+3',
                    gradientColors: [warningOrange, const Color(0xFFF97316)],
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildStatCard(
                    icon: Icons.assignment_turned_in,
                    iconColor: successGreen,
                    value: '89',
                    label: 'Actions',
                    change: '+5',
                    gradientColors: [successGreen, const Color(0xFF34D399)],
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildStatCard(
                    icon: Icons.visibility,
                    iconColor: purpleAccent,
                    value: '156',
                    label: 'Consultations',
                    change: '+23%',
                    gradientColors: [purpleAccent, const Color(0xFFA78BFA)],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  /// ================= STAT CARD STYLISÉE =================
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    required String change,
    required List<Color> gradientColors,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+')
                      ? successGreen.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 9,
                    color: change.startsWith('+') ? successGreen : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryDark,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: secondaryText,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  /// ================= QUICK ACTIONS =================
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.flash_on, color: primaryBlue, size: 18),
            ),
            const SizedBox(width: 12),
            const Text(
              'Actions rapides',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Utilisation de Row avec flex pour éviter les dépassements
        Row(
          children: [
            Expanded(
              child: _buildQuickActionButton(
                icon: Icons.qr_code_scanner,
                label: 'Scanner',
                color: primaryBlue,
                onTap: () {
                  // Naviguer vers l'onglet Scanner
                  ref.read(bottomNavIndexProvider.notifier).state = 1;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildQuickActionButton(
                icon: Icons.history,
                label: 'Historique',
                color: purpleAccent,
                onTap: () {
                  // Naviguer vers l'onglet Historique
                  ref.read(bottomNavIndexProvider.notifier).state = 2;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildQuickActionButton(
                icon: Icons.notifications,
                label: 'Alertes',
                color: warningOrange,
                badge: '3',
                onTap: () {
                  // TODO: Implémenter la page d'alertes ou naviguer vers notifications
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Page d\'alertes bientôt disponible!'),
                      backgroundColor: warningOrange,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildQuickActionButton(
                icon: Icons.settings,
                label: 'Paramètres',
                color: secondaryText,
                onTap: () {
                  // Naviguer vers l'onglet Paramètres
                  ref.read(bottomNavIndexProvider.notifier).state = 3;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ================= QUICK ACTION BUTTON =================
  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    String? badge,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                if (badge != null)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: primaryDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= ACTIVITÉS RÉCENTES =================
  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.history, color: primaryBlue, size: 18),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Activités récentes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryDark,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                ref.read(bottomNavIndexProvider.notifier).state = 2;
              },
              style: TextButton.styleFrom(
                foregroundColor: primaryBlue,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Voir tout',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity, // Prend toute la largeur
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActivityItem(
                icon: Icons.qr_code_scanner,
                iconColor: primaryBlue,
                title: 'Scan carte NFC',
                subtitle: 'MUKENDI Jean',
                time: '5 min',
                status: 'Succès',
              ),
              const Divider(height: 1, indent: 70, endIndent: 16),
              _buildActivityItem(
                icon: Icons.add_circle_outline,
                iconColor: warningOrange,
                title: 'Infraction',
                subtitle: 'KABONGO Marie',
                time: '12 min',
                status: 'En cours',
              ),
              const Divider(height: 1, indent: 70, endIndent: 16),
              _buildActivityItem(
                icon: Icons.verified_user,
                iconColor: successGreen,
                title: 'Vérification',
                subtitle: 'TSHISEKEDI Félix',
                time: '23 min',
                status: 'Validé',
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ================= ACTIVITY ITEM =================
  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    required String status,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: primaryDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 8,
                            color: _getStatusColor(status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: secondaryText),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(time, style: TextStyle(fontSize: 10, color: secondaryText)),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Succès':
      case 'Validé':
        return successGreen;
      case 'En cours':
        return warningOrange;
      default:
        return Colors.grey;
    }
  }

  // ================= MENU PRINCIPAL OPTIMISÉ =================
void _showMainMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: true, // Utilise la zone sécurisée
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
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
                // Poignée de glissement
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Header du menu
                _buildMenuHeader(context),
                
                // Options du menu avec scroll
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Section Profil
                        _buildMenuSection(
                          title: 'Profil',
                          color: primaryBlue,
                          children: [
                            _buildMenuOption(
                              icon: Icons.person_outline,
                              title: 'Mon Profil',
                              subtitle: 'Gérer mes informations',
                              color: primaryBlue,
                              onTap: () {
                                Navigator.pop(context);
                                ref.read(bottomNavIndexProvider.notifier).state = 3;
                              },
                            ),
                            const SizedBox(height: 8),
                            _buildMenuOption(
                              icon: Icons.notifications_outlined,
                              title: 'Notifications',
                              subtitle: '3 nouvelles alertes',
                              color: warningOrange,
                              badge: '3',
                              onTap: () {
                                Navigator.pop(context);
                                _showFeatureInDevelopment(context, 'Alertes');
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Section Actions Rapides
                        _buildMenuSection(
                          title: 'Actions Rapides',
                          color: successGreen,
                          children: [
                            _buildMenuOption(
                              icon: Icons.file_download_outlined,
                              title: 'Exporter les scans',
                              subtitle: 'Télécharger au format CSV',
                              color: successGreen,
                              onTap: () {
                                Navigator.pop(context);
                                _exportScans();
                              },
                            ),
                            const SizedBox(height: 8),
                            _buildMenuOption(
                              icon: Icons.email_outlined,
                              title: 'Envoyer rapport',
                              subtitle: 'Partager par email',
                              color: successGreen,
                              onTap: () {
                                Navigator.pop(context);
                                _shareByEmail();
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Section Préférences
                        _buildMenuSection(
                          title: 'Préférences',
                          color: purpleAccent,
                          children: [
                            _buildMenuOption(
                              icon: Icons.settings_outlined,
                              title: 'Paramètres',
                              subtitle: 'Configuration complète',
                              color: purpleAccent,
                              onTap: () {
                                Navigator.pop(context);
                                ref.read(bottomNavIndexProvider.notifier).state = 3;
                              },
                            ),
                            const SizedBox(height: 8),
                            _buildMenuOption(
                              icon: Icons.help_outline,
                              title: 'Aide et Support',
                              subtitle: 'Centre d\'aide',
                              color: purpleAccent,
                              onTap: () {
                                Navigator.pop(context);
                                _showFeatureInDevelopment(context, 'Centre d\'aide');
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Bouton Déconnexion
                        _buildLogoutButton(context),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

/// ================= HEADER DU MENU =================
Widget _buildMenuHeader(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [primaryBlue, const Color(0xFF3B82F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.menu_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Menu Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Jean-Pierre MUKENDI',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.white, size: 18),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    ),
  );
}

/// ================= SECTION DU MENU =================
Widget _buildMenuSection({
  required String title,
  required Color color,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.05),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...children,
      ],
    ),
  );
}

/// ================= OPTION DE MENU OPTIMISÉE =================
Widget _buildMenuOption({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color color,
  required VoidCallback onTap,
  String? badge,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            // Icône avec badge
            SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  if (badge != null)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            badge,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            
            // Titre et sous-titre
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: secondaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Flèche
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 12,
            ),
          ],
        ),
      ),
    ),
  );
}

/// ================= BOUTON DE DÉCONNEXION =================
Widget _buildLogoutButton(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 44,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFDC2626).withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        _showLogoutDialog();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout_rounded, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text(
            'SE DÉCONNECTER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ),
  );
}

/// ================= DIALOGUE DE DÉCONNEXION =================
void _showLogoutDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titlePadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFDC2626).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: Color(0xFFDC2626),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Déconnexion',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryDark,
                ),
              ),
            ),
          ],
        ),
        content: const Text(
          'Êtes-vous sûr de vouloir vous déconnecter ?',
          style: TextStyle(
            fontSize: 13,
            color: secondaryText,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: secondaryText,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('ANNULER'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performLogout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('DÉCONNEXION'),
          ),
        ],
      );
    },
  );
}

/// ================= FONCTIONS UTILITAIRES =================
void _showFeatureInDevelopment(BuildContext context, String featureName) {
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
            child: Icon(Icons.construction, color: warningOrange, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$featureName bientôt disponible!',
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
      backgroundColor: warningOrange,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    ),
  );
}

void _exportScans() {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.file_download, color: Colors.white, size: 18),
          const SizedBox(width: 12),
          const Expanded(child: Text('Exportation en cours...')),
        ],
      ),
      backgroundColor: primaryBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    ),
  );

  // Simulation d'export
  Future.delayed(const Duration(seconds: 2), () {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: successGreen, size: 14),
              ),
              const SizedBox(width: 12),
              const Expanded(child: Text('Scans exportés avec succès!')),
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
  });
}

void _shareByEmail() {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.email, color: Colors.white, size: 18),
          const SizedBox(width: 12),
          const Expanded(child: Text('Préparation de l\'email...')),
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

void _performLogout() {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Text('Déconnexion en cours...')),
        ],
      ),
      backgroundColor: const Color(0xFFDC2626),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    ),
  );
}}
