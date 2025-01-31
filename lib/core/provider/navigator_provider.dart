import 'package:flutter/material.dart';

class NavigatorProvider extends InheritedWidget {
  /*
  NavigatorProvider berperan sebagai tempat penyimpanan data yang ingin di share ke widget lain
  dalam kasus ini data yang ingin disimpan yaitu currentIndex oleh karena itu menggunakan extends
  InheritedWidget yang bertujuan untuk melakukan penyebaran pada sub widget tree nya sehingga data dapat diakses oleh widget lain
  */
  final ValueNotifier<int> currentIndex;
  final ValueNotifier<bool> isFirst;

  const NavigatorProvider({
    required this.currentIndex,
    required this.isFirst,
    required super.child,
    super.key,
  });

  /*
  Function ini bertujuan untuk melakukan akses pada widget yang telah dibungkus oleh NavigatorProvider sehingga 
  data yang dibungkus menjadi accessible oleh widget lainnya yang diluar subtree, oleh karena itu context disini
  diambil dari context pada pembungkusan dalam kasus ini context yang diambil yaitu context nya BottomNavigationWidget
  dikarenakan dia dibungkus oleh NavigatorProvider
  */
  static NavigatorProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NavigatorProvider>();
  }

  /*
  function ini bertujuan untuk melakukan update setiap ada perubahan dalam data
  pada kasus ini data yang ingin selalu di update adalah currentIndex setiap terdapat perubahan pada data
  */
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
