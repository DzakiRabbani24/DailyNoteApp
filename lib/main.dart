import 'package:flutter/material.dart';
import 'notes_list_page.dart'; // Mengimpor NotesListPage yang merupakan homepage

void main() {
  runApp(DailyNotesApp());
}

class DailyNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Harian',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: NotesListPage(), // Halaman utama tetap NotesListPage
    );
  }
}