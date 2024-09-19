import 'package:astronacci_test_app/firebase_options.dart';
import 'package:astronacci_test_app/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:astronacci_test_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/router.dart';
import 'tools.dart';
import 'injections.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di.locator<AuthBloc>()..add(AuthCheckStatus())),
        BlocProvider<UserBloc>(create: (context) => di.locator<UserBloc>()),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: GlobalSnackBar.scaffoldMessengerKey,
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
        routeInformationProvider: goRouter.routeInformationProvider,
        title: 'Astronacci Test',
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
