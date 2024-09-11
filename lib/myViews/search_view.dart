import 'package:appointment_app/myWidgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var searchInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputFieldWidget(
            defaultHintText: "Search it...",
            controller: searchInput,
            requiredInput: 'Please enter valid text',
            hideText: false,
          ),
        ),
        const SizedBox(width: 5),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            borderRadius: BorderRadius.circular(7), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3), // Position of the shadow
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              var getsearchinputOntap = searchInput.text.toString();
              print("Input text of Search field: $getsearchinputOntap");
            },
            icon: Icon(
              Icons.search,
              color: AppStyles.secondary,
            ),
            iconSize: 30, // Size of the icon
          ),
        ),
      ],
    );
  }
}
