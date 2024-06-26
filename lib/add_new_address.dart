import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mini_pro/address_repositry.dart';
import 'package:mini_pro/address_controller.dart';

class AddNewAddress extends StatefulWidget {
  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  // String countryValue = "";
  // String stateValue = "";
  // String cityValue = "";
  // final String address = "";

  // final name = TextEditingController();
  // final phone = TextEditingController();
  // final street = TextEditingController();
  // final postalcode = TextEditingController();

  final controller = AddressController.instance;

  GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Add New Address',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.pink,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: controller.addressFormkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name (min 5 characters).';
                      } else if (value.length < 5) {
                        return 'Full Name is too short!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusColor: Colors.pink,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.account_circle),
                      label: const Text('Full Name (5 characters minimum)'),
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length < 10) {
                        return 'Mobile number must be at least 10 digits';
                      }
                      if (value.length > 10) {
                        return 'Mobile number should not exceed 10 digits';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusColor: Colors.pink,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.phone_android_outlined),
                      label: const Text('Phone Number'),
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.street,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Street Address cannot be empty!';
                            } else if (value.length < 10) {
                              return 'Street Address too short!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.pink,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.location_city_rounded),
                            label: const Text('Street Address'),
                            labelStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.postalcode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pin Code can\'t be empty!';
                            } else if (value.length < 5) {
                              return 'Pincode too short';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.pink,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.pin),
                            label: const Text('Pin Code'),
                            labelStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CSCPicker(
                    showCities: true,
                    showStates: true,
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1)),
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.black, width: 1)),
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",
                    countryDropdownLabel: "*Country",
                    stateDropdownLabel: "*State",
                    cityDropdownLabel: "*City",
                    selectedItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    dropdownHeadingStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    dropdownItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    onCountryChanged: (value) {
                      setState(() {
                        if (value != null) {
                          setState(() {
                            ///store value in country variable
                            controller.countryValue = value;
                          });
                        }
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        ///store value in country variable
                        if (value != null) {
                          controller.stateValue = value;
                        }
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        ///store value in city variable
                        if (value != null) {
                          controller.cityValue = value;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.addressFormkey.currentState!
                            .validate()) {
                          // All fields are valid, proceed with saving the address
                          controller.addNewAddress();
                        }
                      },
                      child: Text(
                        'Save Address',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
