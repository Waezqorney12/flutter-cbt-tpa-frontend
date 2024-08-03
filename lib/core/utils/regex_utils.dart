int calculateReadingTime(String content) => content.split(RegExp(r'\s+')).length ~/ 200;
String nameEmail(String email) => email.split(RegExp(r'@')).first;
