import 'package:flutter/material.dart';

class ConnectivityState {
  String message;

  ConnectivityState({
    required this.message
  });

  ConnectivityState copyWith({
    String? message,
  }) {
    return ConnectivityState(message: message ?? '');
  }
}