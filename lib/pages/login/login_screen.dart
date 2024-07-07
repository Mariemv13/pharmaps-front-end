import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaps/api/url_api.dart';
import 'package:pharmaps/models/profile.dart';
import 'package:pharmaps/pages/main/main_screen.dart';
import 'package:pharmaps/pages/register/register_screen.dart';
import 'package:pharmaps/utils/constants.dart';
import 'package:pharmaps/widgets/button_primary.dart';
import 'package:pharmaps/widgets/logo_space.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;
  bool _isLoading = false;

  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  Future<void> submitLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var urlLogin = Uri.parse(BASEURL.apiLogin);
      final response = await http.post(
        urlLogin,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (!mounted) return;

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data is Map<String, dynamic> && data.containsKey('value')) {
          int value = data['value'];
          String message = data['message'];
          String userId = data['userId'];
          String fullname = data['fullname'];
          String email = data['email'];

          if (value == 1) {
            await savePref(userId, fullname, email);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          } else {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Information"),
                content: Text(message),
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
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        debugPrint('Failed response: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
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
      debugPrint('Exception: $e');
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
  Future<void> savePref(String userId, String fullname, String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(Profile.userId, userId);
    await sharedPreferences.setString(Profile.fullname, fullname);
    await sharedPreferences.setString(Profile.email, email);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              const LogoSpace(),
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.only(left: 16),
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
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Adresse mail',
                          hintStyle: lightTextStyle.copyWith(
                            fontSize: 15,
                            color: greyLightColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.only(left: 16),
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
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: passwordController,
                        obscureText: _secureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: _secureText
                                ? const Icon(Icons.visibility_off, size: 20)
                                : const Icon(Icons.visibility, size: 20),
                          ),
                          border: InputBorder.none,
                          hintText: 'Mot de passe',
                          hintStyle: lightTextStyle.copyWith(
                            fontSize: 15,
                            color: greyLightColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ButtonPrimary(
                        text: "Se Connecter",
                        onPressed: () {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Attention !!"),
                                content:
                                    const Text("Veuillez entrer tous les champs"),
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
                            submitLogin();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pas de compte? ",
                          style: lightTextStyle.copyWith(
                            color: greyLightColor,
                            fontSize: 15,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: Text(
                            "Créer un compte",
                            style: boldTextStyle.copyWith(
                              color: greenColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
