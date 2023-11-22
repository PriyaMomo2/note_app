import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Selamat datang di Halaman Bantuan Aplikasi Catatan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '1. Bagaimana cara menambahkan catatan baru?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Untuk menambahkan catatan baru, ketuk tombol tambah di pojok kanan bawah layar. Isi judul dan detail catatan, lalu ketuk tombol simpan dipojok kanan bawah layar.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '2. Bagaimana cara mengedit catatan?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Ketuk catatan yang ingin diubah dari daftar catatan. Jangan lupa untuk menyimpan perubahan.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '3. Bagaimana cara menghapus catatan?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Ketuk tombol hapus yang berada di sebelah kanan catatan. Pastikan untuk mengonfirmasi penghapusan.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Terima kasih telah menggunakan Aplikasi Catatan. Jika Anda memiliki pertanyaan lebih lanjut, jangan ragu untuk menghubungi dukungan pelanggan kami.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
