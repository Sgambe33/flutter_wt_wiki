import 'package:flutter/material.dart';

class VehicleVersionDialog extends StatefulWidget {
  final List<dynamic> versions;
  const VehicleVersionDialog({super.key, required this.versions});

  @override
  _VehicleVersionDialogState createState() => _VehicleVersionDialogState();

  static void show(BuildContext context, List<dynamic> versions) {
    showDialog(
      context: context,
      builder: (context) => VehicleVersionDialog(versions: versions),
    );
  }
}

class _VehicleVersionDialogState extends State<VehicleVersionDialog> {
  dynamic _selectedVersion;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Versions:"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final version in widget.versions)
            RadioListTile(
              title: Text(version),
              value: version,
              groupValue: _selectedVersion,
              selected: _selectedVersion == version,
              onChanged: (value) {
                setState(() {
                  _selectedVersion = value;
                });
              },
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
