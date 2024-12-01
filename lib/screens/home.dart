import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TakeRootHome extends StatefulWidget {
  const TakeRootHome({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<TakeRootHome> createState() => _TakeRootHomeState();
}

class _TakeRootHomeState extends State<TakeRootHome> {
  final supabase = Supabase.instance.client;
  bool _isLoading = false;
  bool _redirecting = false;
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting || !mounted) return;
      final session = data.session;
      if (session == null) {
        _redirecting = true;
        context.go('/login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(children: [
        const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue), child: Text("Menu")),
        ListTile(
          title: Text('LogOut'),
          onTap: supabase.auth.signOut,
        ),
      ])),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('TakeRoot'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('I am logged in'),
          ],
        ),
      ),
    );
  }
}
