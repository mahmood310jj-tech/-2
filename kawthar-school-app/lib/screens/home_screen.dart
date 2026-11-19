import 'dart:async';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  final IconData appIcon; final String studentName; final bool newsEnabled; final double fontScale;
  const HomeScreen({super.key, required this.appIcon, required this.studentName, required this.newsEnabled, required this.fontScale});
  @override State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late Timer timer; DateTime now = DateTime.now();
  List<String> news = ['أهلاً بكم في مدرسة الكوثر', 'امتحانات الشهر الأول تبدأ الأحد', 'اجتماع أولياء الأمور يوم الخميس', 'مسابقة القرآن الكريم قريباً'];
  @override void initState() { super.initState(); timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() => now = DateTime.now())); }
  @override void dispose() { timer.cancel(); super.dispose(); }
  @override Widget build(BuildContext context) {
    final time = '${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:${now.second.toString().padLeft(2,'0')}';
    return ListView(padding: const EdgeInsets.all(16), children: [
      // الساعة العلوية
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF2F4A3A), borderRadius: BorderRadius.circular(20)), child: Row(children: [
        Icon(widget.appIcon, color: Colors.white, size: 40),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('أهلاً، ${widget.studentName}', style: TextStyle(color: Colors.white, fontSize: 18 * widget.fontScale, fontWeight: FontWeight.bold)),
          Text(time, style: const TextStyle(color: Color(0xFFF2D492), fontSize: 28, fontWeight: FontWeight.bold)),
          Text('${now.day}/${now.month}/${now.year} - بغداد', style: const TextStyle(color: Colors.white70)),
        ])),
      ])),
      const SizedBox(height: 12),
      // شريط الأخبار المتحرك من اليسار إلى اليمين
      if (widget.newsEnabled) Container(height: 42, decoration: BoxDecoration(color: const Color(0xFFD97A4A), borderRadius: BorderRadius.circular(12)), child: Row(children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.campaign, color: Colors.white)),
        Expanded(child: _Ticker(text: news.join('  •  '))),
        IconButton(icon: const Icon(Icons.add, color: Colors.white, size: 20), onPressed: () => setState(() => news.add('إعلان جديد: ${DateTime.now().hour}:${DateTime.now().minute}'))),
      ])),
      const SizedBox(height: 16),
      Row(children: const [Expanded(child: _Stat(title: 'الطلاب', value: '850')), Expanded(child: _Stat(title: 'المعلمون', value: '42')), Expanded(child: _Stat(title: 'الصفوف', value: '18'))]),
      const SizedBox(height: 16),
      const Text('أخبار وإعلانات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ...news.map((n) => Card(child: ListTile(leading: const Icon(Icons.article, color: Color(0xFFD97A4A)), title: Text(n)))).toList(),
    ]);
  }
}
class _Stat extends StatelessWidget {
  final String title, value; const _Stat({required this.title, required this.value});
  @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(children: [Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFD97A4A))), Text(title)])));
}
// شريط متحرك LTR
class _Ticker extends StatefulWidget { final String text; const _Ticker({required this.text}); @override State<_Ticker> createState() => _TickerState(); }
class _TickerState extends State<_Ticker> with SingleTickerProviderStateMixin {
  late AnimationController c;
  @override void initState() { super.initState(); c = AnimationController(vsync: this, duration: const Duration(seconds: 18))..repeat(); }
  @override void dispose() { c.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => ClipRect(child: AnimatedBuilder(animation: c, builder: (_, __) => Align(alignment: Alignment(-1 + 2 * c.value, 0), child: Text(widget.text, style: const TextStyle(color: Colors.white), maxLines: 1, textDirection: TextDirection.ltr))));
}
