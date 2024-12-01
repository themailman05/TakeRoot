import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:takeroot/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState();
  late final StreamSubscription<AuthState> _authStateSubscription;
  bool _redirecting = false;

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting || !mounted) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        context.go('/home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text('TakeRoot'),
          ElevatedButton(
            onPressed: () =>
                supabase.auth.signInWithOAuth(OAuthProvider.google),
            child: const Text('Login'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
