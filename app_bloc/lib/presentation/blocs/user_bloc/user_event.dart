part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {}

class FilterUsers extends UserEvent {
  final String query;

  const FilterUsers(this.query);

  @override
  List<Object?> get props => [query];
}
