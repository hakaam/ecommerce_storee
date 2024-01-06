import 'package:equatable/equatable.dart';

abstract class BottomNavigationState extends Equatable {
  final int selectedIndex;

  BottomNavigationState(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

class BottomNavigationInitialState extends BottomNavigationState {
  BottomNavigationInitialState(int selectedIndex) : super(selectedIndex);
}