// file: tugas4_atm.dart
import 'dart:async';

// Fungsi tambahan untuk memformat angka ke format Rupiah (contoh: 2500000 -> Rp 2.500.000)
String rupiah(double angka) {
  String s = angka.toStringAsFixed(0);
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

// 1. Class Nasabah
class Nasabah {
  String nama;
  String noRekening;
  double _saldo; // Atribut privat (enkapsulasi)[cite: 9]

  // Constructor bernama (named constructor) dengan parameter required[cite: 2, 9]
  Nasabah({
    required this.nama,
    required this.noRekening,
    required double saldoAwal,
  }) : _saldo = saldoAwal;

  // Getter untuk membaca saldo[cite: 3, 9]
  double get saldo => _saldo;

  // Setter dengan validasi setoran harus positif[cite: 3, 9]
  set saldo(double jumlah) {
    if (jumlah <= 0) {
      throw Exception('Jumlah setoran harus lebih besar dari 0!');
    }
    _saldo += jumlah;
  }

  // Method untuk mengurangi saldo saat penarikan[cite: 9]
  void kurangiSaldo(double jumlah) {
    if (jumlah <= 0) {
      throw Exception('Jumlah penarikan harus lebih besar dari 0!');
    }
    if (jumlah > _saldo) {
      throw Exception(
        'Saldo tidak mencukupi! Saldo Anda saat ini: ${rupiah(_saldo)}',
      );
    }
    _saldo -= jumlah;
  }

  void infoNasabah() {
    print(
      'Nasabah: $nama | No Rekening: $noRekening | Saldo: ${rupiah(_saldo)}',
    );
  }
}

// 2. Class ATM dengan method tarik dan setor[cite: 9]
class ATM {
  void setor(Nasabah n, double jumlah) {
    print('\n[ATM] Memproses setoran untuk ${n.nama}...');
    try {
      n.saldo = jumlah; // Menggunakan setter dengan validasi[cite: 3, 9]
      print('Setoran berhasil! Saldo terbaru ${n.nama}: ${rupiah(n.saldo)}');
    } catch (e) {
      print('Gagal melakukan setoran: $e');
    }
  }

  void tarik(Nasabah n, double jumlah) {
    print(
      '\n[ATM] Memproses penarikan untuk ${n.nama} sebesar ${rupiah(jumlah)}...',
    );
    n.kurangiSaldo(
      jumlah,
    ); // Dapat melempar Exception jika saldo kurang[cite: 8, 9]
    print('Penarikan berhasil! Sisa saldo ${n.nama}: ${rupiah(n.saldo)}');
  }

  // 5. Method asinkronus cekSaldoOnline (simulasi delay 2 detik dengan Future.delayed)[cite: 7, 9]
  Future<double> cekSaldoOnline(Nasabah n) async {
    print(
      '\n[Server ATM] Menghubungkan ke server bank untuk ${n.noRekening}...',
    );
    await Future.delayed(Duration(seconds: 2));
    print('[Server ATM] Data berhasil disinkronisasi.');
    return n.saldo;
  }
}

void main() async {
  print('========================================');
  print('    PROGRAM SIMULASI MESIN ATM          ');
  print('========================================\n');

  // 4. Menyimpan minimal 3 nasabah dalam List<Nasabah>[cite: 9]
  List<Nasabah> daftarNasabah = [
    Nasabah(
      nama: 'Muhammad Asdiani',
      noRekening: '1010123',
      saldoAwal: 2500000,
    ),
    Nasabah(
      nama: 'Muhammad Asdiani',
      noRekening: '1010124',
      saldoAwal: 5000000,
    ),
    Nasabah(nama: 'Zulkifli Anshori', noRekening: '1010125', saldoAwal: 350000),
  ];

  // Tampilkan data awal seluruh nasabah
  print('Daftar Nasabah Terdaftar:');
  for (var n in daftarNasabah) {
    n.infoNasabah();
  }

  var mesinAtm = ATM();

  // Uji Transaksi Setor
  mesinAtm.setor(daftarNasabah[0], 500000);

  // 3. Menggunakan try-catch di program utama untuk menangkap error penarikan berlebih[cite: 8, 9]
  print('\n--- Simulasi Transaksi Penarikan Tunai ---');

  // Penarikan berhasil
  try {
    mesinAtm.tarik(daftarNasabah[1], 1000000);
  } catch (e) {
    print('Error Transaksi: $e');
  }

  // Penarikan gagal (melebihi saldo, memicu Exception)[cite: 8, 9]
  try {
    print('\nMencoba menarik uang melebihi saldo akun Ahmad Fauzi...');
    mesinAtm.tarik(daftarNasabah[2], 1000000);
  } catch (e) {
    print('Tertangkap Exception: $e');
  }

  // 6. Membungkus pemanggilan cekSaldoOnline dengan await dan menampilkan hasilnya[cite: 7, 8, 9]
  print('\n--- Simulasi Cek Saldo Online via Server ---');
  for (var n in daftarNasabah) {
    double saldoServer = await mesinAtm.cekSaldoOnline(n);
    print('Hasil Server -> Saldo terkini ${n.nama}: ${rupiah(saldoServer)}');
  }

  print('\n========================================');
  print('    SIMULASI SELESAI                    ');
  print('========================================');
}
