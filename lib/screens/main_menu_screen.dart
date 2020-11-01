import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Bought Leaf', destination: 'BoughtLeaf',),
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Withering Loft', destination: 'WitheringLoft',),
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Rolling Room', destination: 'RollingRoom',),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Roll Breaking Room', destination: 'RollBreakingRoom',),
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Fermenting Room', destination: 'FermentingRoom',),
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Drying Room', destination: 'DryingRoom',),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Shifting Room', destination: 'ShiftingRoom',),
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Packing Room', destination: 'PackingRoom',),
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Dispatching Room', destination: 'DispatchingRoom',),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Re-Measuring', destination: 'ReMeasuring',),
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Difference Report', destination: 'DifferenceReport',),
                MainMenuFlatButtonContainer(height: _height, width: _width, name: 'View All Sections', destination: 'ViewAllSections',),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
