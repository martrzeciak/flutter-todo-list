import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_app/themes/colors.dart';

import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  const TaskTile(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        //padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: secondaryColor,
        ),
        child: Row(children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        task?.title ?? "",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        task!.isCompleted == 1 ? "COMPLETED" : "TODO",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${task!.startTime} - ${task!.endTime}",
                        style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 13, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    task?.description ?? "",
                    style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          Container(
            //padding: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 25),
            margin: const EdgeInsets.only(right: 10),
            child: RotatedBox(
              quarterTurns: 3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _getBGClr(task?.priority ?? 0, task?.isCompleted),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: 80,
                  height: 20,
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 25),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int priority, int? isCompleted) {
    if (isCompleted == 1) {
      return primaryColor;
    }
    
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.amber[300];
      case 3:
        return Colors.red[400];
      default:
        return Colors.green;
    }
  }
}
