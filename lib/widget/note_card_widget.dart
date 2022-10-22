import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noter/model/note.dart';

final _lightColors = [
  Color.fromARGB(255, 252, 250, 250),
];

class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMEd().format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 244, 244),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 0.3, offset: Offset(0, 0)),
            // BoxShadow(blurRadius: 2, offset: Offset(2, 2))
          ],
        ),
        height: minHeight,
        //color: Color.fromARGB(255, 251, 251, 251),
        // padding: EdgeInsets.only(left: 4, right: 4),
        child: Stack(
          children: [
            Container(
              //margin: EdgeInsets.all(15),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 244, 244),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  //BoxShadow(blurRadius: 0.3, offset: Offset(2, 2)),
                  // BoxShadow(blurRadius: 2, offset: Offset(2, 2))
                ],
              ),
              constraints: BoxConstraints(minHeight: minHeight),
              //padding: EdgeInsets.all(10),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    SizedBox(height: 3.4),
                    Expanded(
                      child: Text(
                        note.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.3,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 2.9),
                    Expanded(
                      child: Text(
                        note.description,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 20,
                ),
                decoration: BoxDecoration(
                  //shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
