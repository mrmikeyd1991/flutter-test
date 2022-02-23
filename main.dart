import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pipe Grade',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pipe Grade'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  double _result = 0;
  late TextEditingController manholeController;
  late TextEditingController offset1Controller;
  late TextEditingController offset1cutfillController;
  late TextEditingController offset2Controller;
  late TextEditingController offset2cutfillController;
  late TextEditingController distanceController;
  @override
  void initState() {
    manholeController = TextEditingController();
    offset1Controller = TextEditingController();
    offset1cutfillController = TextEditingController();
    offset2Controller = TextEditingController();
    offset2cutfillController = TextEditingController();
    distanceController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                getTextFormFiled(
                    text: 'Manhole shot', controller: manholeController),
                getTextFormFiled(
                    text: '15 offset shot', controller: offset1Controller),
                getTextFormFiled(
                    text: '15 ft Cut/Fill',
                    controller: offset1cutfillController),
                getTextFormFiled(
                    text: '25 ft offet', controller: offset2Controller),
                getTextFormFiled(
                    text: '25 offset cut/fill',
                    controller: offset2cutfillController),
                getTextFormFiled(
                    text: 'Distance', controller: distanceController),
                const SizedBox(height: 20),
                Text.rich(TextSpan(
                    text: 'Your grade Are \t',
                    children: [
                      TextSpan(
                          text: '$_result',
                          style: const TextStyle(fontWeight: FontWeight.bold))
                    ],
                    style: const TextStyle(fontSize: 22))),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)),
                    child: const Text('Calculate',
                        style: TextStyle(fontSize: 20))),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      var offset1results = double.parse(offset1Controller.text) +
          double.parse(offset1cutfillController.text);
      var offset2results = double.parse(offset2Controller.text) +
          double.parse(offset2cutfillController.text);
      var midNumber = (offset1results + offset2results) / 2;
      var result = (double.parse(manholeController.text) - midNumber) /
          double.parse(distanceController.text);
      setState(() {
        _result = result;
      });
    }
  }

  Widget getTextFormFiled(
          {required TextEditingController controller, required String text}) =>
      TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) =>
            val != null && val.isNotEmpty && double.tryParse(val) != null
                ? null
                : "Wrong value",
        decoration: InputDecoration(
          labelText: text,
        ),
      );
}
