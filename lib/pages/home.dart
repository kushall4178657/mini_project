import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mini_pro/animation/FadeAnimation.dart';
import 'package:mini_pro/carpenter_page.dart';
import 'package:mini_pro/cook_page.dart';
import 'package:mini_pro/electrician_page.dart';
import 'package:mini_pro/pages/cleaning.dart';
import 'package:mini_pro/pages/select_service.dart';
import 'package:mini_pro/widgets//service.dart';
import 'package:mini_pro/plumber_page.dart';
import 'package:mini_pro/logout.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/HomeAppBar.dart';

class HomePageState extends StatefulWidget {
  const HomePageState({Key? key}) : super(key: key);

  @override
  _HomePageStateState createState() => _HomePageStateState();
}

class _HomePageStateState extends State<HomePageState> {
  var auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
  }

  int currentPageIndex = 0;
  List imageList = [
    {
      "id": 1,
      "image_path":
          'assets/Orange and Cream Illustrative Cleaning Service Facebook Cover.png'
    },
    {"id": 2, "image_path": 'assets/8203536.jpg'},
    {"id": 3, "image_path": 'assets/4497113.jpg'},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  List<Service> services = [
    Service('Cleaning',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Cook',
        'https://cdn4.iconfinder.com/data/icons/people-40/48/chef_female-512.png'),
    Service('Plumber',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Electrician',
        'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
    Service('Painter',
        'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Carpenter', 'https://img.icons8.com/fluency/2x/drill.png'),
  ];

  List<dynamic> workers = [
    [
      'Alfredo Schafer',
      'Plumber',
      'https://images.unsplash.com/photo-1506803682981-6e718a9dd3ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=c3a31eeb7efb4d533647e3cad1de9257',
      4.8
    ],
    [
      'Tony Stark',
      'Carpenter',
      'https://images.unsplash.com/photo-1506803682981-6e718a9dd3ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=c3a31eeb7efb4d533647e3cad1de9257',
      4.9
    ],
    [
      'Steve Rogers',
      'Electrician',
      'https://images.unsplash.com/photo-1506803682981-6e718a9dd3ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=c3a31eeb7efb4d533647e3cad1de9257',
      4.5
    ],
  ];

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            // Cleaning Page
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => CleaningPage()),
            // );
            Get.to(() => CleaningPage());
            break;
          case 1:
            // Cook page
            Get.to(() => CookPage());
            break;
          case 2:
            //  Plumber page
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => PlumberPage()),
            // );
            Get.to(() => PlumberPage());
            break;
          case 3:
            // Electrician page
            Get.to(() => ElectricianPage());
            break;
          case 4:
            // Painter page
            break;
          case 5:
            // Carpenter page
            Get.to(() => CarpenterPage());
            break;
          default:
            // Handle default case or error
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12),
        //padding: EdgeInsets.only(5.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(
            color: Colors.pink.withOpacity(0.3),
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 45),
              SizedBox(height: 20),
              Text(
                name,
                style: TextStyle(fontSize: 15, color: Colors.black),
              )
            ]),
      ),
    );
  }

  workerContainer(String name, String job, String image, double rating) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Container(
          margin: EdgeInsets.only(right: 30),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
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
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 20,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeAppBar(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CarouselSlider(
                      items: imageList
                          .map(
                            (item) => Image.asset(
                              item['image_path'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                carouselController.animateToPage(entry.key),
                            child: Container(
                              width: currentIndex == entry.key ? 17 : 7,
                              height: 7.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == entry.key
                                      ? Colors.pink
                                      : Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                FadeAnimation(
                    0,
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectService()),
                                );
                              },
                              child: Text(
                                'View all',
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      ),
                    )),
                Container(
                  //padding: EdgeInsets.all(5),
                  height: 262,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 15.0,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: services.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FadeAnimation(
                            (1.0 + index) / 4,
                            serviceContainer(services[index].imageURL,
                                services[index].name, index));
                      }),
                ),
                FadeAnimation(
                  0,
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Rated',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('View all',
                              style: TextStyle(color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: workers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FadeAnimation(
                            (1.0 + index) / 4,
                            workerContainer(
                                workers[index][0],
                                workers[index][1],
                                workers[index][2],
                                workers[index][3]));
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
