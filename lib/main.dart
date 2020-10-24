import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_mixing_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting__finishing_provider.dart';
import 'package:teatrackerappofficer/screens/login_screen.dart';
import 'package:teatrackerappofficer/screens/rolling/rolling_input_screen.dart';
import 'package:teatrackerappofficer/screens/rolling/rolling_input_view_screen.dart';
import 'package:teatrackerappofficer/screens/rolling/rolling_output_screen.dart';
import 'package:teatrackerappofficer/screens/witheringLoft/withering_finishing_view_screen.dart';
import 'package:teatrackerappofficer/screens/witheringLoft/withering_unloading_batch_choosing_screen.dart';
import 'package:teatrackerappofficer/screens/witheringLoft/withering_unloading_view_screen.dart';
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
import 'screens/witheringLoft/withering_starting_screen.dart';
import 'screens/witheringLoft/withering_mixing_screen.dart';
import 'screens/witheringLoft/withering_finishing_screen.dart';
import 'screens/witheringLoft/withering_unloading_screen.dart';
import 'screens/witheringLoft/trough_loading_view_screen.dart';
import 'screens/witheringLoft/withering_mixing_view_screen.dart';
import 'screens/witheringLoft/withering_starting_view_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: WitheringLoadingUnloadingProvider()),
        ChangeNotifierProvider.value(value: WitheringMixingProvider()),
        ChangeNotifierProvider.value(value: WitheringStartingFinishingProvider()),
        ChangeNotifierProvider.value(value: RollingProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.greenAccent,
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
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
          'WitheringStarting': (context) => WitheringStartScreen(),
          'WitheringMixing': (context) => WitheringMixingScreen(),
          'WitheringFinishing': (context) => WitheringFinishingScreen(),
          'WitheringUnloading': (context) => WitheringUnloadingScreen(),
          'TroughLoadingView': (context) => TroughLoadingViewScreen(),
          'WitheringMixingView': (context) => WitheringMixingViewScreen(),
          'WitheringStartingView': (context) => WitheringStartingViewScreen(),
          'WitheringFinishingView': (context) => WitheringFinishingViewScreen(),
          'WitheringUnloadingBatchChoosing': (context) => WitheringUnloadingBatchChoosingScreen(),
          'WitheringUnloadingView': (context) => WitheringUnloadingViewScreen(),
          'RollingInput': (context) => RollingInputScreen(),
          'RollingOutput': (context) => RollingOutputScreen(),
          'RollingInputView': (context) => RollingInputViewScreen(),
        },
      ),
    );
  }
}
