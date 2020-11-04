import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Main menu'),
        leading: IconButton(
          icon: Icon(Icons.home),
          iconSize: 30,
          onPressed: () {
            auth.logout();
            Navigator.of(context).pushReplacementNamed('/');
//            Navigator.of(context).pushReplacementNamed('LoginScreen');
          },
        ),
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
                  destination: 'BoughtLeaf',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Withering Loft',
                  destination: 'WitheringLoft',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Rolling Room',
                  destination: 'RollingRoom',
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
                  destination: 'RollBreakingRoom',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Fermenting Room',
                  destination: 'FermentingRoom',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Drying Room',
                  destination: 'DryingRoom',
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
                  destination: 'ShiftingRoom',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Packing Room',
                  destination: 'PackingRoom',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Dispatching Room',
                  destination: 'DispatchingRoom',
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
                  destination: 'ReMeasuring',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'Difference Report',
                  destination: 'DifferenceReport',
                ),
                MainMenuFlatButtonContainer(
                  height: _height,
                  width: _width,
                  name: 'View All Sections',
                  destination: 'ViewAllSections',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
