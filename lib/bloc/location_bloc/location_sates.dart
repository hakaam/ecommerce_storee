// location_states.dart
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationInitialState extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final Position currentPosition;
  final String currentAddress;

  LocationLoadedState({required this.currentPosition, required this.currentAddress});

  @override
  List<Object?> get props => [currentPosition, currentAddress];
}

class LocationErrorState extends LocationState {
  final String errorMessage;

  LocationErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
