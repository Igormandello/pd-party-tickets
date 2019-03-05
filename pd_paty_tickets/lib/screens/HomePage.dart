import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _peopleCounter = 0;

  void _addPerson() {
    setState(() {
      _peopleCounter++;
    });
  }

  Future _scan() async {
    String str = await BarcodeScanner.scan();
    print(str);
    this._addPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Column(
              children: <Widget>[
                Text(
                    'So far',
                    style: Theme.of(context).textTheme.headline
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6, bottom: 12),
                  child: Text(
                      '${_peopleCounter == 0 ? 'no one' : '$_peopleCounter ${_peopleCounter == 1 ? 'person' : 'people'}'}',
                      style: Theme.of(context).textTheme.display2
                  ),
                ),
                Text(
                    '${_peopleCounter == 0 ? 'is in the party =(' : '${_peopleCounter == 1 ? 'is' : 'are'} in the party =)'}',
                    style: Theme.of(context).textTheme.headline
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
            ),
            Text(
              'Click the button bellow to Scan a ticket.',
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _scan,
        label: Text('Scan QR Code'),
        icon: Icon(Icons.camera)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
