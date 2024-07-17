import 'package:appointment_app/styles/app_styles.dart';
import 'package:flutter/material.dart';
import '../myWidgets/dropdown_widget.dart';
import '../myWidgets/input_field_widget.dart';
import '../myWidgets/labels_widget.dart';
import 'home_screen.dart';

class SetApptScreen extends StatefulWidget {
  const SetApptScreen({super.key});

  @override
  State<SetApptScreen> createState() => _SetApptScreenState();
}

class _SetApptScreenState extends State<SetApptScreen> {
  var nameInput = TextEditingController();
  var contactInput = TextEditingController();
  var yearInput = TextEditingController();
  var scheduleTreatmentInput = TextEditingController();
  var noteInput = TextEditingController();
  String? selectedMonth;
  var monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String? selectedDate;
  var dateList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31"
  ];

  String? hours;
  var hrsList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];

  String? mins;
  var minsList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "50",
    "51",
    "52",
    "53",
    "54",
    "55",
    "56",
    "57",
    "58",
    "59",
    "60"
  ];

  String? ampm;
  var ampmList = ["AM", "PM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: Text(
          'Set Appointment',
          style: TextStyle(color: AppStyles.primary),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(35),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LabelsWidget(label: 'Name'),
              InputFieldWidget(
                defaultHintText: 'Enter Name',
                controller: nameInput,
              ),
              const SizedBox(height: 20),
              const LabelsWidget(label: 'Contact'),
              InputFieldWidget(
                defaultHintText: 'Enter Contact No.',
                controller: contactInput,
              ),
              const SizedBox(height: 25),
              const LabelsWidget(label: 'Appointment Date & Time'),
              const SizedBox(height: 5),
              InputFieldWidget(
                defaultHintText: 'Enter Year',
                controller: yearInput,
              ),
              const SizedBox(height: 10),
              DropdownWidget(
                itemList: monthList,
                selectedItem: selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue;
                  });
                },
                select: 'Select Month',
              ),
              const SizedBox(height: 10),
              DropdownWidget(
                itemList: dateList,
                selectedItem: selectedDate,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDate = newValue;
                  });
                },
                select: 'Select Date',
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: DropdownWidget(
                      itemList: hrsList,
                      selectedItem: hours,
                      onChanged: (String? newValue) {
                        setState(() {
                          hours = newValue;
                        });
                      },
                      select: 'Hrs.',
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: DropdownWidget(
                      itemList: minsList,
                      selectedItem: mins,
                      onChanged: (String? newValue) {
                        setState(() {
                          mins = newValue;
                        });
                      },
                      select: 'Min.',
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: DropdownWidget(
                      itemList: ampmList,
                      selectedItem: ampm,
                      onChanged: (String? newValue) {
                        setState(() {
                          ampm = newValue;
                        });
                      },
                      select: 'AM/PM',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const LabelsWidget(label: 'Schedule Treatment'),
              InputFieldWidget(
                defaultHintText: 'Type here',
                controller: contactInput,
              ),
              const SizedBox(height: 20),
              const LabelsWidget(label: 'Note'),
              InputFieldWidget(
                defaultHintText: 'Type here',
                controller: contactInput,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  var getsearchinputOntap = nameInput.text.toString();
                  var getcontactinputOntap = contactInput.text.toString();
                  print("Input text of Name field: $getsearchinputOntap");
                  print("Input text of Contact field: $getcontactinputOntap");
                  print("Selected Month: $selectedMonth");
                  print("Selected Date: $selectedDate");
                  print("Selected hour: $hours");
                  print("Selected min: $mins");
                  print("Selected ampm: $ampm");
                  print("Selected schedule Treatment: $selectedDate");
                  print("Selected note: $selectedDate");
                },
                child: Text(
                  'Set Appointment',
                  style: AppStyles.headLineStyle3.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
