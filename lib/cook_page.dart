import 'package:flutter/material.dart';
import 'package:mini_pro/pages/date_time.dart';

class CookPage extends StatefulWidget {
  @override
  State<CookPage> createState() => _CookPageState();
}

class _CookPageState extends State<CookPage> {
  List<Map<String, dynamic>> _services = [
    {
      'name': 'Small Family',
      'iconUrl': 'assets/icons8-family-80.png',
      'color': Colors.red,
      'selected': false,
      'person_count': 1.0,
      'min': 1.0,
      'max': 5.0,
    },
    {
      'name': 'Small event',
      'iconUrl': 'assets/letter-s.png',
      'color': Colors.orange,
      'selected': false,
      'person_count': 10.0,
      'min': 6.0,
      'max': 30.0,
    },
    {
      'name': 'Medium Event',
      'iconUrl': 'assets/letter-m.png',
      'color': Colors.blue,
      'selected': false,
      'person_count': 50.0,
      'min': 31.0,
      'max': 80.0,
    },
    {
      'name': 'Large event',
      'iconUrl': 'assets/letter-l.png',
      'color': Colors.purple,
      'selected': false,
      'person_count': 100.0,
      'min': 81.0,
      'max': 150.0,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: _services.any((room) => room['selected'])
            ? FloatingActionButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         // DateAndTime(),
                  //   ),
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_services.where((service) => service['selected']).length}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ],
                ),
                backgroundColor: Colors.blue,
              )
            : null,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                  child: Text(
                    'how many people you want to be served?',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _services.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildRoomWidget(_services[index], index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomWidget(Map<String, dynamic> service, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _services[index]['selected'] = !_services[index]['selected'];
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: service['selected']
              ? service['color'].shade50.withOpacity(0.5)
              : Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    // Image.network(
                    //   service['iconUrl'],
                    //   width: 35,
                    //   height: 35,
                    // ),
                    Image(
                      image: AssetImage(
                        service['iconUrl'],
                      ),
                      height: 35.0,
                      width: 35.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      service['name'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Spacer(),
                service['selected']
                    ? Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 20,
                        ),
                      )
                    : SizedBox()
              ],
            ),
            service['selected']
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        "How many ${service['name']}s?",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 5.0),
                      SizedBox(height: 5),
                      Slider(
                        activeColor: Colors.red,
                        inactiveColor: Colors.pink.shade50,
                        label: 'Select ${service['name']} People',
                        value: service['person_count'],
                        onChanged: (value) {
                          setState(() {
                            _services[index]['person_count'] = value;
                          });
                        },
                        max: _services[index]['max'],
                        min: _services[index]['min'],
                      ),
                      Text(
                        'Selected ${service['name']} people is: ${service['person_count'].toInt()}',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
