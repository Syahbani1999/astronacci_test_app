import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    await Future.delayed(Duration(seconds: 2));
    animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        // return Future.delayed(Duration(seconds: 2))
        //     .then((value) => context.goNamed(Routes.splashscreenRoute));
        // if (checkUpdate.value) {
        //   return;
        // } else if (isFirstTime) {
        //   var duration = const Duration(seconds: 2);
        //   return Future.delayed(duration).then((value) => Get.offNamed(Routes.ONBOARD));
        // } else if (token) {
        //   authController.getUser();
        //   var duration = const Duration(seconds: 2);
        //   return Future.delayed(duration).then((value) => Get.offNamed(Routes.TABBAR));
        // } else {
        //   var duration = const Duration(seconds: 2);
        //   return Future.delayed(duration).then((value) => Get.offNamed(Routes.LOGIN));
        // }
      }
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
      body: FadeTransition(
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
    );
  }
}
