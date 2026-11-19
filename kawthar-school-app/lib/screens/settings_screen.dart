import 'package:flutter/material.dart';
class SettingsScreen extends StatelessWidget {
  final bool isDark; final VoidCallback onToggleTheme; final IconData appIcon; final ValueChanged<IconData> onChangeIcon;
  final String studentName; final double fontScale; final bool newsEnabled; final void Function(String, double, bool) onChanged;
  const SettingsScreen({super.key, required this.isDark, required this.onToggleTheme, required this.appIcon, required this.onChangeIcon, required this.studentName, required this.fontScale, required this.newsEnabled, required this.onChanged});
  @override Widget build(BuildContext context) {
    final icons = {Icons.school: 'مدرسة', Icons.book: 'كتاب', Icons.edit: 'قلم', Icons.star: 'نجمة', Icons.mosque: 'هلال', Icons.workspace_premium: 'شهادة'};
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('الضبط - Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      SwitchListTile(title: const Text('الوضع الليلي'), value: isDark, onChanged: (_) => onToggleTheme()),
      SwitchListTile(title: const Text('شريط الأخبار'), value: newsEnabled, onChanged: (v) => onChanged(studentName, fontScale, v)),
      ListTile(title: const Text('اسم الطالب'), subtitle: Text(studentName), trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () => onChanged('أحمد محمد - تم التعديل', fontScale, newsEnabled))),
      ListTile(title: const Text('حجم الخط'), subtitle: Text(fontScale == 1.0 ? 'متوسط' : fontScale > 1.0 ? 'كبير' : 'صغير'), trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.remove), onPressed: () => onChanged(studentName, 0.85, newsEnabled)), IconButton(icon: const Icon(Icons.add), onPressed: () => onChanged(studentName, 1.2, newsEnabled))])),
      const SizedBox(height: 12),
      const Text('تغيير أيقونة التطبيق', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      Wrap(spacing: 10, children: icons.entries.map((e) => ChoiceChip(label: Text(e.value), selected: appIcon == e.key, onSelected: (_) => onChangeIcon(e.key), selectedColor: const Color(0xFFD97A4A))).toList()),
      const SizedBox(height: 12),
      Card(child: ListTile(leading: Icon(appIcon, color: const Color(0xFFD97A4A), size: 36), title: const Text('الأيقونة الحالية'), subtitle: const Text('مدرسة الكوثر الابتدائية والمتوسطة'))),
      const ListTile(title: Text('المرحلة'), subtitle: Text('ابتدائية + متوسطة')),
      const ListTile(title: Text('اللغة'), subtitle: Text('العربية')),
      const ListTile(title: Text('الإصدار'), subtitle: Text('1.0.0 - 2026')),
    ]);
  }
}
