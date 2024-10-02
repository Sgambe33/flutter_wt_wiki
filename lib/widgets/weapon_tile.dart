import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/app_localizations.dart';
import 'package:flutter_wt_wiki/classes/weapon.dart';

import '../classes/ammo.dart';

class WeaponTile extends StatelessWidget {
  final Weapon weapon;
  static const String imagePath = "assets/images/bombs_large.png";

  const WeaponTile({super.key, required this.weapon});

  @override
  Widget build(BuildContext context) {
    if (weapon == null) {
      return ListTile(title: Text(AppLocalizations.of(context).stringBy("weapons", "unknown")), subtitle: Text(AppLocalizations.of(context).stringBy("weapons", "no_data")));
    }

    return ListTile(
        leading: Image.asset(imagePath),
        title: Text('${weapon.count}x ${AppLocalizations.of(context).stringBy("weapons", weapon.name!.toLowerCase())}'),
        subtitle: Text(weapon.weaponType!),
        trailing: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog.fullscreen(
                        child: Scaffold(
                            appBar: AppBar(
                                title: Text(AppLocalizations.of(context).stringBy("weapons", weapon.name!.toLowerCase())),
                                leading: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })),
                            body: SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      const Text("Ammos"),
                                      if (weapon.ammos.isNotEmpty && weapon.ammos.length == 1)
                                        _buildAmmoDetails(context, weapon.ammos[0])
                                      else if (weapon.ammos.isNotEmpty)
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: weapon.ammos.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return _buildAmmoDetails(context, weapon.ammos[index]);
                                            })
                                    ])))));
                  });
            },
            icon: const Icon(Icons.info)));
  }

  Widget _buildAmmoDetails(BuildContext context, Ammo ammo) {
    if (ammo == null) {
      return Text(AppLocalizations.of(context).stringBy("ammo", "no_data"));
    }

    String localize(String category, String key) {
      return AppLocalizations.of(context).stringBy(category, key.toLowerCase());
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (ammo.name != null) Text('Name: ${localize("weapons", ammo.name!)}'),
      Text('Type: ${localize("ammo_types", ammo.type!)}'),
      Text('Caliber: ${(ammo.caliber * 1000).toStringAsFixed(2)} mm'),
      Text('Mass: ${ammo.mass.toStringAsFixed(3)} kg'),
      if (ammo.speed != null) Text('Speed: ${ammo.speed} m/s'),
      if (ammo.maxDistance != null) Text('Max Distance: ${ammo.maxDistance} m'),
      if (ammo.explosiveType != null) Text('Explosive Type: ${localize("explosives", ammo.explosiveType!)}'),
      if (ammo.explosiveMass != null) Text('Explosive Mass: ${ammo.explosiveMass} kg'),
      const Divider()
    ]);
  }
}
