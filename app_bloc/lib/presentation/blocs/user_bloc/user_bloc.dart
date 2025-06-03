import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_users.dart';
import '../../../domain/entities/user.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;

  late List<User> allUsers;

  UserBloc({required this.getUsers}) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());

      final failureOrUsers = await getUsers.call();

      failureOrUsers.fold(
        (failure) => emit(UserError(failure.toString())),
        (users) {
          allUsers = users;
          emit(UserLoaded(users));
        },
      );
    });

    on<FilterUsers>((event, emit) {
      final query = event.query.toLowerCase();
      final filtered = allUsers.where((user) {
        return user.id.toString().contains(query) ||
            user.name.toLowerCase().contains(query) ||
            user.email.toLowerCase().contains(query);
      }).toList();

      emit(UserLoaded(filtered));
    });
  }
}
