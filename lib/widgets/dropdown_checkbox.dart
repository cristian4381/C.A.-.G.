import 'package:ca_and_g/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropDownCheckbox extends StatefulWidget {
  final String title;
  final List<String> items;
  const CustomDropDownCheckbox({Key? key, required this.items, required this.title}) : super(key: key);

  @override
  State<CustomDropDownCheckbox> createState() => _CustomDropDownCheckboxState();
}

class _CustomDropDownCheckboxState extends State<CustomDropDownCheckbox> {
  List<String> selectedItems=[];
  @override
  Widget build(BuildContext context) {
    
    return  Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 20),
      decoration: AppTheme.containerTheme(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 5,left: 15),
              child: Text(widget.title,
                style: AppTheme.notaTheme(context),
              ),
            ),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              //barrierDismissible: true,
              isExpanded: true,
              hint: Align(
                //alignment: AlignmentDirectional.center,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              items: widget.items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  //disable default onTap to avoid closing menu when selecting an item
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected = selectedItems.contains(item);
                      return InkWell(
                        onTap: () {
                          isSelected
                                  ? selectedItems.remove(item)
                                  : selectedItems.add(item);
                          //This rebuilds the StatefulWidget to update the button's text
                          setState(() {});
                          //This rebuilds the dropdownMenu Widget to update the check mark
                          menuSetState(() {});
                        },
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              isSelected
                                      ? const Icon(Icons.check_box_outlined)
                                      : const Icon(Icons.check_box_outline_blank),
                              const SizedBox(width: 16),
                              Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
              value: selectedItems.isEmpty ? null : selectedItems.last,
              onChanged: (value) {},
              selectedItemBuilder: (context) {
                return widget.items.map(
                          (item) {
                    return Container(
                      alignment: AlignmentDirectional.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        selectedItems.join(', '),
                        style: const TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    );
                  },
                ).toList();
              },
              buttonStyleData: ButtonStyleData(
                
                //height: 60,
                width: MediaQuery.of(context).size.width,
                //padding: const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 20),
              ),
              menuItemStyleData: const MenuItemStyleData(
                //height: 40,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}