import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void customShowMoreBottomSheet(context, List<Map<String, dynamic>> list, Function(int) onTapTile){
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context){
        return Padding(
          padding: EdgeInsets.only(
            left: 2.w,
            right: 2.w,
          ),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(height: 10.h,),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        onTap: (){
                          onTapTile(index);
                        },
                        child: ListTile(
                          leading: Icon(list[index]['icon']),
                          title: Text(list[index]['name']),
                        ),
                      );
                    }
                )
              ],
            ),
          ),
        );
      }
  );
}