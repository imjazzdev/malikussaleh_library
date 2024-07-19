class Book {
  final String judul, penulis, tahun_terbit, posisi;

  Book(
      {required this.judul,
      required this.penulis,
      required this.tahun_terbit,
      required this.posisi});

  Map<String, dynamic> toJson() => {
        'judul': judul,
        'penulis': penulis,
        'tahun_terbit': tahun_terbit,
        'posisi': posisi,
      };
}
