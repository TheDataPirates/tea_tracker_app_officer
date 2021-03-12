import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';
import 'package:teatrackerappofficer/constants.dart';

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg9.jpg"),
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
                    name: 'Bought Leaf',
                    destination: 'VasBoughtLeaf',
                    icon: FontAwesomeIcons.leaf,
                  ),
                  MainMenuFlatButtonContainer(
                    height: _height,
                    width: _width,
                    name: 'Withering Loft',
                    destination: 'VasWitheringLoft',
                    icon: FontAwesomeIcons.boxes,
                  ),
                  MainMenuFlatButtonContainer(
                    height: _height,
                    width: _width,
                    name: 'Rolling Room',
                    destination: 'VasRollingRoom',
                    icon: FontAwesomeIcons.infinity,
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
                    icon: FontAwesomeIcons.creativeCommonsRemix,
                  ),
                  MainMenuFlatButtonContainer(
                    height: _height,
                    width: _width,
                    name: 'Fermenting Room',
                    destination: 'VasFermentingRoom',
                    icon: FontAwesomeIcons.buffer,
                  ),
                  MainMenuFlatButtonContainer(
                    height: _height,
                    width: _width,
                    name: 'Drying Room',
                    destination: 'VasDryingRoom',
                    icon: FontAwesomeIcons.temperatureHigh,
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
                    icon: FontAwesomeIcons.objectGroup,
                  ),
                  MainMenuFlatButtonContainer(
                    height: _height,
                    width: _width,
                    name: 'Packing Room',
                    destination: 'VasPackingRoom',
                    icon: FontAwesomeIcons.box,
                  ),
                  MainMenuFlatButtonContainer(
                    height: _height,
                    width: _width,
                    name: 'Dispatching Room',
                    destination: 'VasDispatchingRoom',
                    icon: FontAwesomeIcons.voteYea,
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
                    icon: FontAwesomeIcons.weight,
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
