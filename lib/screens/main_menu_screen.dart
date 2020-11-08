import 'package:flutter/material.dart';
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

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg1.jpg"),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
        )
      ),
      child: Scaffold(
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
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Bought Leaf', destination: 'BoughtLeaf',),
          Container(
          child: ButtonTheme(
          height: _height * 0.2,
            minWidth: _width * 0.3,
            child: RaisedButton(
              elevation: 30.0,
              color: Colors.black.withOpacity(0.5),
              onPressed: () {
                Navigator.of(context).pushNamed('BoughtLeaf');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bought Leaf',
                    style: GoogleFonts.courgette(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                  IconButton(icon: FaIcon(FontAwesomeIcons.leaf, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.greenAccent, width: 4.0),
              ),
            ),
          ),
        ),
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Withering Loft', destination: 'WitheringLoft',),
        Container(
          child: ButtonTheme(
            height: _height * 0.2,
            minWidth: _width * 0.3,
            child: RaisedButton(
              elevation: 30.0,
              color: Colors.black.withOpacity(0.5),
              onPressed: () {
                Navigator.of(context).pushNamed('WitheringLoft');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Withering Loft',
                    style: GoogleFonts.courgette(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                  IconButton(icon: FaIcon(FontAwesomeIcons.boxes, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.greenAccent, width: 4.0),
              ),
            ),
          ),
        ),
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Rolling Room', destination: 'RollingRoom',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('RollingRoom');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Rolling Room',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.infinity, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Roll Breaking Room', destination: 'RollBreakingRoom',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('RollBreakingRoom');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Roll Breaking Room',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.creativeCommonsRemix, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
                  ),
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Fermenting Room', destination: 'FermentingRoom',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('FermentingRoom');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Fermenting Room',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.buffer, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
                  ),

//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Drying Room', destination: 'DryingRoom',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('DryingRoom');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Drying Room',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.temperatureHigh, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Shifting Room', destination: 'ShiftingRoom',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('ShiftingRoom');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Shifting Room',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.objectGroup, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
                  ),
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Packing Room', destination: 'PackingRoom',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('PackingRoom');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Packing Room',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.box, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
                  ),
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Dispatching Room', destination: 'DispatchingRoom',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('DispatchingRoom');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Dispatching Room',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.voteYea, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Re-Measuring', destination: 'ReMeasuring',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('ReMeasuring');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Re-Measuring',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.weight, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
                  ),
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'Difference Report', destination: 'DifferenceReport',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('DifferenceReport');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Difference Report',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.stickyNote, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
                  ),
//                  MainMenuFlatButtonContainer(height: _height, width: _width, name: 'View All Sections', destination: 'ViewAllSections',),
                  Container(
                    child: ButtonTheme(
                      height: _height * 0.2,
                      minWidth: _width * 0.3,
                      child: RaisedButton(
                        elevation: 30.0,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pushNamed('ViewAllSections');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'View All Sections',
                              style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            IconButton(icon: FaIcon(FontAwesomeIcons.solidEye, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.greenAccent, width: 4.0),
                        ),
                      ),
                    ),
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
