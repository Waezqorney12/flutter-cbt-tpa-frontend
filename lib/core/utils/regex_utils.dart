int calculateReadingTime(String content) {
  int readingTime = content.split(RegExp(r'\s+')).length ~/ 200;
  return readingTime == 0 ? 1 : readingTime;
}

String nameEmail(String email) => email.split(RegExp(r'@')).first;

int calculateTotalReadingTime<T>(List<T> contents) {
  int totalReadingTime = 0;
  for (String content in contents as List) {
    totalReadingTime += calculateReadingTime(content);
  }
  return totalReadingTime;
}
