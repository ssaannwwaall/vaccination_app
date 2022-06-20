class NewlyBorn {
  String _name,
      _fname,
      _phone,
      _dob,
      _city,
      _tahsil,
      _latitude,
      _longitude,
      _address,
      _pic,
      _unionCouncil,
      _joiningDate,
      _gender,
      _vaccinator_uid;
  String? _epi_card_no, _key;

  NewlyBorn(
      this._gender,
      this._name,
      this._fname,
      this._city,
      this._dob,
      this._tahsil,
      this._unionCouncil,
      this._phone,
      this._latitude,
      this._longitude,
      this._address,
      this._pic,
      this._joiningDate,
      this._vaccinator_uid);

  Map<String, String> getMapOf() {
    Map<String, String> map = {
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
      'vaccinator_uid': _vaccinator_uid,
    };
    return map;
  }

  get gender => _gender;

  set gender(value) {
    _gender = value;
  }

  get joiningDate => _joiningDate;

  set joiningDate(value) {
    _joiningDate = value;
  }

  get unionCouncil => _unionCouncil;

  set unionCouncil(value) {
    _unionCouncil = value;
  }

  get pic => _pic;

  set pic(value) {
    _pic = value;
  }

  get address => _address;

  set address(value) {
    _address = value;
  }

  get key => _key;

  set key(value) {
    _key = value;
  }

  String get epi_card_no => _epi_card_no ?? '';

  set epi_card_no(String value) {
    _epi_card_no = value;
  }

  get longitude => _longitude;

  set longitude(value) {
    _longitude = value;
  }

  get latitude => _latitude;

  set latitude(value) {
    _latitude = value;
  }

  get tahsil => _tahsil;

  set tahsil(value) {
    _tahsil = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get dob => _dob;

  set dob(value) {
    _dob = value;
  }

  get phone => _phone;

  set phone(value) {
    _phone = value;
  }

  get fname => _fname;

  set fname(value) {
    _fname = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
