import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'coordinates_event.dart';
part 'coordinates_state.dart';

class CoordinatesBloc extends Bloc<CoordinatesEvent, CoordinatesState> {
  CoordinatesBloc() : super(CoordinatesInitial()) {
    on<pickCoordinateEvent>((event, emit) async {
      emit(CoordinatesInitial());
    
      try {
        emit(coordinatesPicking());
        if (!await Geolocator.isLocationServiceEnabled()) {
          emit(LocationServiceDisabled());
          return;
        }

        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          // Request permission
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            emit(PermissionDenied());
            return;
          }
        }

         if (permission == LocationPermission.deniedForever) {
          emit(PermissionDeniedForever());
          return;
        }

        
         final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
            emit (coordinatesPicked(coordinates: position));

            

      } catch (e) {
        emit(coordinatesError(error: e.toString()));
      }
    });
  }
}
