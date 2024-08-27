class Constants {
  static const Map<String, String> COUNTRY_TO_FLAG_MAP = {
    'ussr': 'assets/images/country_ussr_big.png',
    'usa': 'assets/images/country_usa_big.png',
    'germany': 'assets/images/country_germany_big.png',
    'britain': 'assets/images/country_britain_big.png',
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

  static const Map<String, String> COUNTRY_TO_COUNTRY_NAME = {
    'ussr': 'Russia',
    'usa': 'United States',
    'germany': 'Germany',
    'britain': 'United Kingdom',
    'japan': 'Japan',
    'china': 'China',
    'france': 'France',
    'italy': 'Italy',
    'sweden': 'Sweden',
    'israel': 'Israel'
  };

  static const Map<String, String> TYPE_TO_TYPE_NAME = {
    'light_tank': 'Light Tank',
    'medium_tank': 'Medium Tank',
    'heavy_tank': 'Heavy Tank',
    'spaa': 'SPAA',
    'tank_destroyer': 'Tank Destroyer',
    'boat': 'Boat',
    'destroyer': 'Destroyer',
    'battleship': 'Battleship',
    'battlecruiser': 'Battlecruiser',
    'frigate': 'Frigate',
    'heavy_cruiser': 'Heavy Cruiser',
    'heavy_boat': 'Heavy Boat',
    'light_cruiser': 'Light Cruiser',
    'barge': 'Barge',
    "assault": "Attacker",
    "attack_helicopter": "Attack Helicopter",
    "utility_helicopter": "Utility Helicopter",
    "bomber": "Bomber",
    "fighter": "Fighter",
  };

  static const Map<String, String> VEHICLE_TYPE_TO_ICON = {
    //GROUND
    "light_tank": "┪",
    "medium_tank": "┬",
    "heavy_tank": "┨",
    "spaa": "┰",
    "tank_destroyer": "┴",
    //FLEET
    "battleship": "␑",
    "battlecruiser": "␐",
    "destroyer": "␌",
    "frigate": "␊",
    "heavy_cruiser": "␏",
    "light_cruiser": "␎",
    "heavy_boat": "␊",
    "boat": "␉",
    "barge": "␋",
    //AVIATION
    "assault": "┞",
    "attack_helicopter": "┞",
    "utility_helicopter": "┠",
    "bomber": "┠",
    "fighter": "┤",
  };

  static const List<String> FLEET_VEHICLE_TYPES = [
    'boat',
    'destroyer',
    'battleship',
    'battlecruiser',
    'frigate',
    'heavy_cruiser',
    'heavy_boat',
    'light_cruiser',
    'barge'
  ];

  static const List<String> GROUND_VEHICLE_TYPES = ['heavy_tank', 'light_tank', 'medium_tank', 'spaa', 'tank_destroyer'];

  static const List<String> AVIATION_VEHICLE_TYPES = ['assault', 'attack_helicopter', 'fighter', 'bomber', 'utility_helicopter'];
}
