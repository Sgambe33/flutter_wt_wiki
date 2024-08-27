import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/AppLocalisations.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<dynamic> _searchResults = [];
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 2), () {
      if (_searchController.text.length >= 3) {
        _search(_searchController.text);
      } else {
        setState(() {
          _searchResults.clear();
        });
      }
    });
  }

  Future<void> _search(String query) async {
    final response = await http.get(Uri.parse('https://wtvehiclesapi.sgambe.serv00.net/api/vehicles/search/$query'));
    if (response.statusCode == 200) {
      setState(() {
        _searchResults.clear();
        final List<dynamic> results = json.decode(response.body);
        _searchResults.addAll(results.take(15));
      });
    } else {
      throw Exception('Failed to search');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            autofocus: true,
            controller: _searchController,
            onChanged: (text) => _onSearchChanged(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  _searchController.clear();
                },
              ),
              hintText: 'Search...',
              hintStyle: const TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 70, // Set the desired width here
                    child: Image.network(
                      "https://wtvehiclesapi.sgambe.serv00.net/assets/techtrees/${_searchResults[index].toLowerCase()}.png",
                      errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/uknown.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(AppLocalizations.of(context).stringBy('vehicles', _searchResults[index].toLowerCase() + '_short')),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/vehicle', arguments: _searchResults[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
