import 'package:flutter/material.dart';
import 'package:mini_pro/pages/cleaning.dart';
import 'package:mini_pro/pages/date_time.dart';

class OrderSummary extends StatelessWidget {
  final SelectedDateTime selectedDateTime;
  static List<SelectedRoom> selectedRooms = CleaningPage.final_rooms;
  const OrderSummary({Key? key, required this.selectedDateTime})
      : super(key: key);
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      Text('Extra Services: ${selectedDateTime.extraServices} ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'addaddress');
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
