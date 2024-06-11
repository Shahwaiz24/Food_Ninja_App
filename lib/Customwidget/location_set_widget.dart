import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/data_model.dart';

String? final_Country;
String? final_City;

class LocationSetTextFields extends StatefulWidget {
  const LocationSetTextFields({super.key});

  @override
  State<LocationSetTextFields> createState() => _LocationSetTextFieldsState();
}

class _LocationSetTextFieldsState extends State<LocationSetTextFields> {
  String? _selectedCountry;
  String? _selectedCity;
  int? _index;
  int? selected_index;
  bool ischanging = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Column(children: [
      InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.040),
          ),
          contentPadding: EdgeInsets.all(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isDense: true,
            padding: EdgeInsets.only(
                right: screenWidth * 0.040, left: screenWidth * 0.040),
            borderRadius: BorderRadius.circular(screenWidth * 0.040),
            value: _selectedCountry,
            dropdownColor: Colors.white.withOpacity(0.9),
            elevation: 4,
            menuMaxHeight: 200,
            isExpanded: false,
            hint: Text('Select Country'),
            items: countries.map<DropdownMenuItem<String>>((data) {
              return DropdownMenuItem<String>(
                child: Text(data['Title']!),
                value: data['Value'],
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                ischanging = true;
                final_City = null;
                _selectedCity = null;
                _selectedCountry = value as String?;

                _index = int.parse(value!);
                selected_index = _index! - 1;
                print(" Selected Index:  $selected_index");
                print(
                    'Selected Country : $_selectedCountry .. Index : $_index .. CountryType : ${_selectedCountry.runtimeType} .. IndexType: ${_index.runtimeType}');
                final_Country = Cities_Of_Country[selected_index!]['Country'];
              });
              setState(() {
                ischanging = false;
              });
            },
          ),
        ),
      ),
      SizedBox(
        height: screenHeight * 0.040,
      ),
      ischanging == true
          ? Text('')
          : InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.040),
                ),
                contentPadding: EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.040, left: screenWidth * 0.040),
                  borderRadius: BorderRadius.circular(screenWidth * 0.040),
                  value: _selectedCity,
                  dropdownColor: Colors.white.withOpacity(0.9),
                  elevation: 4,
                  menuMaxHeight: 200,
                  isExpanded: false,
                  hint: const Text('Select City'),
                  items: _selectedCountry != null
                      ? check(index_: selected_index)
                      : [],
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value.toString();
                      print(_selectedCity);
                      final_City = _selectedCity;
                      print(final_City);
                    });
                  },
                ),
              ),
            ),
    ]);
  }
}

check({required index_}) {
  try {
    List<DropdownMenuItem<String>> dropdownItems = [];
    Cities_Of_Country[index_]['Cities'].forEach((city) {
      dropdownItems.add(DropdownMenuItem(
        child: Text(city.toString()), // Convert city to string
        value: city.toString(), // Convert city to string
      ));
    });
    return dropdownItems;
  } on Exception catch (e) {
    print(" e: ${e.toString()}");
    // TODO
  }
}
