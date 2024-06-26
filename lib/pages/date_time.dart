import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:get/get.dart';
import 'package:mini_pro/animation/FadeAnimation.dart';
import 'package:mini_pro/carpenter_page.dart';
import 'package:mini_pro/cook_page.dart';
import 'package:mini_pro/electrician_page.dart';
import 'package:mini_pro/order_summary.dart';
import 'package:mini_pro/pages/cleaning.dart';

import 'package:flutter/material.dart';
import 'package:mini_pro/painter_page.dart';
import 'package:mini_pro/plumber_page.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SelectedDateTime {
  final DateTime date;
  final String time;
  final List<String> extraServices;
  final String repeat;
  final List<int> extraServicesprice;

  SelectedDateTime(this.date, this.time, this.extraServices, this.repeat,
      this.extraServicesprice);
}

class DateAndTime extends StatefulWidget {
  // final List<SelectedRoom>? selectedRooms;
  //required this.selectedRooms
  static int extraprice = 0;
  const DateAndTime({Key? key}) : super(key: key);
  static SelectedDateTime final_date =
      SelectedDateTime(DateTime.now(), '10:30', [], '', []);

  @override
  _DateAndTimeState createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  DateTime _selectedDate = DateTime.now();
  int _selectedRepeat = 0;
  String _selectedHour = '10:30';
  List<int> _selectedExteraCleaning = [];

  ItemScrollController _scrollController = ItemScrollController();

  final List<String> _hours = <String>[
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30',
    '22:00',
    '22:30',
    '23:00',
    '23:30',
  ];

  final List<String> _repeat = [
    'No repeat',
    'Every day',
    'Every week',
    'Every month'
  ];

  final List<dynamic> _exteraCleaning = [
    ['Washing', 'https://img.icons8.com/office/2x/washing-machine.png', '200'],
    ['Fridge', 'https://img.icons8.com/cotton/2x/fridge.png', '150'],
    [
      'Vehicle',
      'https://img.icons8.com/external-vitaliy-gorbachev-blue-vitaly-gorbachev/2x/external-bycicle-carnival-vitaliy-gorbachev-blue-vitaly-gorbachev.png',
      '200'
    ],
    [
      'Windows',
      'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-window-interiors-kiranshastry-lineal-color-kiranshastry-1.png',
      '50'
    ],
  ];

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.scrollTo(
        index: 5,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        PlumberPage.resetFinalService();
        CleaningPage.resetFinalService();
        ElectricianPage.resetFinalService();
        CarpenterPage.resetFinalService();
        CookPage.resetFinalService();
        PainterPage.resetFinalService();
        DateAndTime.extraprice = 0;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // List<String> selectedExtraServices = _selectedExteraCleaning
              //     .map((index) => _exteraCleaning[index][0] as String)
              //     .toList();
              Map<String, int> selectedExtraServices = {};
              for (int index in _selectedExteraCleaning) {
                String serviceName = _exteraCleaning[index][0] as String;
                int servicePrice =
                    int.parse(_exteraCleaning[index][2] as String);
                selectedExtraServices[serviceName] = servicePrice;
                print(selectedExtraServices);
              }

              for (int i = 0;
                  i < selectedExtraServices.values.toList().length;
                  i++) {
                DateAndTime.extraprice +=
                    selectedExtraServices.values.toList()[i];
              }
              SelectedDateTime selectedDateTime = SelectedDateTime(
                _selectedDate,
                _selectedHour,
                selectedExtraServices.keys.toList(),
                _repeat[_selectedRepeat],
                selectedExtraServices.values.toList(),
              );
              DateAndTime.final_date = selectedDateTime;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderSummary(
                    selectedDateTime: selectedDateTime,
                  ),
                ),
              );
            },
            child: Icon(Icons.arrow_forward_ios),
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1,
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                    child: Text(
                      'Select Date and Time',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))
              ];
            },
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border:
                            Border.all(width: 1.5, color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaler: TextScaler.linear(1.0),
                            ),
                            child: CalendarTimeline(
                              // showYears: true,
                              initialDate: _selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 365 * 4)),
                              onDateSelected: (date) =>
                                  setState(() => _selectedDate = date),
                              //leftMargin: 20,
                              monthColor: Color.fromARGB(255, 3, 187, 243),
                              dayColor: Color.fromARGB(255, 3, 187, 243),
                              dayNameColor: const Color(0xFF333A47),
                              activeDayColor:
                                  Color.fromARGB(255, 205, 200, 200),
                              shrink: false,
                              activeBackgroundDayColor: Colors.pink.shade400,
                              dotsColor: Color.fromARGB(255, 68, 44, 81),
                              locale: 'en',
                            ),
                          ),
                          // const SizedBox(height: 20),
                          // Center(
                          //   child: Text(
                          //     'Selected date is $_selectedDate.',
                          //     style: const TextStyle(
                          //         color: Color.fromARGB(255, 32, 180, 165)),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                        1.2,
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                                width: 1.5, color: Colors.grey.shade200),
                          ),
                          child: ScrollablePositionedList.builder(
                              itemScrollController: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: _hours.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedHour = _hours[index];
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: _selectedHour == _hours[index]
                                          ? Colors.pink.shade50.withOpacity(0.5)
                                          : Colors.pink.shade300.withOpacity(0),
                                      border: Border.all(
                                        color: _selectedHour == _hours[index]
                                            ? Colors.pink.shade300
                                            : Colors.white.withOpacity(0),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _hours[index],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        1.2,
                        Text(
                          "Repeat",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _repeat.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedRepeat = index;
                                });
                              },
                              child: FadeAnimation(
                                  (1.2 + index) / 4,
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: _selectedRepeat == index
                                          ? Colors.pink.shade400
                                          : Colors.grey.shade100,
                                    ),
                                    margin: EdgeInsets.only(right: 20),
                                    child: Center(
                                        child: Text(
                                      _repeat[index],
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: _selectedRepeat == index
                                              ? Colors.white
                                              : Colors.grey.shade800),
                                    )),
                                  )),
                            );
                          },
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    FadeAnimation(
                        1.4,
                        Text(
                          "Additional Service",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _exteraCleaning.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_selectedExteraCleaning.contains(index)) {
                                  _selectedExteraCleaning.remove(index);
                                } else {
                                  _selectedExteraCleaning.add(index);
                                }
                              });
                            },
                            child: FadeAnimation(
                              (1.4 + index) / 4,
                              Container(
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: _selectedExteraCleaning.contains(index)
                                      ? Colors.blue.shade400
                                      : Colors.transparent,
                                ),
                                margin: EdgeInsets.only(right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      _exteraCleaning[index][1],
                                      height: 40,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      _exteraCleaning[index][0],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: _selectedExteraCleaning
                                                  .contains(index)
                                              ? Colors.white
                                              : Colors.grey.shade800),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "+Rs.${_exteraCleaning[index][2]}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text("*T&C")
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        '*Terms and Conditions apply.Rate of Extra service may increase depending upon scope of work.')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
