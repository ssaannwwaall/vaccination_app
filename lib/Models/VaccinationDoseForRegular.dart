class VaccinationDoseForRegular {
  String? vaccination_name;
  String? vaccinator_uid;
  bool vaccined = false;

  VaccinationDoseForRegular(this.vaccination_name, this.vaccinator_uid,
      this.vaccined);

  Map<String, dynamic> getMapOf() {
    Map<String, dynamic> map = {
      'vaccination_name': vaccination_name,
      'vaccinator_uid': vaccinator_uid,
      'vaccined': vaccined,
    };
    return map;
  }


  VaccinationDoseForRegular.fromSnapshot(Map<String, dynamic> value) {
    vaccination_name = value['vaccination_name'];
    vaccinator_uid = value['vaccinator_uid'];
    vaccined = value['vaccined'];
  }
}
