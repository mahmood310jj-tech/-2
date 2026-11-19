import 'package:flutter/material.dart';
class GradesScreen extends StatefulWidget { const GradesScreen({super.key}); @override State<GradesScreen> createState() => _GradesScreenState(); }
class _GradesScreenState extends State<GradesScreen> {
  final ctrl = TextEditingController(); String result = 'ابحث بالاسم أو رقم الطالب';
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.all(16), child: Column(children: [
    TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'اسم الطالب أو رقمه', border: OutlineInputBorder(), prefixIcon: Icon(Icons.search))),
    const SizedBox(height: 12),
    ElevatedButton(onPressed: () => setState(() => result = 'الطالب: ${ctrl.text}\nرياضيات: 95 - عربي: 90 - علوم: 92 - إنجليزي: 88\nالمجموع: 365 / 400 - التقدير: ممتاز'), child: const Text('عرض النتيجة')),
    const SizedBox(height: 16),
    Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(result, style: const TextStyle(fontSize: 16)))),
  ]));
}
