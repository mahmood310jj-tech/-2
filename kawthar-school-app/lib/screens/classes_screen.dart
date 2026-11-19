import 'package:flutter/material.dart';
class ClassesScreen extends StatelessWidget { const ClassesScreen({super.key}); @override Widget build(BuildContext context) {
  final primary = ['الأول الابتدائي','الثاني الابتدائي','الثالث الابتدائي','الرابع الابتدائي','الخامس الابتدائي','السادس الابتدائي'];
  final middle = ['الأول متوسط','الثاني متوسط','الثالث متوسط'];
  return ListView(padding: const EdgeInsets.all(16), children: [
    const Text('المرحلة الابتدائية', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2F4A3A))),
    ...primary.map((c) => Card(child: ListTile(leading: const Icon(Icons.school, color: Color(0xFFD97A4A)), title: Text(c), subtitle: const Text('عربي - رياضيات - علوم - إنجليزي - إسلامية')))),
    const SizedBox(height: 12),
    const Text('المرحلة المتوسطة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2F4A3A))),
    ...middle.map((c) => Card(child: ListTile(leading: const Icon(Icons.book, color: Color(0xFF2F4A3A)), title: Text(c), subtitle: const Text('عربي - رياضيات - علوم - فيزياء - كيمياء - إنجليزي')))),
  ]);
}}
