import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';



class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitialState());

  Future<void> getCurrentPosition() async {
    print('getCurrentPosition called');
    emit(LocationLoadingState());

    bool hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      emit(LocationErrorState(errorMessage: 'Location permission denied.'));
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Position obtained: $position');
      String currentAddress = await fetchLocation(position); // Replace with your logic
      print('Current Address obtained: $currentAddress');
      emit(LocationLoadedState(currentPosition: position, currentAddress: currentAddress));
    } catch (e) {
      print('Error in getCurrentPosition: $e');
      emit(LocationErrorState(errorMessage: 'Error getting current position: $e'));
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print('Location services are disabled. Please enable the services');
      emit(LocationErrorState(errorMessage: 'Location services are disabled. Please enable the services'));
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        emit(LocationErrorState(errorMessage: 'Location permissions are denied'));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      emit(LocationErrorState(errorMessage: 'Location permissions are permanently denied, we cannot request permissions.'));
      return false;
    }

    return true;
  }

  // Use this method to emit states in LocationCubit
  void emitLocationLoadedState(Position position, String currentAddress) {
    emit(LocationLoadedState(currentPosition: position, currentAddress: currentAddress));
  }
}

Future<String> fetchLocation(Position position) async {
  try {
    print('Fetching location based on position: $position');
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks.isNotEmpty ? placemarks[0] : Placemark();
    String currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    print('Location fetched successfully: $currentAddress');
    return currentAddress;
  } catch (e) {
    print('Error in fetchLocation: $e');
    throw Exception('Error getting address from coordinates: $e');
  }
}






// location_states.dart

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
















