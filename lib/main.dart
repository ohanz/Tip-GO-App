import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: 'Tip Calculator', home: TipCalculator()));
}

class TipCalculator extends StatelessWidget {
  double billAmount = 0.0;
  double tipPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    // Create first input field
    TextField billAmountField = TextField(

      keyboardType: TextInputType.number,
      onChanged: (String value) {
        try {
          billAmount = double.parse(value);
        } catch (exception) {
          billAmount = 0.0;
        }
      },
      decoration: const InputDecoration(labelText: "Bill amount(\$)"),
    );

    // Create another input field
    TextField tipPercentageField = TextField(
        decoration: const InputDecoration(labelText: "Tip %", hintText: "15"),
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          try {
            tipPercentage = double.parse(value);
          } catch (exception) {
            tipPercentage = 0.0;
          }
        });

    Container cX = Container(margin: const EdgeInsets.only(top: 25, bottom: 20),
      height: 30,
    child: const Text("Tap Below To Finish",
      style: TextStyle(color: Colors.grey,
          fontSize: 25),),
    );
    // Create button
    ElevatedButton calculateButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0)),
          minimumSize: const Size(300, 60), //////// HERE
        ),
        child: const Text("Calculate", style: TextStyle(fontSize: 25, color: Colors.green),),
        onPressed: () {
          // Calculate tip and total
          double calculatedTip = billAmount * tipPercentage / 100.0;
          double total = billAmount + calculatedTip;

          // Generate dialog
          AlertDialog dialog = AlertDialog(
              content: Text("Tip: \$$calculatedTip \n"
                  "Total: \$$total"));

          // Show dialog
          showDialog(context: context, builder: (BuildContext context) => dialog);
        });

    Container container = Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [billAmountField, tipPercentageField, cX, calculateButton]));

    AppBar appBar = AppBar(title: Text("Tip Calculator"));

    Scaffold scaffold = Scaffold(appBar: appBar, body: container);
    return scaffold;
  }
}