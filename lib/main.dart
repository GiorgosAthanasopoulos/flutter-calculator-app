import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
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
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String display = "";
  String memory = "";
  static const buttonTextStyle = TextStyle(fontSize: 16);
  static const displayTextStyle = TextStyle(fontSize: 40);

  String hasOperator(String input) {
    if (input.contains("+")) {
      return "+";
    } else if (input.contains("-") && !input.startsWith("-")) {
      return "-";
    } else if (input.contains("*")) {
      return "*";
    } else if (input.contains("/")) {
      return "/";
    } else if (input.contains("%")) {
      return "%";
    } else if (input.contains("^")) {
      return "^";
    } else {
      return "";
    }
  }

  String clearAfterOperator(String input) {
    String op = hasOperator(input);
    if (op == "") {
      return input;
    } else {
      return input.substring(0, input.indexOf(op));
    }
  }

  String replaceAfterOperator(String input, String replace) {
    String op = hasOperator(input);
    if (op == "") {
      return input;
    } else {
      return input.substring(0, input.indexOf(op)) + op + replace;
    }
  }

  String valueAfterOperator(String input) {
    String op = hasOperator(input);
    if (op == "") {
      return "";
    } else {
      return input.substring(input.indexOf(op) + 1);
    }
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
        title: Text(widget.title),
      ),
      body:
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //
        // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        // action in the IDE, or press "p" in the console), to see the
        // wireframe for each widget.
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: IntrinsicHeight(
                        child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        // decoration: InputDecoration(hintText: '0'),
                        // style: TextStyle(fontSize: 30),
                        readOnly: true,
                        enableInteractiveSelection: false,
                        showCursor: false,
                        textAlign: TextAlign.right,
                        controller: TextEditingController(text: display),
                        style: displayTextStyle,
                      ),
                    )
                  ],
                ))),
                Expanded(
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "";
                                memory = "";
                              });
                            },
                            child: const Text('ON', style: buttonTextStyle)),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (hasOperator(display) != "") {
                                  display = clearAfterOperator(display);
                                } else {
                                  display = "";
                                }
                              });
                            },
                            child: const Text(
                              'C',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                memory = "";
                              });
                            },
                            child: const Text(
                              'MC',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (memory.isNotEmpty) {
                                  if (hasOperator(display) != "") {
                                    display =
                                        replaceAfterOperator(display, memory);
                                  } else {
                                    display = memory;
                                  }
                                }
                              });
                            },
                            child: const Text(
                              'MR',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (hasOperator(display) != "") {
                                  memory = valueAfterOperator(display);
                                } else {
                                  if (display.isNotEmpty) {
                                    memory = display;
                                  }
                                }
                              });
                            },
                            child: const Text(
                              'MS',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (memory.isNotEmpty && display.isNotEmpty) {
                                  if (hasOperator(display) != "") {
                                    memory = (double.parse(memory) +
                                            double.parse(
                                                valueAfterOperator(display)))
                                        .toString();
                                  } else {
                                    memory = (double.parse(memory) +
                                            double.parse(display))
                                        .toString();
                                  }
                                }
                              });
                            },
                            child: const Text(
                              'M+',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (memory.isNotEmpty && display.isNotEmpty) {
                                  if (hasOperator(display) != "") {
                                    memory = (double.parse(memory) -
                                            double.parse(
                                                valueAfterOperator(display)))
                                        .toString();
                                  } else {
                                    memory = (double.parse(memory) -
                                            double.parse(display))
                                        .toString();
                                  }
                                }
                              });
                            },
                            child: const Text(
                              'M-',
                              style: buttonTextStyle,
                            )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}7";
                              });
                            },
                            child: const Text(
                              '7',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}8";
                              });
                            },
                            child: const Text(
                              '8',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}9";
                              });
                            },
                            child: const Text(
                              '9',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display = "$display+";
                                }
                              });
                            },
                            child: const Text(
                              '+',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display = (pow(double.parse(display), 2))
                                      .toString();
                                }
                              });
                            },
                            child: const Text(
                              '^2',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display =
                                      (sin(double.parse(display))).toString();
                                }
                              });
                            },
                            child: const Text(
                              'sin',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display = "$display%";
                                }
                              });
                            },
                            child: const Text(
                              '%',
                              style: buttonTextStyle,
                            )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}4";
                              });
                            },
                            child: const Text(
                              '4',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}5";
                              });
                            },
                            child: const Text(
                              '5',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}6";
                              });
                            },
                            child: const Text(
                              '6',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display = "$display-";
                                }
                              });
                            },
                            child: const Text(
                              '-',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display = (pow(double.parse(display), 3))
                                      .toString();
                                }
                              });
                            },
                            child: const Text(
                              '^3',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display =
                                      (cos(double.parse(display))).toString();
                                }
                              });
                            },
                            child: const Text(
                              'cos',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display =
                                      (sqrt(double.parse(display))).toString();
                                }
                              });
                            },
                            child: const Text(
                              'sqrt',
                              style: buttonTextStyle,
                            )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}1";
                              });
                            },
                            child: const Text(
                              '1',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}2";
                              });
                            },
                            child: const Text(
                              '2',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}3";
                              });
                            },
                            child: const Text(
                              '3',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display = "$display*";
                                }
                              });
                            },
                            child: const Text(
                              '*',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display = "$display^";
                                }
                              });
                            },
                            child: const Text(
                              '^y',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display =
                                      (tan(double.parse(display))).toString();
                                }
                              });
                            },
                            child: const Text(
                              'tan',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display =
                                      (1 / double.parse(display)).toString();
                                }
                              });
                            },
                            child: const Text(
                              '1/x',
                              style: buttonTextStyle,
                            )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (!display.endsWith(".")) {
                                  display = "$display.";
                                }
                              });
                            },
                            child: const Text(
                              '.',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                display = "${display}0";
                              });
                            },
                            child: const Text('0', style: buttonTextStyle)),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  if (display.startsWith("-")) {
                                    display = display.replaceFirst("-", "");
                                  } else {
                                    display = "-$display";
                                  }
                                }
                              });
                            },
                            child: const Text(
                              '+/-',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display = "$display/";
                                }
                              });
                            },
                            child: const Text(
                              '/',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display = (pow(10, double.parse(display)))
                                      .toString();
                                }
                              });
                            },
                            child: const Text(
                              '10^x',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (display.isNotEmpty &&
                                    hasOperator(display) == "") {
                                  display =
                                      (log(double.parse(display))).toString();
                                }
                              });
                            },
                            child: const Text(
                              'log',
                              style: buttonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Parser p = Parser();
                                Expression exp = p.parse(display);
                                display = exp
                                    .evaluate(
                                        EvaluationType.REAL, ContextModel())
                                    .toString();
                              });
                            },
                            child: const Text(
                              '=',
                              style: buttonTextStyle,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
