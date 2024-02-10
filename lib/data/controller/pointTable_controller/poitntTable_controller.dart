import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/data/model/pointTable/poitTable.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

import '../../model/player_model/player_model.dart';
import '../../repo/PointTable_repo/PointTableRepo.dart';

class PointTableContrller extends GetxController {
  PointTableRepo rointTableRepo;
  PointTableContrller({required this.rointTableRepo});
  List<PointTable> _pointTables = [];
  List<PointTable> get pointTables => _pointTables;

  var isLoading = true.obs;


  pointTableData({id}) async {
    try {
       List<PointTable> matches = await rointTableRepo.fetchPointTable(id);
      _pointTables = matches;
            print("${matches} --------------------------");

      updateLoading(false);
      update();
    } catch (error) {
      update();
      updateLoading(false);

      print("Error fetching real-time data: $error");
    }
  }

  updateLoading(state) {
    isLoading.value = state;
  }
}
