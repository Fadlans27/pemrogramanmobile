// Format angka menjadi rupiah
String rupiah(int angka) {
  String s = angka.toString();
  String hasil = '';
  int hitung = 0;
  for (int i = s.length - 1; i >= 0; i--) {
    hasil = s[i] + hasil;
    hitung++;
    if (hitung % 3 == 0 && i != 0) {
      hasil = '.$hasil';
    }
  }
  return 'Rp $hasil';
}

// Teks rata tengah untuk lebar struk 40 karakter
String tengah(String teks) => teks.padLeft((40 + teks.length) ~/ 2);

// Satu baris "label ........ nilai" (lebar 40 karakter)
String baris(String label, String nilai) =>
    label.padRight(22) + nilai.padLeft(18);

// Menampilkan seluruh menu bernomor
void tampilkanMenu(List<Map<String, dynamic>> menu) {
  print('========== DAFTAR MENU ==========');
  for (int i = 0; i < menu.length; i++) {
    String nama = (menu[i]['nama'] as String).padRight(18);
    print('${i + 1}. $nama — ${rupiah(menu[i]['harga'] as int)}');
  }
  print('=================================');
}

// Menambah pesanan berdasarkan nomor menu
void tambahPesanan(
  List<Map<String, dynamic>> menu,
  List<Map<String, dynamic>> pesanan, {
  required int nomor,
  required int qty,
}) {
  Map<String, dynamic> item = menu[nomor - 1];
  int subtotal = (item['harga'] as int) * qty;
  pesanan.add({'nama': item['nama'], 'qty': qty, 'subtotal': subtotal});
}

// Diskon bertingkat: >= 100.000 -> 10%, >= 50.000 -> 5%, selain itu 0%
int hitungDiskon(int total) {
  if (total >= 100000) {
    return 10;
  } else if (total >= 50000) {
    return 5;
  } else {
    return 0;
  }
}

// Mencetak struk
void cetakStruk({
  required List<Map<String, dynamic>> pesanan,
  required int total,
  required int persenDiskon,
  required int nilaiDiskon,
  required int ppn,
  required int totalBayar,
}) {
  print('=' * 40);
  print(tengah('WARUNG MAKAN FADLAN'));
  print(tengah('STRUK PEMBELIAN'));
  print('=' * 40);

  for (var item in pesanan) {
    String nama = (item['nama'] as String).padRight(18);
    String qty = 'x${item['qty']}'.padLeft(4);
    String sub = rupiah(item['subtotal'] as int).padLeft(18);
    print('$nama$qty$sub');
  }

  print('-' * 40);
  print(baris('Total', rupiah(total)));
  print(baris('Diskon ($persenDiskon%)', '- ${rupiah(nilaiDiskon)}'));
  print(baris('PPN 10%', rupiah(ppn)));
  print('-' * 40);
  print(baris('TOTAL BAYAR', rupiah(totalBayar)));
  print('=' * 40);
  print(tengah('Terima kasih, selamat menikmati!'));
}

void main() {
  // 1. Daftar menu
  List<Map<String, dynamic>> menu = [
    {'nama': 'Nasi Goreng', 'harga': 15000},
    {'nama': 'Mie Goreng', 'harga': 14000},
    {'nama': 'Ayam Bakar', 'harga': 20000},
    {'nama': 'Soto Banjar', 'harga': 16000},
    {'nama': 'Ketupat Kandangan', 'harga': 18000},
    {'nama': 'Sate Ayam', 'harga': 2000},
    {'nama': 'Es Teh', 'harga': 3000},
    {'nama': 'Es Jeruk', 'harga': 5000},
  ];

  // 2. Tampilkan menu bernomor
  tampilkanMenu(menu);
  print('');

  // 3. Pesanan (List<Map>)
  List<Map<String, dynamic>> pesanan = [];
  tambahPesanan(menu, pesanan, nomor: 1, qty: 2);
  tambahPesanan(menu, pesanan, nomor: 3, qty: 2);
  tambahPesanan(menu, pesanan, nomor: 6, qty: 10);
  tambahPesanan(menu, pesanan, nomor: 7, qty: 4);

  // 4. Hitung total, diskon, PPN 10%, dan total bayar
  int total = 0;
  for (var item in pesanan) {
    total += item['subtotal'] as int;
  }
  // 5. hitung diskon bertingkat
  int persenDiskon = hitungDiskon(total);
  int nilaiDiskon = total * persenDiskon ~/ 100;
  int setelahDiskon = total - nilaiDiskon;
  int ppn = setelahDiskon * 10 ~/ 100; // PPN 10% dari harga setelah diskon
  int totalBayar = setelahDiskon + ppn;

  // 6. Cetak struk
  cetakStruk(
    pesanan: pesanan,
    total: total,
    persenDiskon: persenDiskon,
    nilaiDiskon: nilaiDiskon,
    ppn: ppn,
    totalBayar: totalBayar,
  );
}
