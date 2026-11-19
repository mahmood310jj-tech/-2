import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/grades_screen.dart';
import 'screens/classes_screen.dart';

void main() => runApp(const KawtharApp());

class KawtharApp extends StatefulWidget {
  const KawtharApp({super.key});
  @override State<KawtharApp> createState() => _KawtharAppState();
}
class _KawtharAppState extends State<KawtharApp> {
  bool isDark = false;
  IconData appIcon = Icons.school;
  String studentName = 'أحمد محمد';
  double fontScale = 1.0;
  bool newsEnabled = true;
  void toggleTheme() => setState(() => isDark = !isDark);
  void changeIcon(IconData i) => setState(() => appIcon = i);

  @override Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مدرسة الكوثر',
      debugShowCheckedModeBanner: false,
      theme: isDark ? kawtharDark() : kawtharLight(),
      home: MainShell(isDark: isDark, onToggleTheme: toggleTheme, appIcon: appIcon, onChangeIcon: changeIcon, studentName: studentName, fontScale: fontScale, newsEnabled: newsEnabled, onSettingsChanged: (n, f, ne) => setState(() { studentName = n; fontScale = f; newsEnabled = ne; })),
    );
  }
}

class MainShell extends StatefulWidget {
  final bool isDark; final VoidCallback onToggleTheme; final IconData appIcon; final ValueChanged<IconData> onChangeIcon;
  final String studentName; final double fontScale; final bool newsEnabled;
  final void Function(String, double, bool) onSettingsChanged;
  const MainShell({super.key, required this.isDark, required this.onToggleTheme, required this.appIcon, required this.onChangeIcon, required this.studentName, required this.fontScale, required this.newsEnabled, required this.onSettingsChanged});
  @override State<MainShell> createState() => _MainShellState();
}
class _MainShellState extends State<MainShell> {
  int index = 0;
  List<String> notifications = ['امتحان الرياضيات يوم الأحد', 'تم نشر نتائج الشهر الأول', 'اجتماع أولياء الأمور الخميس'];
  @override Widget build(BuildContext context) {
    final pages = [
      HomeScreen(appIcon: widget.appIcon, studentName: widget.studentName, newsEnabled: widget.newsEnabled, fontScale: widget.fontScale),
      const ClassesScreen(),
      const CalendarScreen(),
      const ChatScreen(),
      const GradesScreen(),
      SettingsScreen(isDark: widget.isDark, onToggleTheme: widget.onToggleTheme, appIcon: widget.appIcon, onChangeIcon: widget.onChangeIcon, studentName: widget.studentName, fontScale: widget.fontScale, newsEnabled: widget.newsEnabled, onChanged: widget.onSettingsChanged),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisSize: MainAxisSize.min, children: [Icon(widget.appIcon), const SizedBox(width: 8), const Text('مدرسة الكوثر')]),
        actions: [
          IconButton(icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode), onPressed: widget.onToggleTheme, tooltip: 'الوضع الليلي / النهاري'),
          Stack(children: [
            IconButton(icon: const Icon(Icons.notifications), onPressed: () => _showNotifications(context)),
            if (notifications.isNotEmpty) Positioned(right: 8, top: 8, child: CircleAvatar(radius: 9, backgroundColor: Colors.red, child: Text('${notifications.length}', style: const TextStyle(fontSize: 10, color: Colors.white)))),
          ]),
          IconButton(icon: const Icon(Icons.settings), onPressed: () => setState(() => index = 5), tooltip: 'الضبط'),
        ],
      ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(currentIndex: index, onTap: (i) => setState(() => index = i), type: BottomNavigationBarType.fixed, selectedItemColor: const Color(0xFFD97A4A), items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'الصفوف'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'التقويم'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'دردشة المعلم'),
        BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'النتائج'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الضبط'),
      ]),
    );
  }
  void _showNotifications(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => StatefulBuilder(builder: (ctx, setS) => Padding(padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الإشعارات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), TextButton(onPressed: () { setState(() => notifications.clear()); Navigator.pop(context); }, child: const Text('مسح الكل'))]),
      ...notifications.map((n) => ListTile(leading: const Icon(Icons.notifications_active, color: Color(0xFFD97A4A)), title: Text(n))).toList(),
      if (notifications.isEmpty) const Text('لا توجد إشعارات جديدة'),
      ElevatedButton(onPressed: () { setState(() => notifications.add('إشعار جديد: تم تحديث الجدول')); Navigator.pop(context); }, child: const Text('إضافة إشعار تجريبي')),
    ]))));
  }
}
