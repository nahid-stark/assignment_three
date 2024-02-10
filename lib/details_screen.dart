import 'package:assignment_three/pojo.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final int index;
  final Pojo data;

  const DetailsScreen({super.key, required this.index, required this.data});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Photo Details",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.data.url ?? "",
                  fit: BoxFit.fitWidth,
                  height: 400,
                  width: 600,
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: [
                    Text(
                      widget.data.title ?? "",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "ID: ${widget.data.id ?? ""}",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
