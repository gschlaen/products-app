import 'package:flutter/material.dart';

class NotificationsService {
  // Este key mantiene la referencia con MaterialApp de manera
  //de poder mostrar notificaciones en toda la app
  static GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackbar = new SnackBar(content: Text(message, style: TextStyle(color: Colors.white, fontSize: 20)));

    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
