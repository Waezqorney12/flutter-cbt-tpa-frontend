part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState {
  const ForgotPasswordState();
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class SendEmailSuccess extends ForgotPasswordState {
  final String message;

  const SendEmailSuccess(this.message);
}

final class VerifyCodeSuccess extends ForgotPasswordState {
  final String message;

  const VerifyCodeSuccess(this.message);
}

final class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  const ForgotPasswordError(this.message);
}
