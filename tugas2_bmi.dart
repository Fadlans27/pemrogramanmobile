void main() {
  // Data diri
  String nama = 'Ahmad Fadlan';
  double berat = 65.0; // kg
  double tinggi = 161.0; // cm

  const int cmPerMeter = 100;

  // Hitung BMI = berat / (tinggi_meter * tinggi_meter)
  double tinggiMeter = tinggi / cmPerMeter;
  double bmi = berat / (tinggiMeter * tinggiMeter);

  // Kategori BMI (operator perbandingan & logika, hasilnya bool)
  bool kurus = bmi < 18.5;
  bool normal = bmi >= 18.5 && bmi < 25;
  bool overweight = bmi >= 25 && bmi < 30;

  // Tentukan kategori dengan ternary bersarang
  String kategori = kurus
      ? 'Kurus'
      : normal
      ? 'Normal'
      : overweight
      ? 'Overweight'
      : 'Obesitas';

  // String interpolation
  print('==============================');
  print(' LAPORAN BMI(Body Mass Index) ');
  print('==============================');
  print('Nama     : $nama');
  print('Berat    : $berat kg');
  print('Tinggi   : $tinggi cm');
  print('BMI      : ${bmi.toStringAsFixed(2)}');
  print('Kategori : $kategori');
}

/*
  CONTOH DATA UJI

  Data uji 1
  Output :
  ==============================
   LAPORAN BMI(Body Mass Index)
  ==============================
  Nama     : Muhammad Asdiani
  Berat    : 50.0 kg
  Tinggi   : 158.0 cm
  BMI      : 20.03
  Kategori : Normal

  Data uji 2
  Output :
  ==============================
   LAPORAN BMI(Body Mass Index)
  ==============================
  Nama     : Muhammad Zulkifli Anshori
  Berat    : 85.0 kg
  Tinggi   : 173.0 cm
  BMI      : 26.06
  Kategori : Overweight

  Data uji 2
  Output :
  ==============================
   LAPORAN BMI(Body Mass Index)
  ==============================
  Nama     : Eka Selvy Saputri
  Berat    : 50.0 kg
  Tinggi   : 165.0 cm
  BMI      : 18.37
  Kategori : Kurus
*/
