import 'package:flutter/material.dart';
import 'add_note_page.dart';
import 'trash_page.dart';
import 'about_page.dart';

class NotesListPage extends StatefulWidget {
  @override
  _NotesListPageState createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> notes = [];
  List<Map<String, dynamic>> trash = [];
  late AnimationController _controller;

  String _filter = 'Semua';  // Filter untuk kategori

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  // Menambah catatan dengan animasi
  void _addNoteAnimated(String title, String content) {
    setState(() {
      notes.insert(0, {
        'title': title,
        'content': content,
        'isCompleted': false,
      });
    });
    _controller.forward(from: 0.0);
  }

  // Hapus catatan dan pindahkan ke trash
  void _deleteNote(int index) {
    setState(() {
      trash.insert(0, notes.removeAt(index)); // Pindahkan catatan ke trash
    });
  }

  // Tandai catatan sebagai selesai
  void _markAsCompleted(int index) {
    setState(() {
      notes[index]['isCompleted'] = true;
      notes.add(notes.removeAt(index));
    });
  }

  // Tandai catatan sebagai belum selesai
  void _markAsNotCompleted(int index) {
    setState(() {
      notes[index]['isCompleted'] = false;
      notes.insert(0, notes.removeAt(index));
    });
  }

  // Menampilkan opsi ketika catatan ditekan
  void _showNoteOptions(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(notes[index]['title']),
          content: Text(notes[index]['content']),
          actions: [
            TextButton(
              onPressed: () {
                notes[index]['isCompleted']
                    ? _markAsNotCompleted(index)
                    : _markAsCompleted(index);
                Navigator.pop(context);
              },
              child: Text(notes[index]['isCompleted'] ? 'Belum Selesai' : 'Selesai'),
            ),
            TextButton(
              onPressed: () {
                _deleteNote(index);
                Navigator.pop(context);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // Menampilkan catatan yang sudah difilter berdasarkan kategori
  List<Map<String, dynamic>> getFilteredNotes() {
    if (_filter == 'Belum Selesai') {
      return notes.where((note) => !note['isCompleted']).toList();
    } else if (_filter == 'Sudah Selesai') {
      return notes.where((note) => note['isCompleted']).toList();
    }
    return notes; // Semua catatan
  }

  // Mengambil catatan yang ada di trash
  List<Map<String, dynamic>> getTrashNotes() {
    return trash;
  }

  // Menghapus semua catatan di trash
  void _clearTrash() {
    setState(() {
      trash.clear(); // Hapus semua catatan di trash
    });
  }

  // Mengupdate filter kategori
  void _updateFilter(String? newFilter) {
    setState(() {
      _filter = newFilter ?? 'Semua';  // Update filter
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Catatan'),
        actions: [
          DropdownButton<String>(
            value: _filter,
            onChanged: _updateFilter,
            items: <String>['Semua', 'Belum Selesai', 'Sudah Selesai']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context); // Kembali ke halaman utama
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Trash'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrashPage(
                        trashNotes: trash, // Operkan catatan di trash
                        clearTrash: _clearTrash, // Operkan fungsi hapus trash
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Tentang Aplikasi'),
                onTap: () {
                  Navigator.pop(context); // Menutup drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),  // Tanpa parameter
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: getFilteredNotes().isEmpty
          ? Center(
        child: Text('Belum ada catatan', style: TextStyle(fontSize: 18)),
      )
          : ListView.builder(
        itemCount: getFilteredNotes().length,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Curves.easeInOut,
              ),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: getFilteredNotes()[index]['isCompleted']
                      ? Colors.green
                      : Colors.blue,
                  child: Icon(
                    getFilteredNotes()[index]['isCompleted']
                        ? Icons.check
                        : Icons.note,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  getFilteredNotes()[index]['title'],
                  style: TextStyle(
                    decoration: getFilteredNotes()[index]['isCompleted']
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Text(
                  getFilteredNotes()[index]['content'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.more_vert),
                onTap: () {
                  _showNoteOptions(index);  // Tampilkan opsi catatan
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(),
            ),
          );
          if (newNote != null) {
            _addNoteAnimated(newNote['title'], newNote['content']);
          }
        },
        label: Text('Tambah'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}