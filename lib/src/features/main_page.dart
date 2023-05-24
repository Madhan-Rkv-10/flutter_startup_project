import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../routing/tab_navigator.dart';
import '../utils/utils.dart';

// import '../utils/src/colors/app_colors.dart';

class CustomBottomNavigationItem {
  final BottomNavigationBarItem bottomNavigationBarItem;
  final String key;

  CustomBottomNavigationItem(this.bottomNavigationBarItem, this.key);
}

class MainScreen extends StatefulHookConsumerWidget {
  const MainScreen({Key? key, this.initPage = 0}) : super(key: key);

  final int? initPage;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  List<Widget>? _mainNavigationScreenItems;

  final pageController = PageController();
  @override
  void initState() {
    _mainNavigationScreenItems = getMainNavigationScreenItems();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(initialPage: widget.initPage!);
    final currentPage = useState(widget.initPage);

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageView(
              controller: pageController,
              onPageChanged: (int page) {
                currentPage.value = page;
              },
              children: [_mainNavigationScreenItems![currentPage.value!]]),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
            backgroundColor: AppColors.primaryColor,
            currentIndex: currentPage.value!,
            items: _finalBottomBarItems,
            onTap: (int page) {
              currentPage.value = page;

              pageController.animateToPage(
                page,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  List<BottomNavigationBarItem> get _finalBottomBarItems {
    List<BottomNavigationBarItem> items = [];
    for (var value in _bottomBarItems) {
      items.add(value.bottomNavigationBarItem);
    }
    return items;
  }

  List<CustomBottomNavigationItem> get _bottomBarItems => [
        CustomBottomNavigationItem(
            BottomNavigationBarItem(
                icon: _getIcon("AppAssets.homeInactive"),
                label: "home",
                activeIcon: _getIcon("AppAssets.homeActive")),
            "Home"),
        CustomBottomNavigationItem(
            BottomNavigationBarItem(
                icon: _getIcon("AppAssets.summaryInactive"),
                label: "Summary",
                activeIcon: _getIcon("AppAssets.summaryActive")),
            "Summary"),
        CustomBottomNavigationItem(
            BottomNavigationBarItem(
                icon: _getIcon("AppAssets.summaryInactive"),
                label: "Summary",
                activeIcon: _getIcon("AppAssets.summaryActive")),
            "Summary"),
      ];

  List<Widget> getMainNavigationScreenItems() {
    return [
      TabNavigator(
        navigatorKey: GlobalKey<NavigatorState>(),
        position: 0,
      ),
      TabNavigator(
        navigatorKey: GlobalKey<NavigatorState>(),
        position: 1,
      ),
      TabNavigator(
        navigatorKey: GlobalKey<NavigatorState>(),
        position: 2,
      ),
    ];
  }

  Widget _getIcon(String assetIconPath) {
    return Center(child: Icon(Icons.home)

        // Image.asset(assetIconPath,
        //     height: UIDimens.size25, width: UIDimens.size25)

        );
  }
}
