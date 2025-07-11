import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ToDo Reminder',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Versi 1.0.0',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 30, thickness: 1.2),
            const Text(
              'Deskripsi Aplikasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aplikasi ini membantu kamu mengelola tugas harian dengan lebih mudah. '
              'Setiap tugas dapat diatur tanggal, waktu, warna kategori, dan pengingat berupa notifikasi. '
              'Kamu juga bisa mengatur notifikasi dengan suara dan getaran sesuai preferensi.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Text(
              'Fitur Utama:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            // const SizedBox(height: 8),
            // const BulletPoint(text: 'Tambah tugas dengan tanggal dan waktu'),
            // const BulletPoint(text: 'Pengingat dengan suara dan getaran'),
            // const BulletPoint(text: 'Notifikasi otomatis jika waktu habis'),
            // const BulletPoint(text: 'Kategori warna untuk setiap tugas'),
            // const BulletPoint(text: 'Tema bersih, ringan, dan responsif'),
            // const Spacer(),
            Center(
              child: Text(
                'Dibuat dengan ❤️ oleh Tim Kamu',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  //   class BulletPoint extends StatelessWidget {
  //   final String text;

  //   const BulletPoint({super.key, required this.text});

  //   @override
  //   Widget build(BuildContext context) {
  //     return Row(
  //       children: [
  //         const Icon(Icons.check_circle_outline, size: 20, color: Colors.blueAccent),
  //         const SizedBox(width: 10),
  //         Expanded(
  //           child: Text(
  //             text,
  //             style: const TextStyle(fontSize: 16, color: Colors.black87),
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  // }
}
