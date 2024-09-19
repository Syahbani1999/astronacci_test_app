import 'package:astronacci_test_app/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../routes/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  startSplashScreen() async {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);

    animationController.forward();
    animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashScreen();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthSuccess) {
            context.pushReplacementNamed(Routes.homepageRoute);
          } else {
            context.pushReplacementNamed(Routes.loginRoute);
          }
        },
        child: FadeTransition(
          opacity: animation,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'BLoC Pattern',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
