import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pro/carpenter_page.dart';
import 'package:mini_pro/cook_page.dart';
import 'package:mini_pro/electrician_page.dart';
import 'package:mini_pro/pages/cleaning.dart';
import 'package:mini_pro/pages/date_time.dart';
import 'package:mini_pro/painter_page.dart';
import 'package:mini_pro/plumber_page.dart';
import 'package:mini_pro/widgets/service.dart';

class OrderSummary extends StatelessWidget {
  final SelectedDateTime selectedDateTime;
  static List<SelectedRoom> selectedRooms = [];
  static List<SelectedService> selectedServices = [];
  const OrderSummary({Key? key, required this.selectedDateTime})
      : super(key: key);
  static int total_price = 0;

  @override
  Widget build(BuildContext context) {
    total_price = CleaningPage.price +
        PlumberPage.final_service.price +
        CarpenterPage.final_service.price +
        ElectricianPage.final_service.price +
        CookPage.price +
        PainterPage.finalService.price +
        DateAndTime.extraprice;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        // PlumberPage.resetFinalService();
        // CleaningPage.resetFinalService();
        // ElectricianPage.resetFinalService();
        // CarpenterPage.resetFinalService();
        // DateAndTime.extraprice = 0;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () {
                PlumberPage.resetFinalService();
                CleaningPage.resetFinalService();
                ElectricianPage.resetFinalService();
                CarpenterPage.resetFinalService();
                CookPage.resetFinalService();
                PainterPage.resetFinalService();
                DateAndTime.extraprice = 0;
                Navigator.pushNamedAndRemoveUntil(
                    context, 'bottombar', (route) => false);
              },
            ),
            title: Text(
              'Order Summary',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.pink,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return PlumberPage.final_service.name.isNotEmpty
                        ? ListTile(
                            isThreeLine: true,
                            leading: Text((index + 1).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            title: Text(
                              PlumberPage.final_service.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Service Price:${PlumberPage.final_service.price}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'Selected Service Description:${PlumberPage.final_service.description}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        : null;
                  },
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ElectricianPage.final_service.name.isNotEmpty
                        ? ListTile(
                            isThreeLine: true,
                            leading: Text((index + 1).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            title: Text(
                              ElectricianPage.final_service.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Service Price:${ElectricianPage.final_service.price}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'Selected Service Description:${ElectricianPage.final_service.description}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        : null;
                  },
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return PainterPage.finalService.name.isNotEmpty
                        ? ListTile(
                            isThreeLine: true,
                            leading: Text((index + 1).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            title: Text(
                              PainterPage.finalService.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Service Price:${PainterPage.finalService.price}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'Selected Service Description:${PainterPage.finalService.description}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        : null;
                  },
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: selectedServices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      isThreeLine: true,
                      leading: Text((index + 1).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      title: Text(
                        selectedServices[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Persons:${selectedServices[index].personCount.round()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Selected Service Price :${selectedServices[index].price}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return CarpenterPage.final_service.name.isNotEmpty
                        ? ListTile(
                            isThreeLine: true,
                            leading: Text((index + 1).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            title: Text(
                              CarpenterPage.final_service.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Service Price:${CarpenterPage.final_service.price}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'Selected Service Description:${CarpenterPage.final_service.description}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        : null;
                  },
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: selectedRooms.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      isThreeLine: true,
                      leading: Text((index + 1).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      title: Text(
                        selectedRooms[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Sqft:${selectedRooms[index].sqft.floor().toString()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Selected Room Count:${selectedRooms[index].count.toString()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Selected Service Price:${selectedRooms[index].price.toString()}(Visiting Charges)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                            'Date: ${selectedDateTime.date.day}-${selectedDateTime.date.month}-${selectedDateTime.date.year} ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text('Time: ${selectedDateTime.time} ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(
                          'Extra Services: ${selectedDateTime.extraServices} ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Service Type: ${selectedDateTime.repeat} ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Text(
                  'Total Visiting Charge Cost:Rs.${OrderSummary.total_price}*',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, 'addaddress');
                      Get.toNamed('addaddress');
                    },
                    child: Text(
                      'Confirm and Add Address',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
