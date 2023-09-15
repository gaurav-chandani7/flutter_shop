import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/view/screens/home_screen/home_screen.dart';
import 'package:flutter_shop/view/screens/login_screen.dart';
import 'package:flutter_shop/view_model/cubit/initial_authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlutterShopApp());
}

class FlutterShopApp extends StatelessWidget {
  const FlutterShopApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitialAuthenticationCubit(app: app),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.brown.shade400,
            ),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                titleTextStyle: TextStyle(fontSize: 17, color: Colors.black))),
        home:
            BlocBuilder<InitialAuthenticationCubit, InitialAuthenticationState>(
          builder: (context, state) {
            if (state is LoggedInState) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
