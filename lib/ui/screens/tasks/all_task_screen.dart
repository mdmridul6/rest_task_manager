import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/widgets/network_cashed_image.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: NetworkCashedImage(url: ''),
        ),
      ),
    );
  }
}
