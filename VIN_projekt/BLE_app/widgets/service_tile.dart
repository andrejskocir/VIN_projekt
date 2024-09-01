import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'characteristic_tile.dart';

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile({Key? key, required this.service, required this.characteristicTiles}) : super(key: key);

  Widget buildUuid(BuildContext context) {
    String uuid = '0x${service.uuid.str.toUpperCase()}';
    return Text(uuid, style: TextStyle(fontSize: 13));
  }

  @override
  Widget build(BuildContext context) {
    // Only display the service if its UUID is 0xFFE0
    if (service.uuid.toString().toUpperCase().contains('FFE0')) {
      return
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: characteristicTiles
      );
    } else {
      // If it's not the specified service, return an empty container
      return SizedBox.shrink();
    }
  }
}
