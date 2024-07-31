int calculateReadingTime(String content) => content.split(RegExp(r'\s+')).length ~/ 200;
