import 'package:flutter/material.dart';


class DropdownWidget extends StatefulWidget {
  final List<String> itemList;
  final ValueChanged<String?> onChanged;
  final String? selectedItem;
  final String select;

  const DropdownWidget({
    super.key,
    required this.itemList,
    required this.onChanged,
    required this.selectedItem,
    required this.select,
  });

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: InputDecorator(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 17),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(20),
          // ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedItem,
            hint: Text(widget.select, style: const TextStyle(color: Colors.grey),),
            isExpanded: true,
            items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue;
                widget.onChanged(newValue);
              });
            },
          ),
        ),
      ),
    );
  }
}
