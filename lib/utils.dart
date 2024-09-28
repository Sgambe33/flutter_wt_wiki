String formatBigNumber(num number) {
  return number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
}

String formatDuration(num hours) {
  int totalMinutes = (hours * 60).round();
  int days = totalMinutes ~/ (24 * 60);
  int hoursLeft = (totalMinutes % (24 * 60)) ~/ 60;
  int minutes = totalMinutes % 60;

  String daysStr = days > 0 ? "$days day${days > 1 ? 's' : ''} " : "";
  String hoursStr =
  hoursLeft > 0 ? "$hoursLeft hr${hoursLeft > 1 ? 's' : ''} " : "";
  String minutesStr =
  minutes > 0 ? "$minutes min${minutes > 1 ? 's' : ''}" : "";

  return "$daysStr$hoursStr$minutesStr".trim();
}

String intToRoman(num decimalNumber) {
  switch (decimalNumber) {
    case 1:
      return 'I';
    case 2:
      return 'II';
    case 3:
      return 'III';
    case 4:
      return 'IV';
    case 5:
      return 'V';
    case 6:
      return 'VI';
    case 7:
      return 'VII';
    case 8:
      return 'VIII';
    case 9:
      return 'IX';
    case 10:
      return 'X';
    default:
      return decimalNumber.toString();
  }
}