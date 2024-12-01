import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SupabaseClient supabase;

  AuthenticationBloc(this.supabase) : super(Unauthenticated()) {
    on<BeginLogin>((event, emit) async {
      await for (final state in _nativeGoogleSignIn()) {
        emit(state);
      }
    });

    on<BeginLogout>((event, emit) async {
      await for (final state in _beginLogout()) {
        emit(state);
      }
    });
  }

  Stream<AuthenticationState> _nativeGoogleSignIn() async* {
    yield (AuthenticationInProgress());
    if (supabase.auth.currentUser != null) {
      yield Authenticated();
      return;
    } else {
      bool loggedInSuccessfully =
          await supabase.auth.signInWithOAuth(OAuthProvider.google);
      if (loggedInSuccessfully) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }
  }

  Stream<AuthenticationState> _beginLogout() async* {
    if (supabase.auth.currentUser == null) {
      return;
    } else {
      await supabase.auth.signOut();
      yield Unauthenticated();
    }
  }
}
