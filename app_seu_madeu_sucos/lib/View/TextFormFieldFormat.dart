import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class TextFormFieldFormat {
  static final MaskTextInputFormatter PHONE = MaskTextInputFormatter(
    mask: "(##) # ####-####",
  );
  static final MaskTextInputFormatter STREET_NUMBER = MaskTextInputFormatter(
    mask: "#####",
  );
  static final MaskTextInputFormatter ZIPCODE = MaskTextInputFormatter(
    mask: "#####-###",
  );
  static final MaskTextInputFormatter TIME = MaskTextInputFormatter(
    mask: "##:##",
  );

  static bool checkIfStringHasNumber(value) {
    return value.toString().contains(RegExp(r'(\d+)'));
  }

  static bool checkIfStringHasSpecialCharacters(value) {
    return value
        .toString()
        .contains(RegExp(r'[@#$%^&+=!\*\(\)\[\]\,.\\\/|;:]\-_'));
  }
}
