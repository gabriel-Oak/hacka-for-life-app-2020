import 'package:bloc/bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  @override
  ProfileState get initialState => ProfileState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {}
}
