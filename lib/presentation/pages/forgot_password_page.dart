// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/router.dart';
import '../../tools.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../widgets/button_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blue))),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is PasswordResetSentEmailSuccess) {
                        Navigator.of(context).pop();
                        GlobalSnackBar.showSnackBar(
                            'Success', 'Success sent email', Duration(seconds: 2));
                      }

                      if (state is AuthFailure) {
                        GlobalSnackBar.showSnackBar('Failed', state.message, Duration(seconds: 2));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomFilledButton.text(
                          text: 'SENT EMAIL',
                          textStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          color: Colors.blue,
                          onPressed: () {
                            context.read<AuthBloc>().add(ForgotPasswordEvent(emailController.text));
                          });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
