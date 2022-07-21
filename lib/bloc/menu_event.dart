import 'package:equatable/equatable.dart';

class MenuEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => const [];
}

class LogInEvent extends MenuEvent{}
class LogOutEvent extends MenuEvent{}
class ActivateMenu extends MenuEvent{
  final int active;
  ActivateMenu({required this.active});
}