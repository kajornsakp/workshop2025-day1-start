import 'package:app_links/app_links.dart';
import 'package:chopee/firebase_options.dart';
import 'package:chopee/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

final appLinks = AppLinks();
final authReadyCompleter = Completer<void>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // TODO: networking: use real network service

  // TODO: authentication: add firebase auth id token
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = router;

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  void _initDeepLinkListener() {
    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print('uri: ${uri.path}');
        _router.go(uri.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}
