import 'VaccinationDoseForRegular.dart';

class NewRegisterationModel {
  String? _name;
  String? _fname;
  String? _phone;
  String? _dob;
  String? _city;
  String? _tahsil;
  String? _latitude;
  String? _longitude;
  String? _address;
  String? _pic;
  String? _unionCouncil;
  String? _joiningDate;
  String? _gender;
  String? _epi_card_no, _key;

  //String? _vaccinationKey;
  String? _nextVaccinationDate;
  List<VaccinationDoseForRegular>? list_of_vaccincs;

  NewRegisterationModel(
      this._name,
      this._fname,
      this._phone,
      this._dob,
      this._city,
      this._tahsil,
      this._latitude,
      this._longitude,
      this._address,
      this._pic,
      this._unionCouncil,
      this._joiningDate,
      this._gender,
      this._nextVaccinationDate,
      //this._vaccinationKey,
      this.list_of_vaccincs);

  Future<Map<String, dynamic>> getMapOf() async{
    Map<String, dynamic> map = {
      'name': _name,
      'fname': _fname,
      'phone': _phone,
      'DOB': _dob,
      'city': _city,
      'tahsil': _tahsil,
      'latitude': _latitude,
      'Longitude': _longitude,
      'key': key,
      'address': _address,
      'pic': _pic,
      'unionCouncil': _unionCouncil,
      'joiningDate': _joiningDate,
      'gender': _gender,
      //'vaccinationKey': _vaccinationKey,
      'nextVaccinationDate': _nextVaccinationDate,
      'list_of_vaccincs': await getMapofList(list_of_vaccincs), // list_of_vaccincs,
    };
    return map;
  }

  NewRegisterationModel.fromSnapshot(Map<String, dynamic> value) {
    _name = value['name'];
    _fname = value['fname'];
    _phone = value['phone'];
    _dob = value['DOB'];
    _city = value['city'];
    _tahsil = value['tahsil'];
    _latitude = value['latitude'];
    _longitude = value['longitude'];
    _address = value['address'];
    _pic = value['pic'];
    _unionCouncil = value['unionCouncil'];
    _joiningDate = value['joiningDate'];
    _gender = value['gender'];
    list_of_vaccincs = value['list_of_vaccincs'];
    _epi_card_no = value['epi_card_no'];
    _key = value['key'];
    //_vaccinationKey = value['vaccinationKey'];
    _nextVaccinationDate = value['nextVaccinationDate'];
  }

  String get nextVaccinationDate => _nextVaccinationDate!;

  set nextVaccinationDate(String value) {
    _nextVaccinationDate = value;
  }

  // String get vaccinationKey => _vaccinationKey!;
  //
  // set vaccinationKey(String value) {
  //   _vaccinationKey = value;
  // }

  get key => _key;

  set key(value) {
    _key = value;
  }

  String get epi_card_no => _epi_card_no!;

  set epi_card_no(String value) {
    _epi_card_no = value;
  }

  String get gender => _gender!;

  set gender(String value) {
    _gender = value;
  }

  String get joiningDate => _joiningDate!;

  set joiningDate(String value) {
    _joiningDate = value;
  }

  String get unionCouncil => _unionCouncil!;

  set unionCouncil(String value) {
    _unionCouncil = value;
  }

  String get pic => _pic!;

  set pic(String value) {
    _pic = value;
  }

  String get address => _address!;

  set address(String value) {
    _address = value;
  }

  String get longitude => _longitude!;

  set longitude(String value) {
    _longitude = value;
  }

  String get latitude => _latitude!;

  set latitude(String value) {
    _latitude = value;
  }

  String get tahsil => _tahsil!;

  set tahsil(String value) {
    _tahsil = value;
  }

  String get city => _city!;

  set city(String value) {
    _city = value;
  }

  String get dob => _dob!;

  set dob(String value) {
    _dob = value;
  }

  String get phone => _phone!;

  set phone(String value) {
    _phone = value;
  }

  String get fname => _fname!;

  set fname(String value) {
    _fname = value;
  }

  String get name => _name!;

  set name(String value) {
    _name = value;
  }

  Map<String, dynamic> getMapofList(List<VaccinationDoseForRegular>? list_vacc) {
    Map<String, dynamic> map = {};
    for (int i = 0; i < list_vacc!.length; i++) {
      map = {
        i.toString(): {
          list_vacc[i].getMapOf(),
          print('list of vaccine'),
          print(list_vacc[i].vaccination_name),
        },
      };
    }
    return map;
  }
}
