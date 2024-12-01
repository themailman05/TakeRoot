import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:takeroot/app.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const TakeRootApp());
}

Future<void> initializeDependencies() async {
  setPathUrlStrategy();

  await Supabase.initialize(
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    url: 'https://lrecpcqinuizepaqbevt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxyZWNwY3FpbnVpemVwYXFiZXZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI4MTk0NTQsImV4cCI6MjA0ODM5NTQ1NH0.XNKt4m0JGgXBTKpaQ8B7Dfa7QDWALuSbMIBDLDjAGaU',
  );
}

final supabase = Supabase.instance.client;
