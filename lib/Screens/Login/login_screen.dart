import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import './components//background.dart';
import '../Components/button.dart';
import '../Register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<LoginScreen> {
  final _emailLoginController = TextEditingController();
  final _passwordLoginController = TextEditingController();

  var errorEmail = '';
  var errorPassword = '';

  Future login() async {
    if (checkEmail() && checkPassword()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailLoginController.text.trim(),
          password: _passwordLoginController.text.trim(),
        );
      } catch (err) {
        if (err.toString() ==
            '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
          setState(() {
            errorEmail = 'Email atau password salah!';
          });
        } else if (err.toString() ==
            '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.') {
          setState(() {
            errorEmail = 'Terlalu banyak percobaan, tunggu beberapa saat!';
          });
        } else {
          setState(() {
            errorEmail = 'Error tidak diketahui';
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _emailLoginController.dispose();
    _passwordLoginController.dispose();
    super.dispose();
  }

  bool checkEmail() {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailLoginController.text)) {
      setState(() {
        errorEmail = '';
      });
      return true;
    } else {
      setState(() {
        errorEmail = 'Harap mengisi format email dengan benar!';
      });
      return false;
    }
  }

  bool checkPassword() {
    if (_passwordLoginController.text.trim().isNotEmpty) {
      setState(() {
        errorPassword = '';
      });
      return true;
    } else {
      setState(() {
        errorPassword = 'Harap masukkan password!';
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Background(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text(
                    "Belajar bahasa inggris dengan mudah",
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: errorEmail == '' ? null : errorEmail,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    controller: _emailLoginController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: errorPassword == '' ? null : errorPassword,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    controller: _passwordLoginController,
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Lupa password',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xFF21C8F6).withOpacity(0.8),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                              );
                            }),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: MyElevatedButton(
                    width: double.infinity,
                    height: 57,
                    gradient: const LinearGradient(
                        colors: [Color(0xFF21C8F6), Color(0xFF637BFF)]),
                    shadow: BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 5,
                      offset: const Offset(0, 5), // Shadow position
                    ),
                    onPressed: () {
                      login();
                    },
                    borderRadius: BorderRadius.circular(40),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Belum mempunyai akun? ',
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      TextSpan(
                          text: 'Daftar',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xFF21C8F6).withOpacity(0.8),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                              );
                            }),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
