import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import 'main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return Container(
      height: Platform.isAndroid ? 100 : 110,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.12), //#0000001F
              blurRadius: 40.0,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ]
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: StreamBuilder(
          initialData: 0,
          stream: controller.naveListener.stream,
          builder: (_, AsyncSnapshot<int> index) {
            int selectedIndex = index.data ?? 0;
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  tooltip: 'Home',
                  icon: _navIcon(KImages.home),
                  activeIcon: _navIcon(KImages.homeActive),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  tooltip: 'Search',
                  icon: _navIcon(KImages.search),
                  activeIcon: _navIcon(KImages.searchActive),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  tooltip: "Save",
                  icon: _navIcon(KImages.save),
                  activeIcon: _navIcon(KImages.saveActive),
                  label: 'Save',
                ),
                BottomNavigationBarItem(
                  tooltip: 'More',
                  icon: _navIcon(KImages.menu),
                  activeIcon: _navIcon(KImages.menuActive),
                  label: 'More',
                ),
              ],
              // type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (int index) {
                controller.naveListener.sink.add(index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _navIcon(String path) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SvgPicture.asset(path));
}
