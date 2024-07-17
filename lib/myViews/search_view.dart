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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: InputFieldWidget(
                defaultHintText: "Search it..", controller: searchInput)),
        const SizedBox(
            width: 10), // Add some space between the search bar and the button
        Container(
          width: 50,
          height: 50,
          decoration: AppStyles.searchBoxStyle,
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: AppStyles.secondary,
            ),
            onPressed: () {
              var getsearchinputOntap = searchInput.text.toString();
              print("Input text of Search field : $getsearchinputOntap");
            },
          ),
        ),
      ],
    );
  }
}
