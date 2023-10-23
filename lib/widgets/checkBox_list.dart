import 'package:flutter/material.dart';

class RadioButtonList extends StatefulWidget {
  final List<String> itemList;
  final ValueChanged<String>? onChanged;
  final String? selectedValue;

  const RadioButtonList({super.key, 
    required this.itemList,
    this.onChanged,
    this.selectedValue,
  });

  @override
  State<RadioButtonList> createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  late String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.itemList.map((item) {
        return RadioListTile(
          title: Text(item),
          value: item,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value!);
            }
          },
        );
      }).toList(),
    );
  }
}