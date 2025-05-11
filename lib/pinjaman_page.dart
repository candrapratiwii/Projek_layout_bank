import 'package:flutter/material.dart';

class PinjamanPage extends StatefulWidget {
  final double saldo;
  final Function(double) onPinjamanSuccess;

  PinjamanPage({required this.saldo, required this.onPinjamanSuccess});

  @override
  _PinjamanPageState createState() => _PinjamanPageState();
}

class _PinjamanPageState extends State<PinjamanPage> {
  final TextEditingController _jumlahPinjamanController =
      TextEditingController();
  String _statusPinjaman = '';
  String? _bankTujuan;
  double? _saldo;

  final List<String> _bankList = ['Bank A', 'Bank B', 'Bank C'];

  @override
  void initState() {
    super.initState();
    _saldo = widget.saldo;
  }

  // Fungsi untuk mengajukan peminjaman
  void _ajukanPinjaman() {
    final jumlahPinjaman = double.tryParse(_jumlahPinjamanController.text);
    final bankTujuan = _bankTujuan;

    if (jumlahPinjaman != null &&
        jumlahPinjaman >= 500000 &&
        bankTujuan != null) {
      setState(() {
        _statusPinjaman =
            'Pinjaman sebesar Rp. ${jumlahPinjaman.toStringAsFixed(2)} berhasil diajukan ke $bankTujuan.';
      });

      // Menampilkan popup jika pinjaman berhasil diajukan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pinjaman Berhasil'),
            content: Text(
              'Pinjaman sebesar Rp. ${jumlahPinjaman.toStringAsFixed(2)} berhasil diajukan ke $bankTujuan.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup popup
                  // Reset data setelah pop up OK ditekan
                  setState(() {
                    _jumlahPinjamanController.clear();
                    _bankTujuan = null;
                  });
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _statusPinjaman =
            'Mohon lengkapi semua data dan jumlah pinjaman minimal Rp. 500.000';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pinjaman',
          style: TextStyle(
            color: Colors.white,
          ), // Menjadikan teks di AppBar putih
        ),
        backgroundColor: const Color.fromARGB(255, 17, 52, 142), // Warna AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan saldo di bagian paling atas
            Text(
              'Saldo Anda: Rp. ${_saldo!.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _jumlahPinjamanController,
              decoration: InputDecoration(
                labelText: 'Jumlah Pinjaman (Minimal Rp. 500.000)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            // Dropdown untuk memilih bank tujuan
            DropdownButton<String>(
              value: _bankTujuan,
              hint: Text('Pilih Bank Tujuan'),
              isExpanded: true,
              items:
                  _bankList.map((bank) {
                    return DropdownMenuItem<String>(
                      value: bank,
                      child: Text(bank),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _bankTujuan = newValue;
                });
              },
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ), // Warna tanda panah putih
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _ajukanPinjaman,
              child: Text('Ajukan Pinjaman'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(
                  255,
                  17,
                  52,
                  142,
                ), // Warna tombol sesuai yang diminta
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ), // Ukuran tombol lebih kecil
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ), // Ukuran teks tombol
                foregroundColor: Colors.white, // Warna teks tombol putih
              ),
            ),
            SizedBox(height: 16),
            Text(
              _statusPinjaman,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
