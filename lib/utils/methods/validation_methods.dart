String? validateEmail(String? email) {
  var emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (email!.trim().isEmpty) {
    return 'Email can\'t be empty!';
  } else if (!emailValid.hasMatch(email)) {
    return 'Please enter valid email!';
  } else {
    return null;
  }
}

String? validatePassword(String? password) {
  if (password!.trim().isEmpty) {
    return 'Password can\'t be empty!';
  } else if (password.length < 6) {
    return 'Password must be of minimum 6 characters!';
  }
  return null;
}

String? validateFullName(String? name) {
  if (name!.trim().isEmpty) {
    return 'Full Name can\'t be empty!';
  }
  return null;
}

//add payment method
String? validateHolderName(String? name) {
  if (name!.trim().isEmpty) {
    return 'Card Holder Name can\'t be empty!';
  }
  return null;
}

String? validateCardNumber(String? number) {
  if (number!.trim().isEmpty) {
    return 'Card number can\'t be empty!';
  } else if (number.length < 16) {
    return 'Card number must be of 16 digit!';
  } else if (number.length > 16) {
    return 'Card number must be of 16 digit!';
  }
  return null;
}

String? validateCVV(String? cvv) {
  if (cvv!.trim().isEmpty) {
    return 'CVV can\'t be empty!';
  } else if (cvv.length < 3) {
    return 'CVV must be of 3 digit!';
  } else if (cvv.length > 3) {
    return 'CVV must be of 3 digit!';
  }
  return null;
}

String? validateExpirationDate(String? date) {
  if (date!.trim().isEmpty) {
    return 'Expiration date can\'t be empty!';
  }
  return null;
}

//add shipping address
String? validateMobileNumber(String? number) {
  if (number!.trim().isEmpty) {
    return 'Mobile number can\'t be empty!';
  } else if (number.length < 10) {
    return 'Mobile Number must be of 10 digit!';
  } else if (number.length > 10) {
    return 'Mobile Number must be of 10 digit!';
  }
  return null;
}

String? validateAddress(String? address) {
  if (address!.trim().isEmpty) {
    return 'Address can\'t be empty!';
  }
  return null;
}

String? validateZipcode(String? zipcode) {
  if (zipcode!.trim().isEmpty) {
    return 'Zipcode can\'t be empty!';
  } else if (zipcode.length < 6) {
    return 'Zipcode must be of 6 digit!';
  } else if (zipcode.length > 6) {
    return 'Zipcode must be of 6 digit!';
  }
  return null;
}

String? validateCity(String? city) {
  if (city!.trim().isEmpty) {
    return 'City can\'t be empty!';
  }
  return null;
}

String? validateState(String? state) {
  if (state!.trim().isEmpty) {
    return 'State can\'t be empty!';
  }
  return null;
}

String? validateCountry(String? country) {
  if (country!.trim().isEmpty) {
    return 'Country can\'t be empty!';
  }
  return null;
}
