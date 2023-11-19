import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/custom_appBar.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/services/storage_services.dart';
import 'package:buy_me/ui/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../routes/app_routes.dart';
import 'drawer.dart';

class TabControllerScreen extends StatefulWidget {
  const TabControllerScreen({super.key});

  @override
  State<TabControllerScreen> createState() => _TabControllerScreenState();
}

class _TabControllerScreenState extends State<TabControllerScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(HomeController());
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tabController.addListener(() {
      controller.currentIndex = tabController.index;
      controller.getAllData();
    });
    return Scaffold(
      key: scaffoldKey1,
      appBar: buildHomeAppBar(
          onTapDrawer: () {
            scaffoldKey1.currentState?.openDrawer();
          },
          onTapSearch: () {
            Get.toNamed(Routes.searchScreen);
          },
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.04),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: Get.width * 0.8,
                    child: TabBar(
                      tabs: controller.tabs,
                      controller: tabController,
                      dividerColor: Colors.transparent,
                      physics: const BouncingScrollPhysics(),
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: GoogleFonts.firaCode().fontFamily),
                      indicatorColor: Colors.black,
                      indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(width: 2)),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelPadding: const EdgeInsets.only(left: 8),
                      unselectedLabelStyle: TextStyle(
                          overflow: TextOverflow.fade,
                          fontFamily: GoogleFonts.firaCode().fontFamily),
                      onTap: (val) {
                        controller.getAllData();
                      },
                      isScrollable: true,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Utils.showBottomSheet(
                      widget: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 6,
                              margin: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.38)
                                  .copyWith(top: Get.height * 0.01),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.04),
                            Utils.getRow(
                              firstWidget:
                                  Utils.titleText(text: 'Filter', size: 22),
                              secondWidget: Utils.titleText(
                                  text: 'RESET', color: Colors.grey, size: 10),
                            ),
                            SizedBox(height: Get.height * 0.03),
                            Utils.titleText(text: 'Gender', size: 22),
                            SizedBox(height: Get.height * 0.02),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ToggleSwitch(
                                onToggle: (val) =>
                                    controller.sizeSelectInGender,
                                inactiveBgColor: AppColors.cardColor,
                                activeBgColor: const [Colors.deepOrange],
                                radiusStyle: true,
                                dividerColor: Colors.white,
                                dividerMargin: 0,
                                minWidth: 120,
                                minHeight: 56,
                                inactiveFgColor: Colors.black,
                                labels: StorageService.detailGenderLabel,
                                totalSwitches:
                                    StorageService.detailGenderLabel.length,
                                initialLabelIndex: 0,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.03),
                            Utils.getRow(
                                firstWidget: const Text(
                                  'Size',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                secondWidget: ToggleSwitch(
                                  onToggle: (val) =>
                                      controller.changeToggle(val),
                                  inactiveBgColor: Colors.white,
                                  activeBgColor: const [Colors.grey],
                                  minWidth: 40,
                                  minHeight: 34,
                                  radiusStyle: true,
                                  inactiveFgColor: Colors.grey,
                                  labels: const ['US', 'UK', 'EU'],
                                  totalSwitches: 3,
                                  initialLabelIndex: 0,
                                )),
                            SizedBox(height: Get.height * 0.03),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ToggleSwitch(
                                onToggle: (val) =>
                                    controller.sizeSelectInNumbers,
                                inactiveBgColor: AppColors.cardColor,
                                activeBgColor: const [Colors.deepOrange],
                                radiusStyle: true,
                                dividerColor: Colors.white,
                                dividerMargin: 0,
                                minWidth: 70,
                                minHeight: 60,
                                inactiveFgColor: Colors.grey,
                                labels: StorageService.detailSizeLabel,
                                totalSwitches:
                                    StorageService.detailSizeLabel.length,
                                initialLabelIndex: 0,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.03),
                            Utils.titleText(text: 'Brand', size: 22),
                            SizedBox(height: Get.height * 0.02),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: GetBuilder<HomeController>(
                                builder: (_) =>
                                Row(
                                  children: List.generate(
                                    StorageService.filterLogo.length,
                                        (index) => GestureDetector(
                                      onTap: () => controller.changeFilterLogoToggle(index),
                                      child: Container(
                                        margin: EdgeInsets.all(8),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: controller.filterLogoIndex == index ? Colors.deepOrange : Colors.grey,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: SvgPicture.asset(
                                          StorageService.filterLogo[index],
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.03),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.04),
                    child: const Icon(Icons.tune),
                  ),
                )
              ],
            ),
          )),
      drawer: CustomDrawer(),
      body: TabBarView(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        children: controller.tabsView,
      ),
    );
  }
}
