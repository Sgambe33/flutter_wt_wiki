import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/app_localizations.dart';
import 'package:flutter_wt_wiki/screens/vehicle_screen.dart';

class RequiredTile extends StatelessWidget {
  final String requiredVehicle;

  const RequiredTile({super.key, required this.requiredVehicle});

  String _buildVehicleImageUrl(String vehicle) {
    return "https://wtvehiclesapi.sgambe.serv00.net/assets/techtrees/${vehicle.toLowerCase()}.png";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VehicleScreen(vehicleIdentifier: requiredVehicle)));
        },
        child: Card(
            elevation: 4.0,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: ListTile(
              title: const Text("Required Vehicle:"),
              subtitle: Text(AppLocalizations.of(context).stringBy('vehicles', "${requiredVehicle.toLowerCase()}_short")),
              leading: Image.network(_buildVehicleImageUrl(requiredVehicle), width: 50),
              trailing: const Icon(Icons.arrow_forward),
            )));
  }
}
