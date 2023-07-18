import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
 final void Function(BuildContext)? deleteTapped;
 final void Function(BuildContext)? editTapped;

  const ExpenseTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.dateTime,
      required this.deleteTapped,
       required this.editTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editTapped,
              icon: Icons.edit,
              backgroundColor: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            )
          ],
        ),
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          //delete button
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(15),
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white30],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(2, 2),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              name,
              style: GoogleFonts.varelaRound(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${dateTime.day}/${dateTime.month}/${dateTime.year}',
              style: GoogleFonts.nunito(
                fontSize: 16,
              ),
            ),
            trailing: Text(
              '\$ $amount',
              style: GoogleFonts.lato(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
