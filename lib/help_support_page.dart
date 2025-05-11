import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pusat Bantuan',
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Kontak Kami', primaryColor),
              SizedBox(height: 16),
              _buildContactCard(
                icon: Icons.phone,
                title: 'Customer Service',
                contact: '0878-1234-1024',
                action: () => _makePhoneCall('0878-1234-1024'),
                primaryColor: primaryColor,
                context: context,
              ),
              SizedBox(height: 12),
              _buildContactCard(
                icon: FontAwesomeIcons.whatsapp, // Ganti dari Icons.whatsapp
                title: 'WhatsApp',
                contact: '0878-1234-1024',
                action: () => _openWhatsApp('0878-1234-1024'),
                primaryColor: primaryColor,
                context: context,
              ),
              SizedBox(height: 12),
              _buildContactCard(
                icon: Icons.email,
                title: 'Email',
                contact: 'support@koperasiundiksha.ac.id',
                action: () => _sendEmail('support@koperasiundiksha.ac.id'),
                primaryColor: primaryColor,
                context: context,
              ),
              SizedBox(height: 24),

              _buildSectionTitle('FAQ', primaryColor),
              SizedBox(height: 16),
              _buildFAQItem(
                question: 'Bagaimana cara melakukan transfer?',
                answer:
                    'Masuk ke menu Transfer, pilih tujuan transfer, masukkan nominal, dan konfirmasi transaksi dengan PIN Anda.',
                context: context,
                primaryColor: primaryColor,
              ),
              _buildFAQItem(
                question: 'Berapa limit transfer harian?',
                answer:
                    'Limit transfer harian untuk anggota koperasi adalah Rp. 10.000.000.',
                context: context,
                primaryColor: primaryColor,
              ),
              _buildFAQItem(
                question: 'Bagaimana cara mengajukan pinjaman?',
                answer:
                    'Masuk ke menu Pinjaman, pilih jenis pinjaman, masukkan nominal yang diinginkan, dan ikuti prosedur pengajuan.',
                context: context,
                primaryColor: primaryColor,
              ),
              _buildFAQItem(
                question: 'Berapa bunga deposito saat ini?',
                answer:
                    'Bunga deposito koperasi saat ini adalah 5% per tahun untuk tenor 3 bulan, 6% untuk tenor 6 bulan, dan 7% untuk tenor 12 bulan.',
                context: context,
                primaryColor: primaryColor,
              ),
              _buildFAQItem(
                question: 'Bagaimana cara mengubah PIN?',
                answer:
                    'Masuk ke menu Profile, pilih opsi Keamanan, lalu pilih Ubah PIN dan ikuti petunjuk yang diberikan.',
                context: context,
                primaryColor: primaryColor,
              ),

              SizedBox(height: 24),
              _buildSectionTitle('Laporkan Masalah', primaryColor),
              SizedBox(height: 16),
              _buildReportProblemForm(context, primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color primaryColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String contact,
    required Function() action,
    required Color primaryColor,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: action,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: primaryColor, size: 28),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        contact,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
    required BuildContext context,
    required Color primaryColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportProblemForm(BuildContext context, Color primaryColor) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsikan masalah Anda:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 12),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Kategori Masalah',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items:
                [
                  'Transfer',
                  'Pembayaran',
                  'Pinjaman',
                  'Deposito',
                  'Akun dan Keamanan',
                  'Aplikasi Error',
                  'Lainnya',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 12),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Detail Masalah',
              hintText: 'Jelaskan masalah yang Anda alami secara detail...',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(16),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              _showReportSubmitted(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text(
              'Kirim Laporan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showReportSubmitted(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 8),
                Text('Laporan Terkirim'),
              ],
            ),
            content: Text(
              'Terima kasih atas laporan Anda. Tim kami akan menindaklanjuti masalah ini dalam waktu 1x24 jam kerja.',
              style: TextStyle(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Tutup', style: TextStyle(color: primaryColor)),
              ),
            ],
          ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openWhatsApp(String phoneNumber) async {
    String formattedNumber = phoneNumber.replaceAll('-', '');
    if (formattedNumber.startsWith('0')) {
      formattedNumber = '62${formattedNumber.substring(1)}';
    }
    final Uri uri = Uri.parse('https://wa.me/$formattedNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail(String emailAddress) async {
    final Uri uri = Uri.parse('mailto:$emailAddress');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
