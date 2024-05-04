String formatNumber(int number) {
  String formattedNumber = number.toString();
  if (formattedNumber.length <= 3) {
    return formattedNumber;
  } else {
    String result = '';
    int count = 0;
    for (int i = formattedNumber.length - 1; i >= 0; i--) {
      count++;
      result = formattedNumber[i] + result;
      if (count % 3 == 0 && i != 0) {
        result = '.$result';
      }
    }
    return result;
  }
}
