import 'package:evantly_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DateOrClock extends StatelessWidget {
  IconData prefix;
  String text;
  String textOfButton;
  Function onButtonClick;

  DateOrClock(
      {super.key,
        required this.prefix,
        required this.onButtonClick,
        required this.text,
        required this.textOfButton});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Container(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(prefix),
          SizedBox(width: width*0.035,),
          Text(
            text,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Spacer(),
          InkWell(onTap: () {
            onButtonClick();
          },
            child: Text(
              textOfButton,
              style: TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),

        ],
      ),
    );
  }
}

