import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  final String? title;
  final String? content;

  AddNotePage({this.title, this.content});

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
  }

  void _saveNote() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Peringatan'),
          content: Text('Judul dan Isi Catatan tidak boleh kosong.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      final newNote = {
        'title': _titleController.text,
        'content': _contentController.text,
        'isCompleted': false,
      };
      Navigator.pop(context, newNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title == null ? 'Tambah Catatan' : 'Edit Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul Catatan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Isi Catatan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _saveNote,
              icon: Icon(Icons.save),
              label: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}