class VaccinationRecord {
  String? vaccination_date;
  String? vaccination_name;
  String? kid_key;
  String? _key;
  String? vaccinator_uid;
  String? lat;
  String? long;
  String? adress;

  VaccinationRecord(this.vaccination_date, this.vaccination_name, this.kid_key,
      this.vaccinator_uid);

  Map<String, dynamic> getMapOf() {
    Map<String, dynamic> map = {
      'vaccination_date': vaccination_date,
      'vaccination_name': vaccination_name,
      'kid_key': kid_key,
      'vaccinator_uid': vaccinator_uid,
      'key': _key,
      'lat': lat,
      'long': long,
      'address': adress,
    };
    return map;
  }

  VaccinationRecord.fromSnapshot(Map<String, dynamic> value) {
    vaccination_date = value['vaccination_date'];
    vaccination_name = value['vaccination_name,'];
    kid_key = value['kid_key'];
    vaccinator_uid = value[' vaccinator_uid'];
    _key = value['key'];
    lat = value['lat'];
    long = value['long'];
    adress = value['address'];
  }

  String get key => _key!;

  set key(String value) {
    _key = value;
  }
}
