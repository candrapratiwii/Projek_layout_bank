import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  final Function(double) onTransfer;

  const TransferPage({Key? key, required this.onTransfer}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _rekeningController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String? _selectedBank;
  final List<String> _banks = [
    'BANK BRI',
    'BANK BCA',
    'BANK MANDIRI',
    'BANK BNI',
  ];

  void _submitTransfer() {
    if (_formKey.currentState!.validate()) {
      double amount = double.parse(_amountController.text);
      widget.onTransfer(amount);

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Transfer Berhasil'),
                ],
              ),
              content: Text(
                'Transfer ke $_selectedBank berhasil dilakukan sebesar Rp${amount.toStringAsFixed(0)}.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  void dispose() {
    _rekeningController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer Dana')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Bank Tujuan',
                  prefixIcon: Icon(Icons.account_balance),
                  border: OutlineInputBorder(),
                ),
                value: _selectedBank,
                items:
                    _banks.map((bank) {
                      return DropdownMenuItem<String>(
                        value: bank,
                        child: Text(bank),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBank = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih bank tujuan';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _rekeningController,
                decoration: InputDecoration(
                  labelText: 'Nomor Rekening/Alias',
                  hintText: 'Masukkan nomor rekening atau alias',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor rekening tidak boleh kosong';
                  } else if (value.length < 6) {
                    return 'Nomor rekening minimal 6 digit';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Jumlah Transfer',
                  prefixIcon: Icon(Icons.money),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah transfer harus diisi';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Masukkan angka yang valid';
                  } else if (amount < 10000) {
                    return 'Minimal transfer Rp10.000';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTransfer,
                child: Text('Kirim Transfer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
