import 'package:flutter/material.dart';
import 'package:takeroot/router.dart';

class TakeRootApp extends StatefulWidget {
  const TakeRootApp({super.key});

  @override
  State<TakeRootApp> createState() => TakeRootAppState();
}

class TakeRootAppState extends State<TakeRootApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TakeRoot',
      routerConfig: router,
    );
  }
}
