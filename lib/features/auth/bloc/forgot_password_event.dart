part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendEmailEvent extends ForgotPasswordEvent {
  final String email;
  const SendEmailEvent({required this.email});
  @override
  List<Object> get props => [email];
}

class VerifyOtpCodeEvent extends ForgotPasswordEvent {
  final String otpCode;
  const VerifyOtpCodeEvent({required this.otpCode});
  @override
  List<Object> get props => [otpCode];
}
