part of 'profile_detail_cubit.dart';

sealed class ProfileDetailState extends Equatable {
  const ProfileDetailState();

  @override
  List<Object> get props => [];
}

final class ProfileDetailInitial extends ProfileDetailState {}

final class ProfileDetailLoading extends ProfileDetailState {}

final class ProfileDetailSuccess extends ProfileDetailState {
  final UserEntities userEntities;
  const ProfileDetailSuccess(this.userEntities);

  @override
  List<Object> get props => [userEntities];
}

final class ProfileDetailFailed extends ProfileDetailState {
  final String message;
  const ProfileDetailFailed(this.message);

  @override
  List<Object> get props => [message];
}
