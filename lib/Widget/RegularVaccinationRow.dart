import 'package:flutter/material.dart';

class RegularVaccinationRow extends StatelessWidget {
  bool checkboxValue = false;
  String? vaccinationName;
  final Function(bool?)? checkBoxStateFun;
  final Color? themeColor;

  RegularVaccinationRow(this.themeColor, this.checkboxValue,
      this.vaccinationName, this.checkBoxStateFun);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              checkColor: themeColor,
              value: checkboxValue,
              onChanged: checkBoxStateFun!.call(checkboxValue)),
          Text(
            vaccinationName!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
