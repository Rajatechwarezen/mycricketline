import 'package:flutter/material.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:shimmer/shimmer.dart';

var summer = Shimmer.fromColors(
  baseColor: Color.fromARGB(255, 202, 200, 200),
  highlightColor: const Color.fromARGB(255, 245, 245, 245),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      sizeboxSmallh,
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 80,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
      sizeboxSmallh,
    ],
  ),
);

var summerlive = Shimmer.fromColors(
  baseColor: const Color.fromARGB(255, 202, 200, 200),
  highlightColor: const Color.fromARGB(255, 245, 245, 245),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: Container(
          height: 150,
          margin: EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
      sizeboxSmallh,
    ],
  ),
);

var summer2 = Shimmer.fromColors(
  baseColor: Color.fromARGB(255, 202, 200, 200),
  highlightColor: const Color.fromARGB(255, 245, 245, 245),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      fullBox(),
      sizeboxSmallh,
      fullBox(),
      sizeboxSmallh,
      fullBox(),
    ],
  ),
);

Widget circlesummer = Shimmer.fromColors(
  baseColor: Color.fromARGB(255, 202, 200, 200),
  highlightColor: const Color.fromARGB(255, 245, 245, 245),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    ],
  ),
);

textlinesimmer300() {
  return Container(
    width: 300,
    height: 10,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}

textlinesimmer200() {
  return Container(
    width: 200,
    height: 10,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}

textlinesimmer100() {
  return Container(
    width: 100,
    height: 10,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}

fullBox() {
  return DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white,
        width: 2.0,
      ),
    ),
    child: Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          textlinesimmer300(),
          SizedBox(
            height: 10,
          ),
          textlinesimmer200(),
          SizedBox(
            height: 10,
          ),
          textlinesimmer100(),
          SizedBox(
            height: 20,
          ),
          textlinesimmer200()
        ],
      ),
    ),
  );
}
