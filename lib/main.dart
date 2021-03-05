import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  TabController tb;
  int hour =0;
  int min = 0;
  int sec =0 ;
  String timetodisplay = " " ;
  bool started = true;
  bool stopped = true;
  int timefortimeup;
  bool canceltimmeup  =false;
  final dur = const Duration(seconds: 1);
  @override
   void init(){
     tb = TabController(length: 2, vsync: this);
     super.initState();
   }

   void start (){
    setState(() {
      started =false;
      stopped = false;
    });
    timefortimeup = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(dur, (Timer t){
      if (timefortimeup < 1 || canceltimmeup == true){
        t.cancel();
      }
      else if(timefortimeup < 60) {
        timetodisplay =timefortimeup.toString();
        timefortimeup =timefortimeup -1;
      }
      else if(timefortimeup <3600){
        int m = timefortimeup ~/ 60;
        int s = timefortimeup - (60 * m);
        timetodisplay = m.toString() + ":" + s.toString();
        timefortimeup = timefortimeup -1;
      }
      else {
        int h = timefortimeup ~/3600;
        int t = timefortimeup - (3600 * h);
        int m = t ~/60;
        int s= t -(60 * m);
        timetodisplay = h.toString() + ":" + m.toString() + ":" + s.toString();
        timefortimeup = timefortimeup -1;
      }
    });
   }

   void stop(){
 started = true;
 stopped =true;
 canceltimmeup =true;
   }
   Widget timer(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      new Text("HH",style: TextStyle(fontWeight: FontWeight.bold),),
                      NumberPicker.integer(initialValue: hour ,
                          minValue: 00,
                          maxValue: 23,
                          listViewWidth: 50.0,
                          onChanged: (val){
                        setState(() {
                          hour = val;
                        });
                          }),
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      new Text("MM",style: TextStyle(fontWeight: FontWeight.bold),),
                      NumberPicker.integer(initialValue: min ,
                          minValue: 00,
                          maxValue: 60,
                          listViewWidth: 50.0,
                          onChanged: (val){
                            setState(() {
                              min = val;
                            });
                          }),
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      new Text("SS",style: TextStyle(fontWeight: FontWeight.bold),),
                      NumberPicker.integer(initialValue: sec ,
                          minValue: 00,
                          maxValue: 60,
                          listViewWidth: 50.0,
                          onChanged: (val){
                            setState(() {
                              sec = val;
                            });
                          }),
                    ],
                  )
                ],
              )),
          Expanded(
            flex: 1,
            child: new Text(timetodisplay) ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: started ? start : null,
                    color: Colors.purpleAccent,
                  child: new Text("Start"),),
                ),
                RaisedButton(onPressed: stopped ? null  : stop,
                  color: Colors.purpleAccent,
                  child: new Text("Stop Watch"),),
              ],
            ),)
        ],
      ),
    );
   }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title:  new Text("Timer"),
          bottom: TabBar(tabs: <Widget>[
            new Text("Timer"),
            new Text("Stop Watch"),
          ],
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20.0
              ),
              labelPadding: EdgeInsets.only(
                bottom: 10.0
              ),
              controller: tb,
          ),
        ),
        body: TabBarView(children: <Widget>[
         timer(),
          new Text("Stop Watch"),
        ],
        controller: tb,),
      ),
    );
  }
}
