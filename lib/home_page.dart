import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'profile.dart';
import 'mutasi_page.dart';
import 'pembayaran_page.dart';
import 'cek_saldo_page.dart';
import 'transfer_page.dart';
import 'pinjaman_page.dart';
import 'deposito_page.dart';
import 'theme_provider.dart';
import 'setting_page.dart';
import 'QRcode_page.dart';
import 'help_support_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Aplikasi Koperasi',
      theme: themeProvider.currentTheme,
      home: MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatefulWidget {
  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  double balance = 1000000.0;
  List<String> _mutasiList = [];

  void _updateBalance(double amount) {
    setState(() {
      balance -= amount;
      _mutasiList.add('Transaksi: -Rp. $amount');
    });
  }

  void _updatePinjamanBalance(double amount) {
    setState(() {
      balance += amount;
      _mutasiList.add('Pinjaman Diterima: +Rp. $amount');
    });
  }

  void _updateDepositoBalance(double amount) {
    setState(() {
      balance -= amount;
      _mutasiList.add('Deposito Ditambahkan: -Rp. $amount');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Koperasi Undiksha',
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: theme.colorScheme.onPrimary),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _userInfoCard(primaryColor, theme),
                    SizedBox(height: 20),
                    _featureMenu(primaryColor),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            _helpContact(primaryColor),
            SizedBox(height: 10),
            _bottomControls(primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _userInfoCard(Color primaryColor, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _boxDecoration(primaryColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 110,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/foto candraa.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Desak Made Candra Pratiwi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'desak@student.undiksha.ac.id',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 12),
                Text(
                  'Total Saldo Anda',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 4),
                Text(
                  'Rp. ${balance.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureMenu(Color primaryColor) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: _boxDecoration(primaryColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _featureButton(
                icon: Icons.account_balance_wallet,
                label: 'Cek Saldo',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => InfoSaldoPage(
                            saldo: balance,
                            namaNasabah: 'Desak Made Candra Pratiwi',
                            noRekening: '4774 0101 7242 535',
                          ),
                    ),
                  );
                },
              ),
              _featureButton(
                icon: Icons.history,
                label: 'Mutasi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MutasiPage(mutasiList: _mutasiList),
                    ),
                  );
                },
              ),
              _featureButton(
                icon: Icons.account_balance,
                label: 'Deposito',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => DepositoPage(
                            initialSaldoDeposito: balance,
                            onSaldoUtamaDikurangi: _updateDepositoBalance,
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _featureButton(
                icon: Icons.payment,
                label: 'Pembayaran',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              PembayaranPage(onPayment: _updateBalance),
                    ),
                  );
                },
              ),
              _featureButton(
                icon: Icons.transfer_within_a_station,
                label: 'Transfer',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => TransferPage(onTransfer: _updateBalance),
                    ),
                  );
                },
              ),
              _featureButton(
                icon: Icons.money,
                label: 'Pinjaman',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PinjamanPage(
                            saldo: balance,
                            onPinjamanSuccess: _updatePinjamanBalance,
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _helpContact(Color primaryColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpSupportPage()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Butuh Bantuan?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '0878-1234-1024',
                    style: TextStyle(
                      fontSize: 25,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tap untuk lihat semua opsi bantuan',
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor.withOpacity(0.8),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Icon(Icons.help_outline, color: primaryColor, size: 40),
                Icon(Icons.keyboard_arrow_right, color: primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomControls(Color primaryColor) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            child: Column(
              children: [
                Icon(Icons.settings, color: primaryColor),
                Text('Settings', style: TextStyle(color: primaryColor)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanQRPage()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.qr_code_scanner, color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: Column(
              children: [
                Icon(Icons.person, color: primaryColor),
                Text('Profile', style: TextStyle(color: primaryColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryColor, size: 40),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration(Color primaryColor) {
    return BoxDecoration(
      color: primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: primaryColor.withOpacity(0.3)),
    );
  }
}
