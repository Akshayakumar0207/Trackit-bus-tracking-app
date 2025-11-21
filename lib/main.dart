import 'package:flutter/material.dart';
import 'package:trackit/screens/driver/alter_bus.dart';

// Screens import (student)
import 'screens/student/splash_screen.dart';
import 'screens/student/login_screen.dart';
import 'screens/student/student_login.dart';
import 'screens/student/forgot_password.dart';
import 'screens/student/otp_verify.dart';
import 'screens/student/student_details.dart';
import 'screens/student/student_dashboard.dart';
import 'screens/student/notifications_page.dart';
import 'screens/student/tracking_page.dart';

// Screens import (driver)
import 'screens/driver/driver_login.dart';
import 'screens/driver/driver_dashboard.dart';
import 'screens/driver/alter_bus.dart';

// admin screens
import 'screens/admin/admin_login.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/bus_management.dart';
import 'screens/admin/add_driver.dart';
import 'screens/admin/student_management.dart';
import 'screens/admin/add_student.dart';
import 'screens/admin/system_settings.dart';
import 'screens/admin/export_page.dart';
import 'screens/admin/generate_report.dart';
import 'screens/admin/add_bus_dialog.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),

      // Start from splash screen
      initialRoute: '/',
      routes: {
        // student flow
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/student_login': (context) => const StudentLoginScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/otp_verify': (context) => const OtpVerifyScreen(),
        '/student_details': (context) => const StudentDetails(),
        '/student_dashboard': (context) => const StudentDashboard(),
        '/notifications': (context) => const NotificationsPage(),
        '/tracking': (context) => const TrackingPage(),

        // driver flow
        '/driver_login': (context) => const DriverLoginScreen(),
        '/driver_dashboard': (context) => const DriverDashboard(),
        '/alter_bus': (context) => const AlterBusScreen(),

        // admin flow
        '/admin_login': (c) => const AdminLoginScreen(),
        '/admin_dashboard': (c) => const AdminDashboard(),
        '/bus_management': (c) => const BusManagementPage(),
        '/add_driver': (c) => const AddDriverPage(),
        '/student_management': (c) => const StudentManagementPage(),
        '/add_student': (c) => const AddStudentPage(),
        '/system_settings': (c) => const SystemSettingsPage(),
        '/export': (c) => const ExportPage(),
        '/generate_report': (c) => const GenerateReportPage(),
        '/add_bus': (c) => const AddBusDialog(),
      },

      // fallback route (optional)
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      },
    );
  }
}
