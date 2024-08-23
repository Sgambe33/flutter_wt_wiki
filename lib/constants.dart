import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Constants {
  static const Map<String, String> COUNTRY_TO_FLAG_MAP = {
    'ussr': 'assets/images/country_ussr_big.png',
    'usa': 'assets/images/country_usa_big.png',
    'germany': 'assets/images/country_germany_big.png',
    'britain': 'assets/images/country_usa_britain.png',
    'japan': 'assets/images/country_japan_big.png',
    'china': 'assets/images/country_china_big.png',
    'france': 'assets/images/country_france_big.png',
    'italy': 'assets/images/country_italy_kingdom_big.png',
    'sweden': 'assets/images/country_sweden_big.png',
    'israel': 'assets/images/country_israel_big.png'
  };

  static const Map<String, String> COUNTRY_TO_SHORT_MAP = {
    'ussr': 'RUS',
    'usa': 'USA',
    'germany': 'GER',
    'britain': 'UK',
    'japan': 'JPN',
    'china': 'CHN',
    'france': 'FRA',
    'italy': 'ITA',
    'sweden': 'SWE',
    'israel': 'ISR'
  };
}