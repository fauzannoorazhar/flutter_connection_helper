import 'package:connectivity/connectivity.dart';
import 'package:connectivity_helper/blocs/connectivity/connectivity_event.dart';
import 'package:connectivity_helper/blocs/connectivity/connectivity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity connectivity = Connectivity();
  ConnectivityBloc(ConnectivityState initialState) : super(initialState);

  @override
  ConnectivityState get initialState => ConnectivityState(message: 'failed to connect network');

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    if (event is CheckConnectivityEvent) {
      yield* streamConnectivity();
    } else if (event is UpdateConnectivityEvent) {
      yield* updateConnectivity(event.message);
    }
  }

  Stream<ConnectivityState> streamConnectivity() async* {
    var connectivityResult = await (Connectivity().checkConnectivity());

    // Check first connectivity state
    if (connectivityResult == ConnectivityResult.mobile) {
      yield state.copyWith(message: 'success connect to mobile network');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      yield state.copyWith(message: 'success connect to wifi network');
    } else {
      yield state.copyWith(message: 'failed connect to network');
    }

    // Listen to check connectivity state (mobile / wifi)
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        add(UpdateConnectivityEvent('success connect to mobile network'));
      } else if (result == ConnectivityResult.wifi) {
        add(UpdateConnectivityEvent('success connect to wifi network'));
      } else {
        add(UpdateConnectivityEvent('failed connect to network'));
      }
    });
  }

  Stream<ConnectivityState> updateConnectivity(String message) async* {
    yield state.copyWith(message: message);
  }
}