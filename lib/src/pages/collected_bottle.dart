import 'package:flutter/material.dart';
import '../../providers/bottles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/route_argument.dart';

class CollectedBottle extends StatefulWidget {
  final RouteArgument routeArgument;
  CollectedBottle({Key key, this.routeArgument}) : super(key: key);

  @override
  State<CollectedBottle> createState() => _CollectedBottleState();
}

class _CollectedBottleState extends State<CollectedBottle> {
  // getCollectedBottles() async{
  //   String url = IConstants.API_PATH + 'get-bottle-details';
  //   SharedPreferences  prefs = await SharedPreferences.getInstance();
  //   try {
  //     final response = await http
  //         .post(url,
  //         body: {
  //           'user_id': prefs.get("id")
  //         });
  //     final responseJson = json.decode(response.body);
  //     if (responseJson.toString() == "[]") {} else {
  //       print('....get-bottle-details.... response.........');
  //       print(responseJson.toString());
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  String formatTime(TimeOfDay selectedTime) {
    DateTime tempDate = DateFormat.Hms().parse(selectedTime.hour.toString() +
        ":" +
        selectedTime.minute.toString() +
        ":" +
        '0' +
        ":" +
        '0');
    var dateFormat = DateFormat("h:mm a");
    return (dateFormat.format(tempDate));
  }

  @override
  Widget build(BuildContext context) {
    final bottles = Provider.of<Bottles>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 1,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios,
                  color: /*Theme.of(context).hintColor*/ Colors.white),
              onPressed: () => Navigator.of(context).pop()),
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Collected Bottle',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true),
      body: (Provider.of<Bottles>(context, listen: false).collectedBottles == 0)
          ? Center(child: Text('There are no collected Bottles'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text('Collected Bottle',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Spacer(),
                          Text(bottles.collectedBottles,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(width: 24),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Bottle collection details'),
                  SizedBox(height: 10),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: bottles.customerDetails.length,
                      itemBuilder: (BuildContext context, index) {
                        return bottles.customerDetails.isEmpty
                            ? Container()
                            : Card(
                                elevation: 4,
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                bottom: 8,
                                                top: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bottles.customerDetails[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(height: 10),
                                                Text(bottles
                                                    .customerDetails[index]
                                                        ['received_date']
                                                    .replaceAll(' ', ' | ')),
                                              ],
                                            ))
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                        bottles.customerDetails[index]
                                            ['bottles'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 16)),
                                    SizedBox(width: 24),
                                  ],
                                ),
                              );
                      })
                ],
              ),
            ),
    );
  }
}
