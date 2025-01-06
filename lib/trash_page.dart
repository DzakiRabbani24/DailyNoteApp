import 'package:flutter/material.dart';
import 'notes_list_page.dart';
import 'about_page.dart';

class TrashPage extends StatefulWidget {
  final List<Map<String, dynamic>> trashNotes;
  final Function clearTrash;

  TrashPage({required this.trashNotes, required this.clearTrash});

  @override
  _TrashPageState createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trash'),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NotesListPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Trash'),
                onTap: () {
                  Navigator.pop(context); // Sudah di halaman Trash, cukup kembali
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
      body: widget.trashNotes.isEmpty
          ? Center(
        child: Text('Trash masih kosong', style: TextStyle(fontSize: 18)),
      )
          : ListView.builder(
        itemCount: widget.trashNotes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            elevation: 2,
            child: ListTile(
              title: Text(widget.trashNotes[index]['title']),
              subtitle: Text(widget.trashNotes[index]['content']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.clearTrash(); // Hapus semua catatan di trash
        },
        child: Icon(Icons.delete_forever),
        backgroundColor: Colors.red,
      ),
    );
  }
}