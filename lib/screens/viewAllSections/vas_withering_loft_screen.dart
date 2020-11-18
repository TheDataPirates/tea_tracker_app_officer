import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';

class VasWitheringLoftScreen extends StatefulWidget {
  @override
  _VasWitheringLoftScreenState createState() => _VasWitheringLoftScreenState();
}

class _VasWitheringLoftScreenState extends State<VasWitheringLoftScreen> {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Loft'),
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
                  name: 'Withering Start',
                  destination: 'VasWitheringStarting',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Withering Mixing',
                  destination: 'VasWitheringMixing',
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
                  destination: 'VasWitheringFinishing',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Withering Unloading',
                  destination: 'VasWitheringUnloadingBatchChoosing',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

