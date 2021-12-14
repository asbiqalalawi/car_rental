import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frent/data/rent_entity.dart';
import 'package:frent/detail_screen.dart';
import 'package:http/http.dart' as http;

// var rentEntity = [
//   RentEntity(
//       imageAsset: 'images/daihatsu-grand-xenia.webp',
//       name: 'Daihatsu Grand Xenia',
//       price: '200.000',
//       rating: '4.8',
//       specification:
//           'Daihatsu Grand Xenia is available in a choice of Petrol engines in Indonesia. The new MPV from Daihatsu comes in 20 variants. Talking about the specifications of the Daihatsu Grand Xenia engine, it is powered by two choices of Gasoline engines with a capacity of 1496 cc. Grand Xenia is available with Manual and Automatic transmissions depending on the variant. Grand Xenia is a 7 seater MPV with a length of 4190 mm, width 1660 mm, wheelbase 2655 mm. and 200 mm ground clearance.'),
// ];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RentEntity> rents;

  fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.43.95:8000/api/rent'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      rents = [];
      if (!mounted) return;
      setState(() {
        for (Map<String, dynamic> i in data) {
          rents.add(RentEntity.fromJson(i));
        }
      });
      print(rents[0].name);
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.car_rental,
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.grey,
        title: Text(
          'PEMINJAMAN MOBIL',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: rents == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('11 Mobil untuk di sewakan'),
                        Row(
                          children: [],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                    itemCount: rents.length,
                    itemBuilder: (context, index) => FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailScreen(rentEntity: rents[index]);
                        }));
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6.0),
                                  topRight: Radius.circular(6.0)),
                              child: Image.asset(
                                rents[index].imageAsset,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        rents[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\RP' + rents[index].price + '/day',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        rents[index].rating,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              padding: EdgeInsets.all(6),
                                              color: Colors.greenAccent,
                                              child: Text(
                                                'Free Delivery',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              padding: EdgeInsets.all(6),
                                              color: Colors.red[200],
                                              child: Text(
                                                'Instant Booking',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Bookmark()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  bool isBookmark = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isBookmark ? Icons.bookmark : Icons.bookmark_border),
      onPressed: () {
        setState(() {
          isBookmark = !isBookmark;
        });
      },
    );
  }
}
