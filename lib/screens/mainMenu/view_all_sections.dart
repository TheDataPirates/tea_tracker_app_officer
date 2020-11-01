import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';

class ViewAllSectionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View All Sections'),
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
                  name: 'Bought Leaf',
                  destination: 'VasBoughtLeaf',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Withering Loft',
                  destination: 'VasWitheringLoft',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Rolling Room',
                  destination: 'VasRollingRoom',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Roll Breaking Room',
                  destination: 'VasRollBreakingRoom',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Fermenting Room',
                  destination: 'VasFermentingRoom',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Drying Room',
                  destination: 'VasDryingRoom',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Shifting Room',
                  destination: 'VasShiftingRoom',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Packing Room',
                  destination: 'VasPackingRoom',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Dispatching Room',
                  destination: 'VasDispatchingRoom',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Re-Measuring',
                  destination: 'VasReMeasuring',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
