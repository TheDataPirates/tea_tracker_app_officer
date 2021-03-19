import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teatrackerappofficer/constants.dart';

class DryingRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drying Room'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.jpg"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.9), BlendMode.dstATop),
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
                    name: 'Drier Output',
                    destination: 'DrierOutput',
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
                    name: 'Outturn Report',
                    destination: 'OutturnReport',
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
