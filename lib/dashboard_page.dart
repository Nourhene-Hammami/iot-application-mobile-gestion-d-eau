import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorDataPage extends StatefulWidget {
  @override
  _SensorDataPageState createState() => _SensorDataPageState();
}

class _SensorDataPageState extends State<SensorDataPage> {
  DatabaseReference _databaseReference =  FirebaseDatabase.instance.reference();

  Map<String, dynamic> _sensorData = {
    'humidity': 0.0,
    'temperature': 0.0,
    'waterLevel': 0.0,
    'ph': 0.0,
    'turbidity': 0.0,
  };

  String _selectedSensor = 'humidity'; // Initial selected sensor

  @override
  void initState() {
    super.initState();
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        dynamic values = event.snapshot.value;
        if (values is Map<dynamic, dynamic>) {
          setState(() {
            _sensorData = Map<String, dynamic>.from(values);
          });
        }
      }
    });
  }

  // Function to interpret sensor values
  Widget interpretSensorValueWithColor(String sensorName, double value) {
    String interpretation = '';
    Color backgroundColor = Colors.transparent; // Valeur par défaut

    if (sensorName == 'humidity') {
      if (value < 30) {
        interpretation = 'Dry';
        backgroundColor = Colors.blue[200]!; // Couleur correspondante
      } else if (value >= 30 && value <= 70) {
        interpretation = 'Normal';
        backgroundColor = Colors.green[200]!; // Couleur correspondante
      } else {
        interpretation = 'Humid';
        backgroundColor = Colors.red[200]!; // Couleur correspondante
      }
    } else if (sensorName == 'temperature') {
      if (value < 10) {
        interpretation = 'Cold';
        backgroundColor = Colors.blue[200]!; // Couleur correspondante
      } else if (value >= 10 && value <= 30) {
        interpretation = 'Moderate';
        backgroundColor = Colors.green[200]!; // Couleur correspondante
      } else {
        interpretation = 'Hot';
        backgroundColor = Colors.red[200]!; // Couleur correspondante
      }
    } else if (sensorName == 'turbidity') {
      if (value < 5) {
        interpretation = 'Low';
        backgroundColor = Colors.blue[200]!; // Couleur correspondante
      } else if (value >= 5 && value <= 15) {
        interpretation = 'Medium';
        backgroundColor = Colors.green[200]!; // Couleur correspondante
      } else {
        interpretation = 'High';
        backgroundColor = Colors.red[200]!; // Couleur correspondante
      }
    } else if (sensorName == 'ph') {
      if (value < 7) {
        interpretation = 'Acidic';
        backgroundColor = Colors.blue[200]!; // Couleur correspondante
      } else if (value == 7) {
        interpretation = 'Neutral';
        backgroundColor = Colors.green[200]!; // Couleur correspondante
      } else {
        interpretation = 'Alkaline';
        backgroundColor = Colors.red[200]!; // Couleur correspondante
      }
    } else if (sensorName == 'waterLevel') {
      if (value < 3) {
        interpretation = 'Low';
        backgroundColor = Colors.blue[200]!; // Couleur correspondante
      } else if (value >= 3 && value <= 7) {
        interpretation = 'Medium';
        backgroundColor = Colors.green[200]!; // Couleur correspondante
      } else {
        interpretation = 'High';
        backgroundColor = Colors.red[200]!; // Couleur correspondante
      }
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      color: backgroundColor, // Utilisation de la couleur correctement initialisée
      child: Text(
        interpretation,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black, // Vous pouvez ajuster la couleur du texte en fonction de la couleur de fond
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Data'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Sensor Filters',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.opacity), // Icône pour l'humidité
              title: Text('Humidity'),
              onTap: () {
                setState(() {
                  _selectedSensor = 'humidity';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.thermostat), // Icône pour la température
              title: Text('Temperature'),
              onTap: () {
                setState(() {
                  _selectedSensor = 'temperature';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.waves), // Icône pour le niveau d'eau
              title: Text('Water Level'),
              onTap: () {
                setState(() {
                  _selectedSensor = 'waterLevel';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.phonelink_lock), // Icône pour le pH
              title: Text('pH'),
              onTap: () {
                setState(() {
                  _selectedSensor = 'ph';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.opacity_outlined), // Icône pour la turbidité
              title: Text('Turbidity'),
              onTap: () {
                setState(() {
                  _selectedSensor = 'turbidity';
                });
                Navigator.pop(context);
              },
            ),
         
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_selectedSensor != 'interpretation') // Afficher seulement si le capteur sélectionné n'est pas "Interpretation"
              Column(
                children: [
                  Text('Selected Sensor: $_selectedSensor'),
                  Text(
                    'Value: ${_sensorData[_selectedSensor]}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            Text(
              'Interpretation: ',
              style: TextStyle(fontSize: 20),
            ),
            interpretSensorValueWithColor(_selectedSensor, _sensorData[_selectedSensor]),
          ],
        ),
      ),
    );
  }
}







