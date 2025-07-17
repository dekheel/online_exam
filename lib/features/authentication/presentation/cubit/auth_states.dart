import 'package:online_exam/core/errors/failure.dart';
import 'package:online_exam/features/authentication/data/models/auth_response_dto.dart';
import 'package:online_exam/features/authentication/domain/entities/auth_response_entity.dart';

sealed class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {
  final AuthResponseEntity authResponseEntity;
  AuthSuccessState(this.authResponseEntity);
}

class AuthFailureState extends AuthStates {
  final Failure error;
  AuthFailureState({required this.error});
}

class FormValidationState extends AuthStates {
  FormValidationState();
}
