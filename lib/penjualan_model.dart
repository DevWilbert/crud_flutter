class PenjualanModel {
  int? id;
  String? tanggal;
  String? nama_pakaian;
  String? jenis_pakaian;
  String? ukuran;
  int? jumlah_pakaian;
  int? harga_pakaian;
  int? total;

  PenjualanModel({
    required this.id,
    required this.tanggal,
    required this.nama_pakaian,
    required this.jenis_pakaian,
    required this.ukuran,
    required this.jumlah_pakaian,
    required this.harga_pakaian,
    required this.total,
  });

  PenjualanModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    tanggal = json["tanggal"];
    nama_pakaian = json['nama_pakaian'];
    jenis_pakaian = json["jenis_pakaian"];
    ukuran = json["ukuran"];
    jumlah_pakaian = json["jumlah_pakaian"];
    harga_pakaian = json["harga_pakaian"];
    total = json["total"];
  }
}

