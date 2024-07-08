import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaps/api/url_api.dart';
import 'package:pharmaps/pages/login/login_screen.dart';
import 'package:pharmaps/utils/constants.dart';
import 'package:pharmaps/widgets/button_primary.dart';
import 'package:pharmaps/widgets/logo_space.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;
  bool _isLoading = false;

  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  Future<void> registerSubmit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var registerUrl = Uri.parse(BASEURL.apiRegister);
      final response = await http.post(registerUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "fullname": fullNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        }));

      if (!mounted) return;

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> && data.containsKey('id')) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Inscription réussie"),
              content: const Text("Utilisateur enregistré avec succès"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text("Ok"),
                ),
              ],
            ),
          );
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        print('Réponse échouée: ${response.statusCode}');
        print('Corps de la réponse: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Erreur"),
            content: const Text("Une erreur s'est produite. Veuillez réessayer."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Erreur"),
          content: const Text("Une erreur s'est produite. Veuillez réessayer."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        color: whiteColor,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: lightTextStyle.copyWith(fontSize: 15, color: greyLightColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const LogoSpace(),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                buildTextField(
                  controller: fullNameController,
                  hintText: 'Nom',
                ),
                const SizedBox(height: 24),
                buildTextField(
                  controller: emailController,
                  hintText: 'Adresse mail',
                ),
                const SizedBox(height: 24),
                buildTextField(
                  controller: passwordController,
                  hintText: 'Mot de passe',
                  obscureText: _secureText,
                  suffixIcon: IconButton(
                    onPressed: showHide,
                    icon: _secureText
                        ? const Icon(Icons.visibility_off, size: 20)
                        : const Icon(Icons.visibility, size: 20),
                  ),
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ButtonPrimary(
                        text: "S'inscrire",
                        onPressed: () {
                          if (fullNameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Attention !!"),
                                content: const Text("Veuillez remplir tous les champs"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            registerSubmit();
                          }
                        },
                      ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Déjà un compte? ",
                      style: lightTextStyle.copyWith(color: greyLightColor, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Se Connecter",
                        style: boldTextStyle.copyWith(color: greenColor, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
