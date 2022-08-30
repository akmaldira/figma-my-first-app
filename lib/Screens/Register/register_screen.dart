import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import './components/background.dart';
import '../Components/button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();

  var errorName = '';
  var errorEmail = '';
  var errorPassword = '';
  var errorConfirmPassword = '';

  Future register() async {
    if (nameValidate() &&
        emailValidate() &&
        passwordValidate() &&
        passwordConfirmed()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((value) => Navigator.pop(context));
      } catch (err) {
        print('akmalllll');
        if (err.toString() ==
            '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
          setState(() {
            errorEmail = 'Email terlah terdaftar!';
          });
        } else {
          setState(() {
            errorEmail = 'Error tidak diketahui, mohon menghubungi admin!';
          });
        }
      }
    }
  }

  bool nameValidate() {
    if (_nameController.text.trim().length > 7) {
      setState(() {
        errorName = '';
      });
      return true;
    } else {
      setState(() {
        errorName = 'Nama harus berisi lebih dari 7 huruf!';
      });
      return false;
    }
  }

  bool emailValidate() {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
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

  bool passwordValidate() {
    if (_passwordController.text.trim().length > 7) {
      setState(() {
        errorPassword = '';
      });
      return true;
    } else {
      setState(() {
        errorPassword = 'Password harus berisi lebih dari 7 huruf!';
      });
      return false;
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      setState(() {
        errorConfirmPassword = '';
      });
      return true;
    } else {
      setState(() {
        errorConfirmPassword =
            'Konfirmasi password harus sama dengan password!';
      });
      return false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Background(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            errorText: errorName == '' ? null : errorName,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: errorEmail == '' ? null : errorEmail,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            errorText:
                                errorPassword == '' ? null : errorPassword,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Konfirmasi Password',
                            errorText: errorConfirmPassword == ''
                                ? null
                                : errorConfirmPassword,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: _confirmPasswordController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
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
                          onPressed: register,
                          borderRadius: BorderRadius.circular(40),
                          child: const Text(
                            'Daftar',
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
                              text: 'Sudah punya akun? ',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color:
                                      const Color(0xFF21C8F6).withOpacity(0.8),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  }),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
