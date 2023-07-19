import 'package:flutter/material.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/Style.dart';

class CustomNavigationDrawer extends StatefulWidget {
  var isDrawerOpen;

  CustomNavigationDrawer({super.key, required this.isDrawerOpen});

  @override
  _CustomNavigationDrawerState createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Content

        // Drawer
        AnimatedContainer(
          color: Cricket_app_Background,
          duration: Duration(milliseconds: 500),
          transform: Matrix4.translationValues(
            0.0,
            widget.isDrawerOpen ? 0.0 : MediaQuery.of(context).size.height,
            0.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  color: Cricket_Primary,
                  padding: EdgeInsets.all(10),
                  height: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 50,
                        color: Cricket_white,
                      ),
                      sizeboxSmallw,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hello',
                            style: CustomStyles.normalTextStyle,
                          ),
                          Text(
                            'Drawer Header',
                            style: CustomStyles.normalTextStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        width: 100,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Icon(Icons.dark_mode),
                        decoration: BoxDecoration(
                          borderRadius: CustomStylesBorder.boderRadius10,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dark Mode",
                                style: CustomStyles.cardBoldTextStyle2),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 70,
                        width: 100,
                        margin: const EdgeInsets.only(left: 10),
                        child: InkWell(
                            onTap: () {},
                            child: const Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        width: 100,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Icon(Icons.dark_mode),
                        decoration: BoxDecoration(
                          borderRadius: CustomStylesBorder.boderRadius10,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dark Mode",
                                style: CustomStyles.cardBoldTextStyle2),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 70,
                        width: 100,
                        margin: const EdgeInsets.only(left: 10),
                        child: InkWell(
                            onTap: () {},
                            child: const Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        width: 100,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Icon(Icons.dark_mode),
                        decoration: BoxDecoration(
                          borderRadius: CustomStylesBorder.boderRadius10,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dark Mode",
                                style: CustomStyles.cardBoldTextStyle2),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 70,
                        width: 100,
                        margin: const EdgeInsets.only(left: 10),
                        child: InkWell(
                            onTap: () {},
                            child: const Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        width: 100,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Icon(Icons.dark_mode),
                        decoration: BoxDecoration(
                          borderRadius: CustomStylesBorder.boderRadius10,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dark Mode",
                                style: CustomStyles.cardBoldTextStyle2),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 70,
                        width: 100,
                        margin: const EdgeInsets.only(left: 10),
                        child: InkWell(
                            onTap: () {},
                            child: const Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
