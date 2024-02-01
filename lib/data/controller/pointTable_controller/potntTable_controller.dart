import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/data/model/pointTable/poitTable.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

import '../../repo/PointTable_repo/PointTableRepo.dart';

class PointTableContrller{
   
    PointTableRepo rointTableRepo;
    PointTableContrller({required this.rointTableRepo});
     List<PointTable> _pointTables = [];

  List<PointTable> get pointTables => _pointTables;

}
