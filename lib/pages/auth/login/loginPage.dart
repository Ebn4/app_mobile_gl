import 'package:app_mobile/business/models/user/authentication.dart';
import 'package:app_mobile/main.dart';
import 'package:app_mobile/utils/navigationUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'loginCtrl.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  var navigation = getIt<NavigationUtils>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Liste des institutions
  final List<String> _institutions = [
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

  String? _selectedInstitution;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: SafeArea(
        child: Column(
          children: [
            // Bandeau tricolore amélioré avec dégradé
            Container(
              height: 8,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF0066CC), Color(0xFF2E86DE)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFCC00), Color(0xFFFFD700)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFCC0000), Color(0xFFE63946)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // En-tête gouvernemental stylisé
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                    ).createShader(bounds),
                    child: const Text(
                      'RÉPUBLIQUE DÉMOCRATIQUE\nDU CONGO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 2,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFCC00), Color(0xFFFFD700)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'MINISTÈRE DU NUMÉRIQUE',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Zone principale avec formulaire
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Icône de connexion stylisée
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF0066CC).withOpacity(0.1),
                            const Color(0xFF0066CC).withOpacity(0.05),
                            Colors.transparent,
                          ],
                          stops: const [0.2, 0.7, 1.0],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white, Color(0xFFF0F5FF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                                spreadRadius: -2,
                              ),
                              BoxShadow(
                                color: const Color(
                                  0xFF0066CC,
                                ).withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.login_rounded,
                            color: Color(0xFF0066CC),
                            size: 35,
                          ),
                        ),
                      ),
                    ),

                    // Titre de connexion
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF1E3C72), Color(0xFF0066CC)],
                      ).createShader(bounds),
                      child: const Text(
                        'Connexion Sécurisée',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Badge de sécurité
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0066CC), Color(0xFF2E86DE)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0066CC).withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.security_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'CONNEXION SÉCURISÉE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Formulaire de connexion
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Champ email
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Adresse email',
                                hintText: 'exemple@domaine.com',
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF0066CC),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                labelStyle: TextStyle(
                                  color: Color(0xFF0066CC),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre adresse email';
                                }
                                // Validation basique du format email
                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Veuillez entrer une adresse email valide';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Champ institution
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<String>(
                              value: _selectedInstitution,
                              isExpanded:
                                  true, // Permet au texte de prendre toute la largeur
                              decoration: const InputDecoration(
                                labelText: 'Institution',
                                hintText: 'Sélectionnez votre institution',
                                prefixIcon: Icon(
                                  Icons.business_outlined,
                                  color: Color(0xFF0066CC),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 16,
                                ),
                                labelStyle: TextStyle(
                                  color: Color(0xFF0066CC),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              items: _institutions.map((String institution) {
                                return DropdownMenuItem<String>(
                                  value: institution,
                                  child: Text(
                                    institution,
                                    style: const TextStyle(fontSize: 13),
                                    overflow: TextOverflow
                                        .ellipsis, // Coupe le texte avec "..."
                                    maxLines: 1,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedInstitution = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez sélectionner une institution';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Champ mot de passe
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                                hintText: '••••••••',
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF0066CC),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: const Color(0xFF0066CC),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                labelStyle: const TextStyle(
                                  color: Color(0xFF0066CC),
                                  fontWeight: FontWeight.w500,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre mot de passe';
                                }
                                if (value.length < 6) {
                                  return 'Le mot de passe doit contenir au moins 6 caractères';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Mot de passe oublié
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Implémenter la récupération de mot de passe
                              },
                              child: const Text(
                                'Mot de passe oublié ?',
                                style: TextStyle(
                                  color: Color(0xFF0066CC),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Bouton de connexion
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF0066CC), Color(0xFF2E86DE)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF0066CC,
                                  ).withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () => _handleLogin(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Consumer(
                                builder: (context, ref, child) {
                                  final loginState = ref.watch(
                                    loginCtrlProvider,
                                  );
                                  final isLoading =
                                      loginState.isLoading ?? false;

                                  return isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.login_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'SE CONNECTER',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Lien d'inscription
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pas encore de compte ? ',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  navigation.replace('/public/register');
                                },
                                child: const Text(
                                  'Créer un compte',
                                  style: TextStyle(
                                    color: Color(0xFF0066CC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Section inférieure avec badges de sécurité
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  // Texte de sécurité gouvernementale
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.security_rounded,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'SÉCURISÉ PAR LE GOUVERNEMENT',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Carrés de couleurs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildColorSquare(0xFF0066CC),
                      const SizedBox(width: 8),
                      _buildColorSquare(0xFFFFCC00),
                      const SizedBox(width: 8),
                      _buildColorSquare(0xFFCC0000),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityBadge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSquare(int colorCode) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(colorCode), Color(colorCode).withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Color(colorCode).withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate() && _selectedInstitution != null) {
      final loginCtrl = ref.read(loginCtrlProvider.notifier);

      print("Je suis dans le controller");

      // Extraire le code de l'institution (ex: "ONIP" de "ONIP - Office National...")
      final institutionCode = _selectedInstitution!.split(' - ')[0];

      // Créer l'objet Authentication
      final authData = Authentication(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        role: 'agent',
        institution: institutionCode,
      );

      await loginCtrl.login(authData);

      // Vérifier si la connexion a réussi
      final loginState = ref.read(loginCtrlProvider);

      if (loginState.user != null) {
        // Succès - naviguer vers la page d'accueil
        if (mounted) {
          navigation.replace('/app/home');
        }
      } else if (loginState.error != null) {
        // Erreur - afficher un message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loginState.error!),
              backgroundColor: const Color(0xFFCC0000),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } else if (_selectedInstitution == null) {
      // Message d'erreur si aucune institution n'est sélectionnée
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une institution'),
          backgroundColor: Color(0xFFCC0000),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}