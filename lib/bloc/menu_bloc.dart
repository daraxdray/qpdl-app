
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qpdl/bloc/menu_event.dart';

import 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent,MenuState>{
  static int activeUrl = 0;
  MenuBloc() : super(LoggedOut()){
    on<LogInEvent>(login);
    on<LogOutEvent>(logout);
    on<ActivateMenu>(isActive);
    // on(ActivateMenu,emit) => emit(ActivateMenu());

  }

  void login(LogInEvent event, Emitter<MenuState> emit){
    emit(LoggedIn());
  }
  void logout(LogOutEvent event, Emitter<MenuState> emit){
    emit(LoggedOut());
  }
  void isActive(ActivateMenu event, Emitter<MenuState> emit){
    activeUrl = event.active;
  }

}
