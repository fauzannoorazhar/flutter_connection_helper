

import 'dart:ffi';

import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {
  ConnectivityEvent([List props = const []]);
}

class CheckConnectivityEvent extends ConnectivityEvent {
  @override
  List<Object> get props => [];
}

class UpdateConnectivityEvent extends ConnectivityEvent {
  final String message;

  UpdateConnectivityEvent(this.message);

  @override
  List<Object> get props => [];
}