// ignore_for_file: deprecated_member_use

class Il {
  Il({
    this.ilAdi,
    this.plakaKodu,
    this.ilceler,
  });

  String? ilAdi;
  String? plakaKodu;
  List<Ilce>? ilceler;

  factory Il.fromJson(Map<String, dynamic> json) {
    var list = json["ilceler"] as List;

    List<Ilce> ilcelerList = list.map((i) => Ilce.fromJson(i)).toList();

    return Il(
      ilAdi: json["il_adi"],
      plakaKodu: json["plaka_kodu"],
      ilceler: json["ilceler"] != null ? ilcelerList : <Ilce>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "il_adi": ilAdi,
        "plaka_kodu": plakaKodu,
        "ilceler": List<dynamic>.from(ilceler!.map((x) => x.toJson())),
      };
}

class Ilce {
  Ilce({
    this.ilceAdi,
  });

  String? ilceAdi;

  factory Ilce.fromJson(Map<String, dynamic> json) => Ilce(
        ilceAdi: json["ilce_adi"],
      );

  Map<String, dynamic> toJson() => {
        "ilce_adi": ilceAdi,
      };
}