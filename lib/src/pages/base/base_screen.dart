import 'package:flutter/material.dart';

import '../home/home_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

int currentTabIndex = 0;
final pageController = PageController();

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    final kTabPages = <Widget>[
      const Center(
        child: Icon(Icons.cloud, size: 64.0, color: Colors.teal),
      ),
      const Center(
        child: Icon(Icons.alarm, size: 64.0, color: Colors.red),
      ),
      const Center(
        child: Icon(Icons.forum, size: 64.0, color: Colors.blue),
      ),
      const Center(
        child: Icon(Icons.date_range, size: 64.0, color: Colors.yellow),
      ),
    ];

    final kBottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart), label: 'Checkout'),
      const BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pedidos'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
    ];

    assert(kTabPages.length == kBottomNavBarItems.length);

    final bottomNavBar = BottomNavigationBar(
      items: kBottomNavBarItems,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTabIndex,
      backgroundColor: Colors.green,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withAlpha(100),
      onTap: (int index) {
        setState(() {
          currentTabIndex = index;
          pageController.jumpToPage(index);
        });
      },
    );
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomeTab(),
          Container(color: Colors.blue),
          Container(color: Colors.orange),
          Container(color: Colors.purple),
          // kTabPages[currentTabIndex],
        ],
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
