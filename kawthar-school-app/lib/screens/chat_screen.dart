import 'package:flutter/material.dart';
class ChatScreen extends StatefulWidget { const ChatScreen({super.key}); @override State<ChatScreen> createState() => _ChatScreenState(); }
class _ChatScreenState extends State<ChatScreen> {
  String? teacher;
  final teachers = ['أ. علي - رياضيات', 'أ. فاطمة - عربي', 'أ. أحمد - علوم', 'أ. زينب - إنجليزي', 'أ. حسن - إسلامية'];
  Map<String, List<Map<String, dynamic>>> chats = {};
  final ctrl = TextEditingController();
  @override Widget build(BuildContext context) {
    if (teacher == null) return ListView(children: [const Padding(padding: EdgeInsets.all(16), child: Text('اختر معلماً للدردشة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))), ...teachers.map((t) => Card(child: ListTile(leading: const CircleAvatar(backgroundColor: Color(0xFF2F4A3A), child: Icon(Icons.person, color: Colors.white)), title: Text(t), subtitle: const Text('متصل الآن'), trailing: const Icon(Icons.chat), onTap: () => setState(() => teacher = t)))).toList()]);
    final msgs = chats[teacher!] ?? [];
    return Column(children: [
      ListTile(leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => setState(() => teacher = null)), title: Text(teacher!), subtitle: const Text('متصل الآن')),
      Expanded(child: ListView(children: msgs.map((m) => Align(alignment: m['me'] ? Alignment.centerRight : Alignment.centerLeft, child: Container(margin: const EdgeInsets.all(6), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: m['me'] ? const Color(0xFFD97A4A) : Colors.white, borderRadius: BorderRadius.circular(14)), child: Text(m['text'], style: TextStyle(color: m['me'] ? Colors.white : Colors.black))))).toList())),
      Padding(padding: const EdgeInsets.all(8), child: Row(children: [Expanded(child: TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'اكتب رسالتك للمعلم...', border: OutlineInputBorder()))), IconButton(icon: const Icon(Icons.send, color: Color(0xFFD97A4A)), onPressed: () { if (ctrl.text.isEmpty) return; setState(() { chats.putIfAbsent(teacher!, () => []).add({'text': ctrl.text, 'me': true}); chats[teacher!]!.add({'text': 'أهلاً بك، تم استلام رسالتك وسأرد عليك قريباً إن شاء الله.', 'me': false}); ctrl.clear(); }); })])),
    ]);
  }
}
