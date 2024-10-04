import 'package:flutter/material.dart';
import 'package:localnotifs/notification/notification.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map<int, String> _titles = {
    1: "Sha`ban",
    2: "Ramadan",
    3: "Shawwal",
    4: "Arafah",
    5: "Ashura",
    6: "Muharram",
    // Add more titles as needed
  };

  final Map<int, DateTime> _scheduleDates = {
    1: DateTime(2024, 8, 7, 11, 4),
    2: DateTime(2025, 2, 28),
    3: DateTime(2025, 3, 30),
    4: DateTime(2025, 6, 6),
    5: DateTime(2025, 7, 5),
    6: DateTime(2025, 6, 27),
    // Add more dates as needed
  };

  final Map<int, String> _descriptions = {
    1: "Sha'ban is the month of the Prophet (PBUH).",
    2: "Month of Fasting, Charity, Kindness Patience, and relationship with God.",
    3: "Six days fasting during the month of Shawwal after Ramadan.",
    4: "Prophet Muhammad (pbuh) Farewell Dermon Day.",
    5: "Parting of the Red Sea by Moses and the salvation of the Israelites.",
    6: "The first month of the Islamic calendar.",
    // Add more descriptions as needed
  };

  late List<bool> _isScheduled; // Declare _isScheduled as late
  int _notificationId = 0; // Declare a counter for notification ids

  @override
  void initState() {
    super.initState();
    _isScheduled = List.generate(
        _scheduleDates.length, (index) => true); // Initialize _isScheduled here
    for (int i = 0; i < _isScheduled.length; i++) {
      if (_isScheduled[i]) {
        _scheduleNotification(i);
      }
    }
  }

  void _scheduleNotification(int index) {
    int key = _scheduleDates.keys.elementAt(index); // Get the key from the map
    DateTime scheduledTime = _scheduleDates[key]!;
    String title = _titles[key]!;
    String description = _descriptions[key]!;
    _notificationId++; // Increment the counter
    int id = _notificationId; // Use the counter as the id
    NotificationService.scheduleNotification(
      id,
      "$title is in 5 days!",
      description,
      scheduledTime.subtract(const Duration(minutes: 5)),
      largeIcon: 'assets/icons/logo_no_background.png', // Specify the large icon
      smallIcon: 'assets/icons/ic_launcher.png', // Specify the small icon
    );
    _notificationId++; // Increment the counter
    id = _notificationId; // Use the counter as the id
    NotificationService.scheduleNotification(
      id,
      "$title is in 3 days!",
      description,
      scheduledTime.subtract(const Duration(days: 3)),
      largeIcon: 'assets/icons/logo_no_background.png', // Specify the large icon
      smallIcon: 'assets/icons/ic_launcher.png', // Specify the small icon
    );
    _notificationId++; // Increment the counter
    id = _notificationId; // Use the counter as the id
    NotificationService.scheduleNotification(
      id,
      "$title is Tomorrow",
      description,
      scheduledTime.subtract(const Duration(days: 1)),
      largeIcon: 'assets/icons/logo_no_background.png', // Specify the large icon
      smallIcon: 'assets/icons/ic_launcher.png', // Specify the small icon
    );
  }

  void _cancelNotification(int id) {
    NotificationService.cancelNotification(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Reminders'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fastlist.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: _scheduleDates.length,
          itemBuilder: (context, index) {
            int key = _scheduleDates.keys.elementAt(index); // Get the key from the map
            bool currentValue = _isScheduled[index]; // Declare a boolean variable
            String title = _titles[key]!;
            DateTime scheduledTime = _scheduleDates[key]!;
            String description = _descriptions[key]!;
            return Card(

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(22)// Set the background color
                ),
                child: ListTile(
                  title: Text(title,
                    // "- ${scheduledTime.toString().split(' ').first}"
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,// Make the title bold
                    ),
                  ),
                  subtitle: Text(scheduledTime.toString().split(' ').first),
                  trailing: Switch(
                    value: currentValue, // Use the boolean variable
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        _isScheduled[index] = value;
                      });
                      if (value) {
                        _scheduleNotification(index); // Schedule if turned on
                      } else {
                        _cancelNotification(_notificationId); // Cancel if turned off
                        _notificationId--; // Dec // Decrement the counter
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}






























// import 'package:flutter/material.dart';
// import 'package:localnotifs/notification/notification.dart';
// import 'package:timezone/data/latest.dart' as tz;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NotificationService.init();
//   tz.initializeTimeZones();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const Home(),
//     );
//   }
// }
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final Map<int, DateTime> _scheduleDates = {
//     1: DateTime(2024, 7, 30, 20, 59),
//     2: DateTime(2024, 7, 30, 21, 00),
//     3: DateTime(2024, 7, 30, 21, 01),
//     // Add more dates and times as needed
//   };
//   late List<bool> _isScheduled; // Declare _isScheduled as late
//   int _notificationId = 0; // Declare a counter for notification ids
//
//   @override
//   void initState() {
//     super.initState();
//     _isScheduled = List.generate(
//         _scheduleDates.length, (index) => true); // Initialize _isScheduled here
//     for (int i = 0; i < _isScheduled.length; i++) {
//       if (_isScheduled[i]) {
//         _scheduleNotification(); // Schedule notifications by default
//       }
//     }
//   }
//
//   void _scheduleNotification() {
//     _notificationId++; // Increment the counter
//     int id = _notificationId; // Use the counter as the id
//     int key = _scheduleDates.keys.elementAt(_notificationId - 1); // Get the key from the map
//     NotificationService.scheduleNotification(
//       id,
//       "Schedule Notification",
//       "This notification is scheduled",
//       _scheduleDates[key]!,
//     );
//   }
//
//   void _cancelNotification(int id) {
//     NotificationService.cancelNotification(id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Default Reminders'),
//       ),
//       body: ListView.builder(
//         itemCount: _scheduleDates.length,
//         itemBuilder: (context, index) {
//           int key = _scheduleDates.keys.elementAt(index); // Get the key from the map
//           bool currentValue = _isScheduled[index]; // Declare a boolean variable
//           return ListTile(
//             title: Text(_scheduleDates[key]!.toString()),
//             trailing: Switch(
//               value: currentValue, // Use the boolean variable
//               activeColor: Colors.green,
//               onChanged: (value) {
//                 setState(() {
//                   _isScheduled[index] = value;
//                 });
//                 if (value) {
//                   _scheduleNotification(); // Schedule if turned on
//                 } else {
//                   _cancelNotification(_notificationId); // Cancel if turned off
//                   _notificationId--; // Decrement the counter
//                 }
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }