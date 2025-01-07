import 'package:appointment_app/myWidgets/input_field_widget.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  final TextEditingController searchInput;
  const SearchView({super.key, required this.searchInput});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputFieldWidget(
            defaultHintText: "Search it...",
            controller: widget.searchInput,
            requiredInput: 'Please enter valid text',
            hideText: false,
            suffixIcon: const Icon(Icons.search, color: Colors.grey,),
          ),
        ),
      ],
    );
  }
}
