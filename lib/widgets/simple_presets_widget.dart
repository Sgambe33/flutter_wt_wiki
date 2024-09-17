import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/widgets/weapon_tile.dart';

class SimplePresetsWidget extends StatefulWidget {
  final List<dynamic> presets;
  const SimplePresetsWidget({super.key, required this.presets});

  @override
  _SimplePresetsWidgetState createState() => _SimplePresetsWidgetState();
}

class _SimplePresetsWidgetState extends State<SimplePresetsWidget> {
  late List<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = List<bool>.filled(widget.presets.length, false);
  }

  List<ExpansionPanel> _buildExpansionPanels() {
    return List<ExpansionPanel>.generate(
      widget.presets.length,
      (int index) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text('Preset ${index + 1}'),
            );
          },
          body: Column(
            children: List<WeaponTile>.generate(
              widget.presets[index]["weapons"].length,
              (int i) {
                return WeaponTile(weapon: widget.presets[index]["weapons"][i]);
              },
            ),
          ),
          isExpanded: _isExpanded[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Set a fixed height for the ExpansionPanelList
      child: ListView(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded[index] = isExpanded;
                for (int i = 0; i < _isExpanded.length; i++) {
                  if (i != index) {
                    _isExpanded[i] = false;
                  }
                }
              });
            },
            children: _buildExpansionPanels(),
          ),
        ],
      ),
    );
  }
}
