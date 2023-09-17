import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kooha/providers/login_provider.dart';
import 'package:kooha/utils/color.dart'; 
import 'package:kooha/widget/back_button.dart';
import 'package:kooha/widget/custom_elevated_button.dart';
import 'package:kooha/widget/iconss.dart';
import 'package:kooha/widget/input_field.dart';
import 'package:kooha/widget/spacing.dart';
import 'package:kooha/widget/texts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String loginScreen = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget suffix = const SizedBox.shrink();
  final LoginProvider _loginProvider = Get.put(LoginProvider());

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Widget mainSuffix = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox.square(
            dimension: 20,
            child: LoginProvider.getEmailValidity == EmailValidity.isValid
                ? IconOf(Icons.done, 20)
                : LoginProvider.getEmailValidity == EmailValidity.processing
                    ? CircularProgressIndicator(
                        strokeWidth: 2.25,
                        color: AppColors.secondaryColor,
                      )
                    : LoginProvider.getEmailValidity == EmailValidity.invalid
                        ? IconOf(Icons.cancel_outlined, 20)
                        : const SizedBox.shrink()),
        const XMargin(20)
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const ExitButton(),
                                Container(
                                  height: 39,
                                  decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius: BorderRadius.circular(50)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: TextOf(
                                      "Switch to Create account",
                                      14,
                                      AppColors.secondaryColor,
                                      FontWeight.w500),
                                )
                              ],
                            ),
                            const YMargin(20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextOf('Welcome Back!', 24, AppColors.white,
                                        FontWeight.w700),
                                    const YMargin(10),
                                    TextOf(
                                        "Be ready to use Kooha in less than 2min ⚡️",
                                        14,
                                        AppColors.deepGrey,
                                        FontWeight.w500)
                                  ],
                                )
                              ],
                            ),
                            const YMargin(50),
                            Inputfield(
                                title: "Email",
                                suffixIcon: suffix,
                                validator: _loginProvider.emailValidator,
                                fieldName: "john@email.com",
                                onChanged: (e) {
                                  LoginProvider.email.value = e!;
                                  LoginProvider.setValidEmail();
                                  setState(() {
                                    suffix = mainSuffix;
                                  });
                                }),
                            const YMargin(15),
                            Inputfield(
                                title: "Password",
                                validator: _loginProvider.passwordValidator,
                                isPassword: true,
                                fieldName: "Password (min. of 8 characters)",
                                onChanged: (e) {
                                  LoginProvider.password.value = e!.toString();
                                }),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom *
                                  0.69),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextOf("Forgot Password?", 14, AppColors.deepGrey,
                                  FontWeight.w500),
                              TextButton(
                                  onPressed: () {},
                                  child: TextOf(
                                      "Reset it",
                                      14,
                                      AppColors.secondaryColor,
                                      FontWeight.w700))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomElevatedButton(
                            enabled: (LoginProvider.email.value.isEmpty ||
                                    LoginProvider.password.value.isEmpty)
                                ? false
                                : true,
                            text: "Log me in",
                            onTap: () {
                              if (_formKey.currentState?.validate() == true) {
                                _loginProvider.login(context);
                              }
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
