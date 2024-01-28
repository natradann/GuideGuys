import 'package:flutter/material.dart';
import 'package:guideguys/components/confirm_popup.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/text_styles.dart';
import 'package:guideguys/modules/guide_register/guide_register_view.dart';
import 'package:guideguys/modules/home/home_view.dart';
import 'package:guideguys/modules/login/login_view.dart';
import 'package:guideguys/components/textfield_sm.dart';
import 'package:guideguys/modules/register/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late RegisterViewModel _viewModel;
  bool isCheckedT = false;
  bool isCheckedG = false;
  TextEditingController usernameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController confirmPasswordText = TextEditingController();
  TextEditingController firstNameText = TextEditingController();
  TextEditingController lastNameText = TextEditingController();
  TextEditingController phoneNumberText = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = RegisterViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    usernameText.dispose();
    emailText.dispose();
    passwordText.dispose();
    confirmPasswordText.dispose();
    firstNameText.dispose();
    lastNameText.dispose();
    phoneNumberText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'สร้างบัญชีใหม่',
                  style: titlePuple,
                ),
                sizedBox(),
                TextFieldSM(
                  labelTFF: 'ชื่อบัญชี',
                  textController: usernameText,
                  inputAction: TextInputAction.next,
                  hintTextinTFF: 'Username',
                ),
                sizedBox(),
                TextFieldSM(
                  labelTFF: 'อีเมล',
                  textController: emailText,
                  inputAction: TextInputAction.next,
                  hintTextinTFF: 'Email',
                  pfIcon: const Icon(
                    Icons.mail_outline,
                    color: grey500,
                  ),
                ),
                sizedBox(),
                TextFieldSM(
                  labelTFF: 'รหัสผ่าน',
                  hintTextinTFF: 'Password',
                  textController: passwordText,
                  inputAction: TextInputAction.next,
                ),
                // sizedBox(),
                // TextFieldSM(
                //   labelTFF: 'ยืนยันรหัสผ่าน',
                //   hintTextinTFF: 'Confirm Password',
                //   textController: confirmPasswordText,
                //   inputAction: TextInputAction.next,
                //   onTextChenged: (value) {

                //   },
                // ),
                sizedBox(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFieldSM(
                        labelTFF: 'ชื่อ-นามสกุล',
                        hintTextinTFF: 'First name',
                        textController: firstNameText,
                        inputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFieldSM(
                        labelTFF: '',
                        hintTextinTFF: 'Last name',
                        textController: lastNameText,
                        inputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                sizedBox(),
                TextFieldSM(
                  labelTFF: 'เบอร์โทรติดต่อ',
                  hintTextinTFF: 'XXX-XXX-XXXXX',
                  textController: phoneNumberText,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                ),
                sizedBox(),
                chooseRole(),
                sizedBox(),
                bottomOperation()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column bottomOperation() {
    return Column(
      children: [
        TextButton(
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => ConfirmPopup(
              onCancel: () {
                Navigator.pop(context);
              },
              onConfirm: () async {
                try {
                  bool registerResponse = await _viewModel.onCreateAccount(
                    username: usernameText.text,
                    email: emailText.text,
                    password: passwordText.text,
                    firstName: firstNameText.text,
                    lastName: lastNameText.text,
                    phoneNumber: phoneNumberText.text,
                  );
                  if (!mounted) return;
                  if (isCheckedT) {
                    // print(registerResponse);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const HomeView(),
                      ),
                    );
                  } else if (isCheckedG) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const GuideRegisterView(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        padding: EdgeInsets.all(20),
                        backgroundColor: grey500,
                        content: Text('โปรดเลือกบทบาทการสมัคร'),
                      ),
                    );
                  }
                } catch (_) {
                  rethrow;
                }
              },
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: bgPurple,
            foregroundColor: white,
            //padding: EdgeInsets.all(5)
          ),
          child: const Text(
            'สร้างบัญชี',
            style: TextStyle(fontSize: 20),
          ),
        ),
        sizedBox(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const LoginView(),
              ),
            );
          },
          child: const Text(
            "Login",
            style: TextStyle(
              color: bgPurple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Column chooseRole() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'คุณเป็นนักท่องเที่ยวหรือไกด์',
          style: TextStyle(
            color: grey700,
            fontSize: 15,
          ),
        ),
        Row(
          children: [
            Checkbox(
              fillColor: MaterialStateProperty.resolveWith((states) => yellow),
              side: const BorderSide(color: yellow),
              checkColor: grey700,
              shape: const CircleBorder(),
              value: isCheckedT,
              onChanged: (value) {
                if (isCheckedG) {
                  setState(() {
                    isCheckedT = value!;
                    isCheckedG = !value;
                  });
                  return;
                }
                setState(() {
                  isCheckedT = true;
                });
              },
            ),
            const Text(
              'นักท่องเที่ยว',
              style: TextStyle(color: grey700),
            ),
            const SizedBox(width: 10),
            Checkbox(
              fillColor: MaterialStateProperty.resolveWith((states) => yellow),
              side: const BorderSide(color: yellow),
              checkColor: grey700,
              shape: const CircleBorder(),
              value: isCheckedG,
              onChanged: (value) {
                if (isCheckedT) {
                  setState(() {
                    isCheckedG = value!;
                    isCheckedT = !value;
                  });
                  return;
                }
                setState(() {
                  isCheckedG = true;
                });
              },
            ),
            const Text(
              'ไกด์',
              style: TextStyle(color: grey700),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox sizedBox() => const SizedBox(height: 10);
}
