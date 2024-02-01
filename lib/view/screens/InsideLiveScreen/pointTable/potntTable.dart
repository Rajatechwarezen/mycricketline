import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

class PointTableSreen extends StatefulWidget {
  final idmatch;

  const PointTableSreen({required this.idmatch});

  @override
  State<PointTableSreen> createState() => _PointTableSreenState();
}

class _PointTableSreenState extends State<PointTableSreen> {
  @override
  Widget build(BuildContext context) {

   
    return Container(
      height: 300,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: ListView(
        children:  [
        SmallText(text: "Point Table " ,textStyle:interBoldExtraLarge.copyWith(color: MyColor.getTextColor()) )
    
        ],
      ),
    );
  }




  //  Widget buildRowHeader(Header header) {

  //   List<Widget> list = new List<Widget>();
  //   list.add(buildCellHeader(flex: 1,text: header.prefix,textAlign:TextAlign.left));
  //   list.add(buildCellHeader(flex: 4,text: header.label,textAlign:TextAlign.left));

  //   if(widget.table.columns >= 1 && header.row1 != null){
  //     list.add(buildCellHeader(flex: 1,text: (header.row1 != null)? header.row1 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 2 && header.row2 != null){
  //     list.add(buildCellHeader(flex: 1,text:(header.row2 != null)? header.row2: "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 3 && header.row3 != null){
  //     list.add(buildCellHeader(flex: 1,text: (header.row3 != null)? header.row3 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 4 && header.row4 != null){
  //     list.add(buildCellHeader(flex: 1,text: (header.row4 != null)? header.row4 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 5 && header.row5 != null){
  //     list.add(buildCellHeader(flex: 1,text: (header.row5 != null)? header.row5 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 6 && header.row6 != null){
  //     list.add(buildCellHeader(flex: 1,text: (header.row6 != null)? header.row6 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 7 && header.row7 != null){
  //     list.add(buildCellHeader(flex: 1,text: (header.row7 != null)? header.row7 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 8 && header.row8 != null){
  //     list.add(buildCellHeader(flex: 1,text: (header.row8 != null)? header.row8 : "#",textAlign:TextAlign.center));
  //   }

  //   return Container(
  //       height: 40,
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       width: MediaQuery.of(context).size.width,
  //       decoration: BoxDecoration(
  //         border: Border(top: BorderSide(color: Theme.of(context).textTheme.bodyText2.color.withOpacity(0.1),width: 0.5)),
  //       ),
  //       child:
  //       Row(
  //         mainAxisSize: MainAxisSize.max,
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children:list,
  //       )
  //   );
  // }

  // Widget buildRow(Line line) {

  //   List<Widget> list = new List<Widget>();
  //   list.add(buildCellHeader(flex: 1,text: line.prefix,textAlign:TextAlign.left));
  //   list.add( Expanded(
  //       flex: 4,
  //       child: Row(
  //         children: [
  //           Image(image: CachedNetworkImageProvider(line.image),height: 15,width: 15,),
  //           SizedBox(width: 5),
  //           Flexible(
  //             child: Text(line.label,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: TextStyle(
  //                   color: Theme.of(context).textTheme.bodyText2.color,
  //                   fontSize: 11,
  //                 )
  //             ),
  //           ),
  //         ],
  //       )
  //   ));
  //   if(widget.table.columns >= 1){
  //     list.add(buildCell(flex: 1,text: (line.row1 != null)? line.row1 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 2){
  //     list.add(buildCell(flex: 1,text: (line.row2 != null)? line.row2 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 3){
  //     list.add(buildCell(flex: 1,text: (line.row3 != null)? line.row3 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 4){
  //     list.add(buildCell(flex: 1,text: (line.row4 != null)? line.row4 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 5){
  //     list.add(buildCell(flex: 1,text: (line.row5 != null)? line.row5 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 6){
  //     list.add(buildCell(flex: 1,text: (line.row6 != null)? line.row6 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 7){
  //     list.add(buildCell(flex: 1,text: (line.row7 != null)? line.row7 : "#",textAlign:TextAlign.center));
  //   }
  //   if(widget.table.columns >= 8){
  //     list.add(buildCell(flex: 1,text: (line.row8 != null)? line.row8 : "#",textAlign:TextAlign.center));
  //   }

  //   return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       height: 40,
  //       width: MediaQuery.of(context).size.width,
  //       decoration: BoxDecoration(
  //         color: (line.color == null)? Colors.transparent : Color(int.parse("0xff"+line.color)).withOpacity(0.2),
  //         border: Border(top: BorderSide(color: Theme.of(context).textTheme.bodyText2.color.withOpacity(0.1),width: 0.5)),
  //       ),
  //       child:
  //       Row(
  //         mainAxisSize: MainAxisSize.max,
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: list,
  //       )
  //   );
  // }

  // buildCellHeader({int flex, String text,TextAlign textAlign}) {
  //   return Expanded(
  //     flex: flex ,
  //     child: Text(text,
  //         style: TextStyle(
  //             color: Theme.of(context).textTheme.bodyText1.color,
  //             fontSize: 12,
  //             fontWeight: FontWeight.bold
  //         ),
  //         textAlign:textAlign
  //     ),
  //   );
  // }
  // buildCell({int flex, String text,TextAlign textAlign}) {
  //   return Expanded(
  //     flex: flex ,
  //     child: Text(text,
  //         style: TextStyle(
  //           color: Theme.of(context).textTheme.bodyText2.color,
  //           fontSize: 11,
  //         ),
  //         textAlign:textAlign
  //     ),
  //   );
  // }

}
