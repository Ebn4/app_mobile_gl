import 'package:app_mobile/main.dart';
import 'package:app_mobile/utils/navigationUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  icon: const Icon(Icons.nfc_rounded, color: Colors.white, size: 22),
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
                  onPressed: () {},
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
            double cardWidth = (constraints.maxWidth - 12) / 2; // 12 = espacement
            
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
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
            Expanded(child: _buildQuickActionButton(
              icon: Icons.qr_code_scanner,
              label: 'Scanner',
              color: primaryBlue,
              onTap: () {},
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildQuickActionButton(
              icon: Icons.history,
              label: 'Historique',
              color: purpleAccent,
              onTap: () {},
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildQuickActionButton(
              icon: Icons.notifications,
              label: 'Alertes',
              color: warningOrange,
              badge: '3',
              onTap: () {},
            )),
            const SizedBox(width: 8),
            Expanded(child: _buildQuickActionButton(
              icon: Icons.settings,
              label: 'Paramètres',
              color: secondaryText,
              onTap: () {},
            )),
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
              onPressed: () {},
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
                    style: TextStyle(
                      fontSize: 11,
                      color: secondaryText,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                color: secondaryText,
              ),
            ),
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
}