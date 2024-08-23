import 'package:flutter/material.dart';

class TaskCounterCard extends StatelessWidget {
  final int taskCount;

  const TaskCounterCard({Key? key, required this.taskCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Äußerer Abstand zur Card
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Abrundung der Ecken
        ),
        color: const Color.fromARGB(
            26, 222, 103, 255), // Hintergrundfarbe der Card
        elevation: 5, // Schatten für einen leichten "Schwebefeffekt"
        child: Padding(
          padding:
              const EdgeInsets.all(16.0), // Innerer Abstand innerhalb der Card
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Kreisförmiger Hintergrund um die Zahl
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.purple, // Hintergrundfarbe des Kreises
                  shape: BoxShape.circle, // Kreisform
                ),
                child: Text(
                  "$taskCount",
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white, // Textfarbe
                    fontWeight: FontWeight.bold, // Fettschrift für die Zahl
                  ),
                ),
              ),
              SizedBox(width: 16), // Abstand zwischen Zahl und Text
              Expanded(
                child: Text(
                  "Anzahl der offenen Tasks",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
