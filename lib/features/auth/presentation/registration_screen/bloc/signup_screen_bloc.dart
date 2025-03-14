import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/auth/domain/usecases/signup_usecase.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

part 'signup_screen_event.dart';
part 'signup_screen_state.dart';

class SignUpScreenBloc extends Bloc<SignUpScreenEvent, SignUpScreenState> {
  final RegisterUseCase registerUseCase;

  SignUpScreenBloc(this.registerUseCase) : super(SignUpInitial()) {
    on<RegisterEvent>(_onRegisterEvent);
    on<CheckLoginStatusEvent>(_onCheckLoginStatusEvent);
  }

  Future<void> _onCheckLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<SignUpScreenState> emit) async {
    final accessToken = await AppSharedPref.getAccessToken();
    final refreshToken = await AppSharedPref.getRefreshToken();
    final user = await AppSharedPref.getAuthUser();
    if (accessToken != null) {
      emit(SignedUp(
          accessToken: accessToken,
          refreshToken: refreshToken!,
          user: user as UserModel));
    } else {
      emit(SignUpInitial());
    }
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<SignUpScreenState> emit) async {
    emit(SignUpLoading());
    final validationErrors = _validateRegistration(event);
    if (validationErrors.isNotEmpty) {
      emit(SignUpValidationError(validationErrors));
      return;
    }
    try {
      await registerUseCase(
          event.name, event.email, event.password, event.confirmPassword);
      emit(RegisteredCompleted());
    } catch (e) {
      if (e is ValidationException) {
        emit(SignUpValidationError(e.errors));
      } else {
        emit(SignUpError(e.toString()));
      }
    }
  }

  Map<String, dynamic> _validateRegistration(RegisterEvent event) {
    final errors = <String, dynamic>{};

    if (event.name.isEmpty) {
      errors['name'] = ['Name cannot be empty'];
    }
    if (event.email.isEmpty) {
      errors['email'] = ['Email cannot be empty'];
    }
    if (event.password.isEmpty) {
      errors['password'] = ['Password cannot be empty'];
    }
    if (event.confirmPassword.isEmpty) {
      errors['confirm_password'] = ['Confirm Password cannot be empty'];
    } else if (event.password != event.confirmPassword) {
      errors['confirm_password'] = ['Passwords do not match'];
    }

    return errors;
  }
}
