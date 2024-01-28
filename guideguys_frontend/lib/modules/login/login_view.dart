import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/home/home_view.dart';
import 'package:guideguys/modules/login/components/textformfield_login.dart';
import 'package:guideguys/modules/login/login_view_model.dart';
import 'package:guideguys/modules/register/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel _viewModel;
  String username = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    _viewModel = LoginViewModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgPurple,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.flag,
                      size: 100,
                      color: white,
                    ),
                    const SizedBox(height: 30),
                    TextFormFieldLogIn(
                      labelTFF: "USERNAME/E-MAIL",
                      hintTextinTFF: "olivia@untitledui.com",
                      prefixTFF: const Icon(Icons.mail_outline, color: grey500),
                      onInputChanged: (value) {
                        setState(() {
                          username = value;
                          return;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldLogIn(
                      labelTFF: "PASSWORD",
                      hintTextinTFF: "XXXXXX",
                      prefixTFF: const Icon(
                        Icons.lock,
                        color: grey500,
                      ),
                      hideText: true,
                      onInputChanged: (value) {
                        setState(() {
                          password = value;
                          return;
                        });
                      },
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      onPressed: () async {
                        _viewModel.userInfo.username = username;
                        _viewModel.userInfo.password = password;
                        try {
                          bool loginResStatus = await _viewModel.getToken(
                              userInfo: _viewModel.userInfo);
                          if (loginResStatus && mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const HomeView(),
                              ),
                            );
                          }
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: grey500,
                              content: Text(error.toString()),
                            ),
                          );
                          rethrow;
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: yellow,
                        fixedSize: const Size(90, 50),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const RegisterView(),
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: yellow,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
