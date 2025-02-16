import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    bool hidden = false;
    bool addlines = false;
    final valaddlines = TextEditingController();
    final texttcpy = TextEditingController();
    final nbtcpy = TextEditingController();

    void sumbiter(){
      if (addlines && valaddlines.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a value for the number of lines to add for each wrong letter")));
      }
      else if (texttcpy.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a value for the text to type")));
      }
      else if (nbtcpy.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a value for the number of times to type the text")));
      }
      else{
        int valaddLines = addlines ? int.parse(valaddlines.text) : 0;
        Navigator.push(context, 
          MaterialPageRoute(builder: 
           (context) => Typer(totype: texttcpy.text, times: int.parse(nbtcpy.text), hidden: hidden, addlines: addlines, valaddlines: valaddLines)
          )
        );
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Typer punisment"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hide the text:"),


                SizedBox(width: 20),


                Switch(value: hidden, onChanged: (bool value) {
                  setState(() {
                    hidden = value;
                  });
                }),
                SizedBox(width: 80),


                Text("add lines for each wrong letter:"),


                SizedBox(width: 20),


                Switch(value: addlines, onChanged: (bool value) {
                  setState(() {
                    addlines = value;
                  });
                }),


                SizedBox(width: 20,),


                SizedBox(width: 100, child: 
                TextField(
                  controller: valaddlines,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  enabled: addlines,
                  decoration: 
                  InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.add)
                  ),

                )
                ,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center
              ,children: [
                SizedBox(width: 300, child:
                TextField(
                  controller: texttcpy,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Sentence to type",
                  ),
                )),
                SizedBox(width: 20),


                SizedBox(width: 100, child: 
                TextField(
                  controller: nbtcpy,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: 
                  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Number of lines",
                    hintText: "42"
                  ),
                )
                ,),
              ]
            )
            ,SizedBox(height: 20,),
            ElevatedButton(
              onPressed: sumbiter,
              child: Text("Start task"),
            )
          ],
        ),
      ),
    );
  }
}
 class Typer extends StatefulWidget {
  

  const Typer({super.key, required String this.totype, required int this.times, required bool this.hidden, required bool this.addlines, required int this.valaddlines});
  
  final String totype;
  
  final int times;
  
  final bool hidden;
  
  final bool addlines;
  
  final int valaddlines;

  @override
  State<Typer> createState() => _Typer();
}

class _Typer extends State<Typer> {
  late String totype;
  late int times;
  bool en = true;
  late bool hidden;
  late bool addlines;
  late int valaddlines;
  final controler = TextEditingController();
  double progress = 0;

  @override
  void initState() {
    super.initState();
    totype = widget.totype;
    times = widget.times;
    hidden = widget.hidden;
    addlines = widget.addlines;
    valaddlines = widget.valaddlines;
  }
  void checker(String impt){
    if (impt.isNotEmpty){
      if (impt == totype){
        setState(() {
                  times--;
        });
        updateProgress();
        controler.text = "";
        if (times == 0){
          setState(() {
            en = false;
          });
          
        }

      }
      else if (impt[impt.length-1] != totype[impt.length-1]){
        controler.text = "";
        if (addlines){
          setState(() {
            times += valaddlines;
            updateProgress();
          });

        }
      }
    }
  }
  updateProgress(){
    setState(() {
      progress = 1 - times/widget.times;
    });
  }
  _debugsetprogress(double val){
    setState(() {
      progress = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Type"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: 
        Column(
          children: [
            Text("type: \"$totype\" $times times"),
            SizedBox(
              width: 500,
              child: TextField(
                onChanged: checker,
                controller: controler,
                enabled: en,
                obscureText: hidden,
              ),
            ),
          LinearProgressIndicator(
            value: progress,
          ),
          ElevatedButton(onPressed: _debugsetprogress(progress+0.25), child: Text("+")),
          ElevatedButton(onPressed: _debugsetprogress(progress-0.25), child: Text("-")),
          ],
        )
      )
    );
  }
}

