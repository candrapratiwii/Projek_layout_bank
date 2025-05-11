import 'package:flutter/material.dart';

class DepositoPage extends StatefulWidget {
  final double initialSaldoDeposito;
  final Function(double) onSaldoUtamaDikurangi;

  DepositoPage({
    required this.initialSaldoDeposito,
    required this.onSaldoUtamaDikurangi,
  });

  @override
  _DepositoPageState createState() => _DepositoPageState();
}

class _DepositoPageState extends State<DepositoPage> {
  double _currentBalance = 0;
  final TextEditingController _jumlahController = TextEditingController();
  double _defaultDepositAmount = 5000000.0;

  @override
  void initState() {
    super.initState();
    _currentBalance = widget.initialSaldoDeposito;
  }

  void tambahDeposito(double jumlah) {
    if (jumlah <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jumlah deposito harus lebih dari 0')),
      );
      return;
    }

    if (jumlah > _currentBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saldo tidak mencukupi untuk melakukan deposito')),
      );
      return;
    }

    widget.onSaldoUtamaDikurangi(jumlah);

    setState(() {
      _currentBalance -= jumlah;
    });

    _showSuccessDialog(jumlah);
  }

  void _showSuccessDialog(double jumlah) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deposito Berhasil'),
          content: Text(
            'Deposito sebesar Rp ${jumlah.toStringAsFixed(2)} berhasil ditambahkan!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 17, 52, 142);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deposito',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Layanan Deposito',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo Anda:',
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rp. ${_currentBalance.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Buat Deposito Baru:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _jumlahController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Masukkan jumlah deposito',
                        border: OutlineInputBorder(),
                        prefixText: 'Rp. ',
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              tambahDeposito(_defaultDepositAmount);
                            },
                            child: Text('Deposito Cepat\nRp 5.000.000', textAlign: TextAlign.center),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              double? jumlah = double.tryParse(_jumlahController.text);
                              if (jumlah != null) {
                                tambahDeposito(jumlah);
                                _jumlahController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Masukkan jumlah yang valid')),
                                );
                              }
                            },
                            child: Text('Buat Deposito'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Bunga Deposito',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Table(
                      border: TableBorder.all(color: Colors.grey),
                      children: [
                        _buildTableRow('Jangka Waktu', 'Bunga per Tahun', isHeader: true),
                        _buildTableRow('3 Bulan', '4.5%'),
                        _buildTableRow('6 Bulan', '5.25%'),
                        _buildTableRow('12 Bulan', '6.75%'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String col1, String col2, {bool isHeader = false}) {
    final style = TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
    final color = isHeader ? Color.fromARGB(255, 17, 52, 142).withOpacity(0.1) : null;
    return TableRow(
      decoration: BoxDecoration(color: color),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(col1, style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(col2, style: style),
        ),
      ],
    );
  }
}
