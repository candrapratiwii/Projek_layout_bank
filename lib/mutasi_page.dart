import 'package:flutter/material.dart';

class MutasiPage extends StatelessWidget {
  final List<String> mutasiList;

  const MutasiPage({Key? key, required this.mutasiList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mutasi Rekening',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Mutasi',
              style: TextStyle(
                fontSize: screenWidth > 600 ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: mutasiList.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada transaksi.',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: mutasiList.length,
                      itemBuilder: (context, index) {
                        String item = mutasiList[index];
                        bool isDebit = item.toLowerCase().contains('pembayaran') ||
                            item.toLowerCase().contains('transfer');

                        return Card(
                          color: theme.cardColor,
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Icon(
                              isDebit ? Icons.arrow_upward : Icons.arrow_downward,
                              color: isDebit ? Colors.red : Colors.green,
                            ),
                            title: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16,
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                            ),
                            subtitle: Text(
                              'Rp. -',
                              style: TextStyle(
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                            trailing: Text(
                              isDebit ? 'Debit' : 'Kredit',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDebit ? Colors.red : Colors.green,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
