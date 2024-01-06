
import 'package:bloc/bloc.dart';

import 'bottom_navgation_states.dart';



class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationInitialState(0));

  void onItemTap(int index) {
    emit(BottomNavigationInitialState(index));
  }
}
