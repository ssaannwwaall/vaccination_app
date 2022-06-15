class CustomValidator {
  String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z_]*$)';
    if (value == null) {
      return 'Add a Name';
    }

    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }


  String? validateAlphaNmeric(String? value) {
    String pattern = r'^[a-zA-Z0-9\-\s]+$';

    if (value == null) {
      return 'Field is required';
    }

    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Field is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please avoid special characters";
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null) {
      return 'Field is required';
    }
    return null;
  }
  String? validateAddress(String? value) {
    if (value == null) {
      return 'Address is required';
    }
    return null;
  }

  String? validatePrice(String? val) {
    if (val == null) {
      return ' Enter a Price';
    } else {
      double? _salesPrice = double.tryParse(val);
      if (_salesPrice == null) {
        return "Enter a valid Price";
      } else if (_salesPrice < 1) {
        return 'Price cannot be less than 1';
      }
    }
  }

  String? validateInteger(
    String? val,
  ) {
    if (val == null) {
      return ' Enter a Quantity';
    } else {
      int? _value = int.tryParse(val);
      if (_value == null) {
        return "Enter a valid Value";
      } else if (_value < 1) {
        return 'Value cannot be less than 1';
      }
    }
  }

  String? validateIntegerOrNull(
    String? val,
  ) {
    if (val != null) {
      int? _value = int.tryParse(val);
      if (_value == null) {
        return "Enter a valid Value";
      } else if (_value < 1) {
        return 'Value cannot be less than 1';
      }
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null) {
      return 'Add Mobile Number';
    }

    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Mobile is Required";
    } else if (value.length < 8) {
      return "Mobile number is too short";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String? validatePasswordLength(String? value) {
    if (value == null) {
      return 'Password can\'t be empty';
    }
    const requiredPasswordLength = 6;

    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < requiredPasswordLength) {
      return "Password can't be smaller than  $requiredPasswordLength characters";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null) {
      return 'Password can\'t be empty';
    }

    const requiredPasswordLength = 6;
    String pattern =
        //r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~;()]).{8,}$';
        r'^(?=.*?[a-z])(?=.*?[0-9])().{8,}';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < requiredPasswordLength) {
      return "Password can't be smaller than  $requiredPasswordLength characters";
    } else if (!regExp.hasMatch(value)) {
      return "Password Must have uppercase, lowercase, numeric Number, special characters (! @ # \$ & * ~)";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null) {
      return 'Add an email';
    }

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }
}
