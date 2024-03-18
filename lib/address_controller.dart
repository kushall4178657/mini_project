import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pro/address_model.dart';
import 'package:mini_pro/address_repositry.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  final String address = "";

  final name = TextEditingController();
  final phone = TextEditingController();
  final street = TextEditingController();
  final postalcode = TextEditingController();

  RxBool refreshData = true.obs;

  GlobalKey<FormState> addressFormkey = GlobalKey<FormState>();

  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      if (addresses.isEmpty) {
        print("No addresses found for the user.");
        return [];
      }
      // selectedAddress.value = addresses.firstWhere(
      //   (element) => element.selectedAddress,
      //   orElse: () => AddressModel.empty(),
      // );
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress ?? false,
          orElse: () => AddressModel.empty());
      print(addresses);
      return addresses;
    } catch (e) {
      print("Error fetching user addresses: $e");
      throw 'Address Not found';
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      throw 'Error';
    }
  }

  Future addNewAddress() async {
    try {
      final address = AddressModel(
          id: '',
          name: name.text,
          phoneNumber: phone.text,
          street: street.text,
          city: cityValue,
          state: stateValue,
          postalCode: postalcode.text,
          country: countryValue);
      final id = await addressRepository.addAddress(address);
      address.id = id;
      await selectedAddress(address);
      resetFormField();
      refreshData.toggle();
      print('$name,$address,$phone');
      Navigator.of(Get.context!).pop();
    } catch (e) {
      throw 'Cannot Write';
    }
  }

  void resetFormField() {
    name.clear();
    phone.clear();
    street.clear();
    postalcode.clear();
    addressFormkey.currentState?.reset();
  }
}
