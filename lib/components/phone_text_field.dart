import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:reclaimify/components/input_decoration.dart';
import 'package:reclaimify/utils/colors.dart';

class PhoneTextField extends StatefulWidget {
  PhoneTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final MyDecoration decor = MyDecoration();

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );
  String phoneNumber='';
  String finalPhone() {
    return phoneNumber =
        "+${selectedCountry.phoneCode}${widget.controller.text.trim()}";
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter a valid phone number';
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      obscureText: false,
      style: TextStyle(
        fontSize: 19,
      ),
      controller: widget.controller,
      enableSuggestions: true,
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: InkWell(
            onTap: () {
              showCountryPicker(
                  context: context,
                  countryListTheme:
                      CountryListThemeData(bottomSheetHeight: 500),
                  onSelect: (value) {
                    setState(() {
                      selectedCountry = value;
                    });
                  });
            },
            child: Text(
              "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
        prefixIconColor: AppColors.mainColor,
        label: const Text("Phone"),
        // helperText: "",
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
        helperStyle: const TextStyle(color: Colors.black, fontSize: 12),
        labelStyle: const TextStyle(color: AppColors.textBoxPlaceholder),
        hintText: "Phone",
        hintStyle: TextStyle(color: AppColors.textBoxPlaceholder),
        fillColor: AppColors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.darkGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primaryBlack, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primaryBlack, width: 2),
        ),
      ),
    );
  }
}
