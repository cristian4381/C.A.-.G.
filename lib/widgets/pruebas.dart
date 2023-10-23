import 'package:flutter/material.dart';


class FormularioWidget extends StatelessWidget {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  FormularioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller1,
          decoration: const InputDecoration(labelText: 'Campo 1'),
        ),
        TextField(
          controller: controller2,
          decoration: const InputDecoration(labelText: 'Campo 2'),
        ),
        TextField(
          controller: controller3,
          decoration: const InputDecoration(labelText: 'Campo 3'),
        ),
      ],
    );
  }
}

