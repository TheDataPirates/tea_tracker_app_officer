import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/trough_arrangement.dart';
import 'package:teatrackerappofficer/screens/login_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/mainMenu/bought_leaf_screen.dart';
import 'screens/mainMenu/withering_loft_screen.dart';
import 'screens/mainMenu/rolling_room_screen.dart';
import 'screens/mainMenu/roll_breaking_room_screen.dart';
import 'screens/mainMenu/fermenting_room_screen.dart';
import 'screens/mainMenu/drying_room_screen.dart';
import 'screens/mainMenu/shifting_room_screen.dart';
import 'screens/mainMenu/packing_room.dart';
import 'screens/mainMenu/dispatching_room_screen.dart';
import 'screens/mainMenu/difference_report_screen.dart';
import 'screens/witheringLoft/trough_loading_screen.dart';
import 'screens/witheringLoft/withering_start_screen.dart';
import 'screens/witheringLoft/withering_mixing_screen.dart';
import 'screens/witheringLoft/withering_finish_screen.dart';
import 'screens/witheringLoft/trough_unloading_screen.dart';
import 'screens/witheringLoft/trough_loading_view_screen.dart';

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
    return ChangeNotifierProvider(
      create: (ctx) => TroughArrangement(),
      child: MaterialApp(
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
          'TroughLoading': (context) => TroughLoadingScreen(),
          'WitheringStart': (context) => WitheringStartScreen(),
          'WitheringMixing': (context) => WitheringMixingScreen(),
          'WitheringFinish': (context) => WitheringFinishScreen(),
          'TroughUnloading': (context) => TroughUnloadingScreen(),
          'TroughLoadingView': (context) => TroughLoadingViewScreen(),
        },
      ),
    );
  }
}
