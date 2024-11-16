import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_potensial/features/auth/domain/usecases/user_forgot_password_usecases.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserSendEmailUsecases _userSendEmail;
  final UserVerifyOtpCodeUsecases _userVerifyOtpCode;
  ForgotPasswordBloc({
    required UserSendEmailUsecases userSendEmail,
    required UserVerifyOtpCodeUsecases userVerifyOtpCode,
  })  : _userSendEmail = userSendEmail,
        _userVerifyOtpCode = userVerifyOtpCode,
        super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) => emit(ForgotPasswordLoading()));
    on<SendEmailEvent>(
      (event, emit) async {
        final response = await _userSendEmail(event.email);
        response.fold((l) => emit(ForgotPasswordError(l.message)), (r) {
          emit(SendEmailSuccess(r));
          emit(ForgotPasswordInitial());
        });
      },
    );
    on<VerifyOtpCodeEvent>(
      (event, emit) async {
        final response = await _userVerifyOtpCode(event.otpCode);
        response.fold(
          (l) => emit(ForgotPasswordError(l.message)),
          (r) {
            emit(VerifyCodeSuccess(r));
            emit(ForgotPasswordInitial());
          },
        );
      },
    );
  }
}
