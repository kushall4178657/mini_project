import 'package:get/get.dart';
import 'package:mini_pro/animation/FadeAnimation.dart';
import 'package:mini_pro/pages/cleaning.dart';
import 'package:mini_pro/pages/date_time.dart';
import 'package:mini_pro/pages/select_service.dart';
import 'package:mini_pro/widgets//service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/HomeAppBar.dart';

class CarpenterPage extends StatefulWidget {
  const CarpenterPage({Key? key}) : super(key: key);
  static carpenter_Service final_service = carpenter_Service('', '', '', '');

  static void resetFinalService() {
    final_service = carpenter_Service('', '', '', '');
  }

  @override
  _CarpenterPageState createState() => _CarpenterPageState();
}

class _CarpenterPageState extends State<CarpenterPage> {
  carpenter_Service? selectedService;
  List<dynamic> workers = [
    [
      'Alfredo Schafer',
      'Carpenter',
      'https://images.unsplash.com/photo-1506803682981-6e718a9dd3ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=c3a31eeb7efb4d533647e3cad1de9257',
      4.8
    ],
    [
      'Tony Stark',
      'Carpenter',
      'https://images.unsplash.com/photo-1506803682981-6e718a9dd3ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=c3a31eeb7efb4d533647e3cad1de9257',
      4.8
    ],
    [
      'Steve Rogers',
      'Carpenter',
      'https://images.unsplash.com/photo-1506803682981-6e718a9dd3ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=c3a31eeb7efb4d533647e3cad1de9257',
      4.8
    ],
  ];

  List<carpenter_Service> services = [
    carpenter_Service(
        'Minor Repair/Installtion',
        'assets/icons8-carpenter-50.png',
        'Book an expert carpenter for on-site issue inspection,Actual prices based on scope of work and rate card',
        'Rs 99'),
    carpenter_Service(
        'Book a Carpenter',
        'assets/icons8-consultation-50.png',
        'Includes inspection charges,Actual prices based on scope of work and rate card',
        'Rs 49'),
  ];

  void selectService(carpenter_Service service) {
    setState(() {
      selectedService = service;
    });
  }

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
            'Carpenter',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.pink,
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Popular Services',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      CarpenterPage.final_service = services[index];
                      selectService(services[index]);
                      Get.to(() => DateAndTime());
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              services[index].image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  services[index].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  services[index].description,
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Price: ${services[index].price}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          if (selectedService == services[index])
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Popular Workers',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListView.builder(
                        //scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: workers.length,
                        itemBuilder: (BuildContext context, int index) {
                          //SizedBox(height: 10,);
                          return FadeAnimation(
                            (1.0 + index) / 4,
                            //SizedBox(height: 20,),
                            workerContainer(
                                workers[index][0],
                                workers[index][1],
                                workers[index][2],
                                workers[index][3]),
                          );
                        }),
                  ],
                ),
              ),
            ]),
          ),
        ),
        //SizedBox(height: 150,),
      ),
    );
  }

  workerContainer(String name, String job, String image, double rating) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Container(
          margin: EdgeInsets.only(top: 0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(image)),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      job,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rating.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 20,
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
