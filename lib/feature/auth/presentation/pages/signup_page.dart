import 'dart:developer';

import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feature/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/feature/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignupPage());

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up.",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                AuthField(hintText: "Name", controller: nameController),
                SizedBox(height: 15),
                AuthField(hintText: "Email", controller: emailController),
                SizedBox(height: 15),
                AuthField(
                  hintText: "Password",
                  controller: passwordController,
                  isObscure: true,
                ),
                SizedBox(height: 20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      showSnackBar(context, "registration successful");
                      log("auth---> success ${state.user}");
                    }
                    if (state is AuthError) {
                      showSnackBar(context, state.message);
                      log("auth---> error ${state.message}");
                    }
                  },
                  builder: (context, state) {
                    return AuthGradientButton(
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            AuthSignUp(
                              email: emailController.text.trim(),
                              name: nameController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                      text: "Sign Up",
                    );
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.push(context, LoginPage.route());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
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
