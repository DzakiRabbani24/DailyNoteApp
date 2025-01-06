import 'package:flutter/material.dart';
import 'notes_list_page.dart'; // Impor halaman utama
import 'trash_page.dart'; // Impor halaman trash

class AboutPage extends StatelessWidget {
  // Tidak perlu menerima parameter lagi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Aplikasi'),
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
                  Navigator.pop(context); // Menutup drawer
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
                  Navigator.pop(context); // Menutup drawer
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrashPage(
                        trashNotes: [],  // Kirim data kosong atau sesuai kebutuhan
                        clearTrash: () {}, // Kirim fungsi kosong jika tidak digunakan
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
                  // Tetap di halaman AboutPage karena sudah di sini
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tentang Aplikasi',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Text(
              'Aplikasi ini dirancang untuk membantu pengguna mencatat kegiatan harian. '
                  'Anda dapat menambahkan, mengedit, dan menghapus catatan sesuai kebutuhan.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16),
            Text(
              'Fitur Utama:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              '1. Tambah catatan\n'
                  '2. Tandai catatan selesai\n'
                  '3. Hapus catatan ke Trash\n'
                  '4. Kelola catatan di Trash\n'
                  '5. Filter catatan berdasarkan status',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}