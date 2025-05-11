import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';
import 'package:fleetwise_app/provider/fleet_provider.dart';
import 'package:fleetwise_app/screens/auth_screens/login_screen.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/dashboardscreen.dart';
import 'package:fleetwise_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FleetProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MaterialApp(
        title: 'FleetWise',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
