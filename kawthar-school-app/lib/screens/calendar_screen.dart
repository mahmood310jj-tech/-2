import 'package:flutter/material.dart';
class CalendarScreen extends StatefulWidget { const CalendarScreen({super.key}); @override State<CalendarScreen> createState() => _CalendarScreenState(); }
class _CalendarScreenState extends State<CalendarScreen> {
  DateTime current = DateTime.now(); DateTime selected = DateTime.now();
  Map<String, List<String>> events = {'2026-11-22': ['امتحان رياضيات'], '2026-11-26': ['اجتماع أولياء الأمور'], '2026-11-19': ['بداية الدوام']};
  String key(DateTime d) => '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
  @override Widget build(BuildContext context) {
    final first = DateTime(current.year, current.month, 1);
    final daysInMonth = DateTime(current.year, current.month + 1, 0).day;
    final startWeekday = first.weekday % 7;
    return Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => setState(() => current = DateTime(current.year, current.month - 1))),
        Text('${current.month}/${current.year}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => setState(() => current = DateTime(current.year, current.month + 1))),
      ]),
      const SizedBox(height: 8),
      Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7), itemCount: startWeekday + daysInMonth, itemBuilder: (_, i) {
        if (i < startWeekday) return const SizedBox();
        final day = i - startWeekday + 1; final date = DateTime(current.year, current.month, day);
        final has = events.containsKey(key(date)); final isSel = date.day == selected.day && date.month == selected.month;
        return GestureDetector(onTap: () => setState(() => selected = date), child: Container(margin: const EdgeInsets.all(3), decoration: BoxDecoration(color: isSel ? const Color(0xFFD97A4A) : has ? const Color(0xFFF2D492) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF2F4A3A))), child: Center(child: Text('$day', style: TextStyle(fontWeight: FontWeight.bold, color: isSel ? Colors.white : Colors.black)))));
      })),
      Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('أحداث ${selected.day}/${selected.month}/${selected.year}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ...((events[key(selected)] ?? ['لا توجد أحداث']).map((e) => ListTile(leading: const Icon(Icons.event, color: Color(0xFFD97A4A)), title: Text(e)))).toList(),
        ElevatedButton(onPressed: () { setState(() => events.putIfAbsent(key(selected), () => []).add('حدث جديد - ${TimeOfDay.now().format(context)}')); }, child: const Text('إضافة حدث لهذا اليوم')),
      ]))),
    ]));
  }
}
