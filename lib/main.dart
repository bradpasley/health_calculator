import 'package:flutter/material.dart';
//import 'package:ads/ads.dart';

final double titleFontSize = 30;
final double normalFontSize = 25;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Energy Conversion Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double _calories = 0.0;
  double _kilojoules = 0.0;
  final double _energyConverstionConstant = 4.184;

  final _calculatorFormKey = GlobalKey<FormState>();
  final _caloryFormKey = GlobalKey<FormFieldState>();
  final _kilojouleFormKey = GlobalKey<FormFieldState>();

  final _caloryTextController = TextEditingController();
  final _kilojouleTextController = TextEditingController();

  void _convertCaloriesToKilojoules() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _kilojoules = _calories*_energyConverstionConstant;
      _kilojouleTextController.text = _kilojoules.toStringAsFixed(3);
    });
  }

  void _convertKilojoulesToCalories() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _calories = _kilojoules/_energyConverstionConstant;
      _caloryTextController.text = _calories.toStringAsFixed(3);
    });
  }

  @override
  void initState() {
    super.initState();
    _caloryTextController.addListener(_printCalories);
    _kilojouleTextController.addListener(_printKilojoules);
  }

  @override
  void dispose() {
    _caloryTextController.dispose();
    _kilojouleTextController.dispose();
    super.dispose();
  }

  _printCalories() {
    print('$_calories');
  }

  _printKilojoules() {
    print('$_kilojoules');
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
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(10)),
            Text('Energy Calculator', style: TextStyle(fontSize: titleFontSize), textAlign: TextAlign.center, ),
            Form(
                key: _calculatorFormKey,
                child:
                ListView(
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  //crossAxisSpacing: 10,
                  //mainAxisSpacing: 10,
                  //crossAxisCount: 1,

                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text('Calories'),
                      color: Colors.teal[100],
                    ),
                    TextFormField(
                        key: _caloryFormKey,
                        controller: _caloryTextController,
                        autovalidate: true,
                        onTap: () {
                          this.setState(() {_caloryTextController.clear();});
                        },
                        keyboardType: TextInputType.number,
                        validator: (input) {
                          final isDigitsOnly = double.tryParse(input);
                          if (isDigitsOnly == null) {
                            return 'Enter number';
                          } else {
                            _calories = double.parse(input);
                            //_convertCaloriesToKilojoules();
                            return null;
                          }
                        },
                        onEditingComplete: _convertCaloriesToKilojoules,
                        onChanged: (v)=>setState((){_kilojouleTextController.value.copyWith(text: '$_kilojoules');})


                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text('Kilojoules'),
                      color: Colors.teal[300],
                    ),
                    TextFormField(
                      key: _kilojouleFormKey,
                      controller: _kilojouleTextController,
                      autovalidate: true,
                      onTap: () {
                        this.setState(() {_kilojouleTextController.clear();});
                      },
                      //initialValue: '$_kilojoules',
                      keyboardType: TextInputType.number,
                      validator: (input) {
                        final isDigitsOnly = double.tryParse(input);
                        if (isDigitsOnly == null) {
                          return 'Enter a number';
                        } else {
                          _kilojoules = double.parse(input);
                          //_convertKilojoulesToCalories();
                          return null;
                        }
                      },
                      onEditingComplete: _convertKilojoulesToCalories,
                    ),

                  ],
                )
            ),
            Text('Ad goes here', style: TextStyle(fontSize: normalFontSize)),


          ],
        )
    );

  }
}
