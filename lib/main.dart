import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'view_model.dart';
import 'package:testim_view/feedback.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red),
      home: DataFromAPI(),
    );
  }
}

class DataFromAPI extends StatefulWidget {
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  Future getTestimonialData() async {
    var response = await http.get(Uri.http('gbv-beta.herokuapp.com', '/get/'));
    var jsonData = jsonDecode(response.body);
    List<testimonial> users = [];

    for (var u in jsonData) {
      testimonial user = testimonial(u["user"], u["testimonial_descr"],
          u["testimonial_id"], u["testimonial_date"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Testimonials'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: FutureBuilder(
            future: getTestimonialData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('No Data Found'),
                  ),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, int i) {
                      var checkStatus;
                      return RefreshIndicator(
                        onRefresh: getTestimonialData,
                        child: Column(children: [
                          Text(
                            "Testimonial id : " +
                                snapshot.data[i].testimonial_id.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "User : " + snapshot.data[i].user,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                              "Testimonial description : " +
                                  snapshot.data[i].testimonial_descr,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center),
                          Text(
                            "Testimonial date : " +
                                snapshot.data[i].testimonial_date,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(children: [
                            TextButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  alignment: Alignment.bottomLeft),
                              onPressed: () async {
                                DataModel? data = await (checkStatus);

                                print('testimony accepted');
                              },
                              child: Text('ACCEPT'),
                            ),
                            TextButton(
                              // value: value,
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  alignment: Alignment.centerRight),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FeedbackDialog()));
                                print('testimony declined');
                              },
                              child: Text('DECLINE'),
                            ),
                          ]),
                          Column(children: [
                            Text(
                              "---------------------------------------------------------------------------------------------"
                              "                                                                                             ",
                            ),
                          ]),
                        ]),
                      );
                    });
            },
          ),
        ),
      ),
    );
  }
}

class testimonial {
  final String user, testimonial_descr, testimonial_date;
  final int testimonial_id;
  testimonial(this.user, this.testimonial_descr, this.testimonial_id,
      this.testimonial_date);
}
