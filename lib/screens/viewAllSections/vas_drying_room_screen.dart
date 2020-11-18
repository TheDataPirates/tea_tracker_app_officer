import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';

class VasDryingRoomScreen extends StatefulWidget {
  @override
  _VasDryingRoomScreenState createState() => _VasDryingRoomScreenState();
}

class _VasDryingRoomScreenState extends State<VasDryingRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drying Room'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Drier Output',
                  destination: 'VasDrierOutput',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Outturn Report',
                  destination: 'VasOutturnReport',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


