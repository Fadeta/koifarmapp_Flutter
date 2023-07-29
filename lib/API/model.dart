import 'dart:convert';

class listkoi {
  final String jeniskoi;
  final int jumlah;
  final String image;

  listkoi(this.jeniskoi, this.jumlah, this.image);

  Map<String, dynamic> toMap() {
    return {
      'jeniskoi': jeniskoi,
      'jumlah': jumlah,
      'image': image,
    };
  }

  factory listkoi.fromMap(Map<String, dynamic> map) {
    return listkoi(
      map['name'] ?? '',
      map['jumlah']?.toInt() ?? 0,
      map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory listkoi.fromJson(String source) =>
      listkoi.fromMap(json.decode(source));
}
