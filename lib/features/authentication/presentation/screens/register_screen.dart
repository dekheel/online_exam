import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/di/di.dart';
import 'package:online_exam/core/dialog/dialog_utils.dart';
import 'package:online_exam/core/l10n/app_localizations.dart';
import 'package:online_exam/core/routing/routes.dart';
import 'package:online_exam/core/validator/validator.dart';
import 'package:online_exam/features/authentication/presentation/screens/widgets/custom_txt_form_field.dart';

import '../../domain/usecases/register_use_case.dart';
import '../cubit/auth_states.dart';
import '../cubit/register_view_model.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  RegisterViewModel viewModel = RegisterViewModel(getIt<RegisterUseCase>());

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return BlocConsumer<RegisterViewModel, AuthStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is AuthSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            content:
                state.authResponseEntity.message ??
                localizations.user_created_successfully,
            posActions: localizations.ok,
            posFunction: (p0) {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          );
        } else if (state is AuthFailureState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            content: state.error.message,
            negActions: localizations.ok,
          );
        } else if (state is AuthLoadingState) {
          DialogUtils.showLoading(context: context, loadingMessage: "loading");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.sign_up),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios),
            ),
            leadingWidth: 16.w,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Form(
                key: viewModel.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 15.h,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTxtFormField(
                        labelText: localizations.user_name,
                        hintText: localizations.enter_your_user_name,
                        controller: viewModel.username,
                        validator: (val) {
                          return AppValidators.validateUsername(context, val);
                        },
                        onChanged: (value) => viewModel.validateForm(),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 17.w,
                        children: [
                          Expanded(
                            child: CustomTxtFormField(
                              labelText: localizations.first_name,
                              hintText: localizations.enter_first_name,
                              controller: viewModel.firstName,
                              validator: (val) {
                                return AppValidators.validateUsername(
                                  context,
                                  val,
                                );
                              },
                              onChanged: (value) => viewModel.validateForm(),
                            ),
                          ),
                          Expanded(
                            child: CustomTxtFormField(
                              labelText: localizations.last_name,
                              hintText: localizations.enter_last_name,
                              controller: viewModel.lastName,
                              validator: (val) {
                                return AppValidators.validateUsername(
                                  context,
                                  val,
                                );
                              },
                              onChanged: (value) => viewModel.validateForm(),
                            ),
                          ),
                        ],
                      ),

                      CustomTxtFormField(
                        labelText: localizations.email,
                        hintText: localizations.enter_your_email,
                        keyboardType: TextInputType.emailAddress,

                        controller: viewModel.email,
                        validator: (val) {
                          return AppValidators.validateEmail(context, val);
                        },
                        onChanged: (value) => viewModel.validateForm(),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 17.w,
                        children: [
                          Expanded(
                            child: CustomTxtFormField(
                              labelText: localizations.password,
                              keyboardType: TextInputType.text,

                              hintText: localizations.enter_password,
                              controller: viewModel.password,
                              validator: (val) {
                                return AppValidators.validatePassword(
                                  context,
                                  val,
                                );
                              },
                              onChanged: (value) => viewModel.validateForm(),
                            ),
                          ),
                          Expanded(
                            child: CustomTxtFormField(
                              labelText: localizations.confirm_password,
                              hintText: localizations.confirm_password,
                              keyboardType: TextInputType.text,

                              controller: viewModel.confirmPassword,
                              validator: (val) {
                                return AppValidators.validateConfirmPassword(
                                  context,
                                  val,
                                  viewModel.password.text,
                                );
                              },
                              onChanged: (value) => viewModel.validateForm(),
                            ),
                          ),
                        ],
                      ),

                      CustomTxtFormField(
                        labelText: localizations.phone_number,
                        hintText: localizations.enter_phone_number,
                        keyboardType: TextInputType.phone,
                        controller: viewModel.phone,
                        validator: (val) {
                          return AppValidators.validatePhoneNumber(
                            context,
                            val,
                          );
                        },
                        onChanged: (value) => viewModel.validateForm(),
                      ),

                      FilledButton(
                        onPressed:
                            viewModel.buttonEnabled
                                ? () {
                                  viewModel.register();
                                }
                                : null,
                        child: Text(localizations.login),
                      ),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "${localizations.already_have_an_account} ",
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: localizations.login,

                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        AppRoutes.login,
                                      );
                                    },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
