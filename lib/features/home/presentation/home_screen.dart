import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_potensial/core/provider/navigator_provider.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:test_potensial/features/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 190,
                decoration: BoxDecoration(
                  color: AppPalette.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello, welcome👋'),
                              Text('Waezqorney Huanfareyzo'),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => NavigatorProvider.of(context)?.isFirst.value = false,
                            child: const Initicon(text: 'Waez'),
                          ),
                        ],
                      ),
                      const Spacer(),
                      TextField(
                        controller: HomeController.searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Beranda',
                  style: TextAppStyle.montserratMedium.copyWith(
                    fontSize: 24,
                  ),
                ),
              ),
              MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: HomeController.contentHome.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => (index % 3 == 0)
                        ? Navigator.push(context, HomeController.routes[index]())
                        : NavigatorProvider.of(context)?.currentIndex.value = HomeController.routesNumber[index],
                    child: Container(
                      height: index % 2 == 0 ? 200 : 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: HomeController.boxColor[index],
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            HomeController.imageHome[index],
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            HomeController.contentHome[index],
                            style: TextAppStyle.urbanistMedium.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}