import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: 'Tip Calculator', home: TipCalculator()));
}

class TipCalculator extends StatelessWidget {
  double billAmount = 0.0;
  double tipPercentage = 0.0;


  @override
  Widget build(BuildContext context) {

    void myPopBillTip(String val){
      // Generate dialog
      String currentVal = (val == "Bill") ? "Bill": "Tip";
      AlertDialog dialog =  AlertDialog(
        content: Text("Hye! Empty $currentVal. \n"
            "Add Your $currentVal to Proceed.",
            style: TextStyle(
              fontWeight: FontWeight.w600, // light// italic
              fontSize: 30.0,))
        ,actions: [
        TextButton(child: const Text('Dismiss'),
          onPressed: () { Navigator.pop(context); // Close the dialog
          },),],);

      // Show dialog
      showDialog(context: context, builder: (BuildContext context) => dialog);
    }

    void myPopVoid(){
      // Generate dialog
      AlertDialog dialog =  AlertDialog(
        content: const Text("Hye! Empty Bill. \n"
            "Add Your Bill to Proceed.",
            style: TextStyle(
              fontWeight: FontWeight.w600, // light// italic
              fontSize: 30.0,))
        ,actions: [
        TextButton(child: const Text('Dismiss'),
          onPressed: () { Navigator.pop(context); // Close the dialog
          },),],);

      // Show dialog
      showDialog(context: context, builder: (BuildContext context) => dialog);
    }
    void myPop(){
      // Generate dialog
      AlertDialog dialog =  AlertDialog(
          content: const Text("Hye There, Hyper! \n"
              "Your Bill Will Be Ready In A Moment..",
            style: TextStyle(
              fontWeight: FontWeight.w600, // light// italic
              fontSize: 30.0,))
          ,actions: [
      TextButton(child: const Text('Close'),
        onPressed: () { Navigator.pop(context); // Close the dialog
      },),],);

      // Show dialog
      showDialog(context: context, builder: (BuildContext context) => dialog);
    }

    // Hierarchy of Widgets
    Container h1 = Container(margin: const EdgeInsets.only(top: 15, bottom: 10),
      height: 45,
      child: const Text("Fill your Input to Calculate your Final Bill",
        style: TextStyle(color: Colors.lightGreenAccent,
            fontSize: 35),),
    );

    // Create first input field
    TextField billAmountField = TextField(

      keyboardType: TextInputType.number,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35),
      onChanged: (String value) {
        try {
          billAmount = double.parse(value);
        } catch (exception) {
          billAmount = 0.0;
        }
      },
      decoration: const InputDecoration(labelText: "Your Bill Amount(\$)"),
    );

    // Create another input field
    TextField tipPercentageField = TextField(
        decoration: const InputDecoration(labelText: "Add Tip In Percentage%", hintText: "15"),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70, fontSize: 25),
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
      style: TextStyle(color: Colors.white,
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
          if(billAmount == 0 && tipPercentage == 0){
            // pop Add value
            myPopVoid();
          }
          else if(billAmount == 0){
            // pop Add value
            myPopBillTip("Bill");
          }
          else if(tipPercentage == 0){
            // pop Add value
            myPopBillTip("Tip");
          }
          else{
            // run Ops
            // Calculate tip and total
            double calculatedTip = billAmount * tipPercentage / 100.0;
            double total = billAmount + calculatedTip;

            myPop();
            Future.delayed(Duration(seconds: 7), () {
              print('Delayed code executed');
              // Generate dialog
              AlertDialog dialog = AlertDialog(
                  content: Text("Hye Again, Here You Go..\n"
                      "Tip: \$$calculatedTip \n"
                      "The Total Bal: \$$total",
                    style: const TextStyle(
                      fontWeight: FontWeight.w300, // light
                      fontStyle: FontStyle.italic, // italic
                      fontSize: 50.0,
                    ),));

              // Show dialog
              showDialog(context: context, builder: (BuildContext context) => dialog);
            });
            Future.delayed(Duration(seconds: 15), (){
              final snackBar = SnackBar(
                content: const Text('Yay! That was fantastic!'),
                action: SnackBarAction(
                  label: 'Dismiss',
                  onPressed: () {
                    // Some code to undo the change.
                    print("Dismiss the snack");
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },);
          }


        });
    Container cY = Container(margin: const EdgeInsets.only(top: 75, bottom: 20),
      height: 50,
    );
    FloatingActionButton fActionButton = FloatingActionButton(
      // When the user presses the button, show an alert dialog containing
      // the text that the user has entered into the text field.
      onPressed: () {
        double calculatedTip = billAmount * tipPercentage / 100.0;
        double total = billAmount + calculatedTip;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // Retrieve the text the that user has entered by using the
              // TextEditingController.
              content: Text("Tip: \$$calculatedTip \n"
                  "Total: \$$total"),
            );
          },
        );
      },
      tooltip: 'Show me the value!',
      child: const Icon(Icons.text_fields),
    );

    // final snackBar = SnackBar(
    //   content: const Text('Yay! That was fantastic!'),
    //   action: SnackBarAction(
    //     label: 'Dismiss',
    //     onPressed: () {
    //       // Some code to undo the change.
    //       print("Dismiss the snack");
    //     },
    //   ),
    // );

    Container container = Container(
      color: Colors.redAccent,
        padding: const EdgeInsets.all(16.0),
        child:
            SingleChildScrollView(child: Column(
                children: [h1, billAmountField, tipPercentageField, cX, calculateButton,cY, fActionButton, cY])
            ));


    AppBar appBar = AppBar(title: const Text("The GO-TIP"));

    Scaffold scaffold = Scaffold(appBar: appBar, body: container);
    return scaffold;
  }
}