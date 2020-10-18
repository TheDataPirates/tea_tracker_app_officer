import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';

class WitheringLoftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Withering Loft'),),
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
                  name: 'Withering Start',
                  destination: 'WitheringStart',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Withering Mixing',
                  destination: 'WitheringMixing',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Withering Finish',
                  destination: 'WitheringFinish',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Trough Unloading',
                  destination: 'TroughUnloading',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
