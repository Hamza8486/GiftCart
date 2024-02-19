import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scratcher/scratcher.dart';

class ScratchCardWidget extends StatefulWidget {
  @override
  State<ScratchCardWidget> createState() => _ScratchCardWidgetState();
}

class _ScratchCardWidgetState extends State<ScratchCardWidget> {
  bool isScratched = false; // Flag to track if the card is scratched

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.12),
          SizedBox(
            height: Get.height * 0.3,
            child: Center(
              child: Scratcher(
                brushSize: 50, // Adjust the brush size as needed
                threshold: 40, // Adjust the threshold as needed
                color: isScratched ? Colors.transparent : Colors.grey, // Initial scratch card color
                image: Image.asset('assets/images/scratch.png'), // Custom brush image
                onChange: (value) {
                  if (value >= 1.0 && !isScratched) {
                    setState(() {
                      isScratched = true; // Scratch threshold reached
                    });
                  }
                  print("Scratch progress: ${value * 100}%");
                },
                child: Container(
                  width: 300,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isScratched ? Colors.blue : Colors.transparent, // Content revealed
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: isScratched
                        ? [] // No shadow when content is revealed
                        : [BoxShadow(blurRadius: 10, color: Colors.grey)], // Add a blurred effect
                  ),
                  child: isScratched
                      ? Text(
                    'Value: Your Value Here', // Display your value
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                      : Text(
                    'Scratch Me!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
