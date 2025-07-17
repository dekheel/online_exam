import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/authentication/domain/usecases/register_use_case.dart';
import 'package:online_exam/features/authentication/presentation/cubit/auth_states.dart';

import '../../domain/entities/auth_response_entity.dart';

@injectable
class RegisterViewModel extends Cubit<AuthStates> {
  RegisterUseCase registerUseCase;
  RegisterViewModel(this.registerUseCase) : super(AuthInitialState());

  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool buttonEnabled = false;

  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(AuthLoadingState());
    var either = await registerUseCase.invoke(
      username: username.text,
      firstName: firstName.text,
      lastName: lastName.text,
      email: email.text,
      password: password.text,
      rePassword: confirmPassword.text,
      phone: phone.text,
    );

    either.fold(
      (authResponseEntity) {
        emit(AuthSuccessState(authResponseEntity));
      },
      (error) {
        emit(AuthFailureState(error: error));
      },
    );
  }

  void validateForm() {
    if (username.text.isNotEmpty &&
        firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty &&
        phone.text.isNotEmpty) {
      buttonEnabled = true;
    } else {
      buttonEnabled = false;
    }
    if (buttonEnabled) {
      emit(FormValidationState());
    }
  }
}
