import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teatrackerappofficer/screens/login_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/bought_leaf_screen.dart';
import 'screens/withering_loft_screen.dart';
import 'screens/rolling_room_screen.dart';
import 'screens/roll_breaking_room_screen.dart';
import 'screens/fermenting_room_screen.dart';
import 'screens/drying_room_screen.dart';
import 'screens/shifting_room_screen.dart';
import 'screens/packing_room.dart';
import 'screens/dispatching_room_screen.dart';
import 'screens/difference_report_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // set lock to landscape view only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.greenAccent,
      ),
      home: LoginScreen(),
      routes: {
        'MainMenu': (context) => MainMenuScreen(),
        'BoughtLeaf': (context) => BoughtLeafScreen(),
        'WitheringLoft': (context) => WitheringLoftScreen(),
        'RollingRoom': (context) => RollingRoomScreen(),
        'RollBreakingRoom': (context) => RollBreakingRoomScreen(),
        'FermentingRoom': (context) => FermentingRoomScreen(),
        'DryingRoom': (context) => DryingRoomScreen(),
        'ShiftingRoom': (context) => ShiftingRoomScreen(),
        'PackingRoom': (context) => PackingRoomScreen(),
        'DispatchingRoom': (context) => DispatchingRoomScreen(),
        'DifferenceReport': (context) => DifferenceReportScreen(),

      },
    );
  }
}
