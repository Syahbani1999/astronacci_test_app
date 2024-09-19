// ignore_for_file: prefer_const_constructors

import 'package:astronacci_test_app/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/router.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../widgets/button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthSuccess) {
          goRouter.pushReplacementNamed(Routes.homepageRoute);
          GlobalSnackBar.showSnackBar('Success', 'Welcome ${state.user.name}', Duration(seconds: 2));
        }
        if (state is AuthFailure) {
          GlobalSnackBar.showSnackBar('Failed', state.message, Duration(seconds: 2));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 120),
                      // NOTE: EMAIL INPUT
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.blue))),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // NOTE: PASSWORD INPUT
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.blue))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      CustomFilledButton.text(
                        color: Colors.blue,
                        text: 'Sign In',
                        textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        borderRadius: 12,
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                SignInEvent(usernameController.text, hashPassword(passwordController.text)),
                              );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // CustomFilledButton.text(
                //   color: Colors.grey.shade300,
                //   text: 'Create New Account',
                //   onPressed: () {},
                // ),
                TextButton(
                    onPressed: () {
                      goRouter.pushNamed(Routes.registerRoute);
                    },
                    child: const Text(
                      'Create New Account',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
