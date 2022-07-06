import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/sign_up.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCSrUYK-hamCUQkdwBRcO0djgQgKYzAiHg",
            authDomain: "chatapp-2787e.firebaseapp.com",
            projectId: "chatapp-2787e",
            storageBucket: "chatapp-2787e.appspot.com",
            messagingSenderId: "546357169295",
            appId: "1:546357169295:web:27c94b4607079a42f234fa"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const HomePage();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
            }

            return const SignUp();
          },
        ),
      ),
    );
  }
}
