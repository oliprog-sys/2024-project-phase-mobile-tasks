import 'package:authentication_feature/features/auth/domain/usecases/get_saved_token_usecase.dart';
import 'package:authentication_feature/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:authentication_feature/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:authentication_feature/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_event.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase signInUseCase;
  final SignUpUsecase signUpUseCase;
  final LogOutUsecase logOutUseCase;
  final GetSavedTokenUsecase getSavedTokenUsecase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.logOutUseCase,
    required this.getSavedTokenUsecase,
  }) : super(AuthInitial()) {
    on<SignInRequested>(onSignInRequested);
    on<SignUpRequested>(onSignUpRequested);
    on<SignOutRequested>(onSignOutRequested);
  }

  Future<void> onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await signInUseCase(event.email, event.password);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError('Sign in failed: ${e.toString()}'));
      emit(Unauthenticated(message: 'Invalid email or password'));
    }
  }

  Future<void> onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await signUpUseCase(event.name, event.email, event.password);
      emit(SignUpSuccess('Account created successfully! Please sign in.'));
    } catch (e) {
      emit(AuthError('Sign up failed: ${e.toString()}'));
      emit(Unauthenticated(message: 'Sign up failed'));
    }
  }

  Future<void> onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await logOutUseCase();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError('Sign out failed: ${e.toString()}'));
      emit(const Unauthenticated());
    }
  }
}
