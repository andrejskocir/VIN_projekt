import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_example/widgets/BathFillProgress.dart'; // Ensure correct import

import "../utils/snackbar.dart";
import 'package:flutter_blue_plus_example/local_notifications.dart';

class CharacteristicTile extends StatefulWidget {
  final BluetoothCharacteristic characteristic;

  const CharacteristicTile({Key? key, required this.characteristic}) : super(key: key);

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {
  late StreamSubscription<List<int>> _notificationSubscription;
  double currentDistance = 40; // Default to 40 cm, considered 0% full

  @override
  void initState() {
    super.initState();
    _startListeningToNotifications();
  }

  @override
  void dispose() {
    _notificationSubscription.cancel();
    super.dispose();
  }

  BluetoothCharacteristic get c => widget.characteristic;

  void _startListeningToNotifications() async {
    try {
      // Enable notifications
      await c.setNotifyValue(true);

      // Subscribe to the characteristic's notification stream
      _notificationSubscription = c.value.listen((value) {
        // Handle the received data
        _handleNotification(value);
      });
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Notification Error:", e), success: false);
    }
  }

  void _handleNotification(List<int> value) {
    // Assuming the value is sent as a UTF-8 string representing the distance in cm
    String valueString = utf8.decode(value);
    double? distance = double.tryParse(valueString);

    if (distance != null) {
      setState(() {
        currentDistance = distance; // Update the distance from the characteristic
      });
    }

    // Notification condition changed to new threshold of 20 cm
    if (distance != null && distance <= 20) {
      LocalNotifications.showSimpleNotification(
        title: "Water level is high",
        body: "Water level at $distance cm, which is above safety threshold.",
        payload: "",
      );
    }

    // Optionally, display the value in the Snackbar
    Snackbar.show(ABC.c, "Water level updated to $distance cm", success: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0), // Add padding on top (16.0 is an example)
      child: BathFillProgress(distance: currentDistance), // Pass the distance to the progress widget
    );
  }
}
