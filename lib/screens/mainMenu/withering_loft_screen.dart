import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/constants.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WitheringLoftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Loft'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.jpg"),
            fit: BoxFit.cover,
          ),
          gradient: kUIGradient,
        ),
        child: SafeArea(
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
                    destination: 'WitheringStarting',
                    icon: FontAwesomeIcons.leaf,
                  ),
                  MainMenuFlatButtonContainer(
                    height: _height,
                    width: _width,
                    name: 'Withering Mixing',
                    destination: 'WitheringMixing',
                    icon: FontAwesomeIcons.leaf,
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
                    destination: 'WitheringFinishing',
                    icon: FontAwesomeIcons.leaf,
                  ),
                  MainMenuFlatButtonContainer(
                    height: _height,
                    width: _width,
                    name: 'Withering Unloading',
                    destination: 'WitheringUnloadingBatchChoosing',
                    icon: FontAwesomeIcons.leaf,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
