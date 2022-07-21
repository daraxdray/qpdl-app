import 'package:equatable/equatable.dart';

class MenuState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => const [];

}

class IsActiveMenu extends MenuState{
  final int active;
  IsActiveMenu({required this.active});
}
class LoggedIn extends MenuState{}

class LoggedOut extends MenuState{}