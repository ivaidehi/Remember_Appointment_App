// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
//
// import '../data/timeslots_list.dart';
// import '../gets/get_date.dart';
// import '../myWidgets/dropdown_widget.dart';
// import '../myWidgets/input_field_widget.dart';
// import '../myWidgets/labels_widget.dart';
// import '../styles/app_styles.dart';
// import 'home_screen.dart';
//
// class DemoSetAppt extends StatefulWidget {
//   const DemoSetAppt({super.key});
//
//   @override
//   State<DemoSetAppt> createState() => _DemoSetApptState();
// }
//
// class _DemoSetApptState extends State<DemoSetAppt> {
//   var nameInput = TextEditingController();
//   var contactInput = TextEditingController();
//   var scheduleTreatmentInput = TextEditingController();
//   var noteInput = TextEditingController();
//
//   String? selectedDayparts;
//   var dayPartsList = ['Morning', 'Afternoon', 'Evening'];
//
//   DateTime? selectedDate;
//   String? selectedTimeSlot;
//
//   final _formKey = GlobalKey<FormState>();
//
//   // Your time slots map
//   final Map<String, List<String>> timeSlots = {
//     'Morning': [
//       '8:00 AM – 8:30 AM',
//       '8:30 AM – 9:00 AM',
//       '9:00 AM – 9:30 AM',
//       '9:30 AM – 10:00 AM',
//       '10:00 AM – 10:30 AM',
//       '10:30 AM – 11:00 AM',
//       '11:00 AM – 11:30 AM',
//     ],
//     'Afternoon': [
//       '1:00 PM – 1:30 PM',
//       '1:30 PM – 2:00 PM',
//       '2:00 PM – 2:30 PM',
//       '2:30 PM – 3:00 PM',
//       '3:00 PM – 3:30 PM',
//       '3:30 PM – 4:00 PM',
//       '4:00 PM – 4:30 PM',
//     ],
//     'Evening': [
//       '5:00 PM – 5:30 PM',
//       '5:30 PM – 6:00 PM',
//       '6:00 PM – 6:30 PM',
//       '6:30 PM – 7:00 PM',
//       '7:00 PM – 7:30 PM',
//       '7:30 PM – 8:00 PM',
//     ],
//   };
//
//   final _formKey = GlobalKey<FormState>();
//
//   Future<void> setApptData() async {
//     if (_formKey.currentState?.validate() == true) {
//       // Proceed with submitting the appointment data
//       await FirebaseFirestore.instance
//           .collection("Appointments")
//           .doc(contactInput.text.trim()) // Unique user document
//           .set({
//         'Patient Name': nameInput.text.trim(),
//         'Phone no.': contactInput.text.trim(),
//         'Selected Date': selectedDate.toString(),
//         'Day Part': selectedDayparts.toString(),
//         'Selected Time Slot': selectedTimeSlot, // Save the selected time slot
//         'Schedule Treatment': scheduleTreatmentInput.text.trim(),
//         'Note': noteInput.text.trim(),
//       });
//
//       // Clear form after submission
//       nameInput.clear();
//       contactInput.clear();
//       scheduleTreatmentInput.clear();
//       noteInput.clear();
//       setState(() {
//         selectedDayparts = null;
//         selectedTimeSlot = null;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Appointment set successfully!')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppStyles.bgColor,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const HomeScreen()),
//             );
//           },
//         ),
//         title: Text(
//           'Set Appointment',
//           style: TextStyle(color: AppStyles.primary),
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(25),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const LabelsWidget(label: 'Name'),
//                 const SizedBox(height: 10),
//                 InputFieldWidget(
//                   defaultHintText: 'Enter Name',
//                   controller: nameInput,
//                   requiredInput: 'Name',
//                   hideText: false,
//                 ),
//                 const SizedBox(height: 20),
//                 const LabelsWidget(label: 'Contact'),
//                 const SizedBox(height: 10),
//                 InputFieldWidget(
//                   defaultHintText: 'Enter Contact No.',
//                   controller: contactInput,
//                   requiredInput: 'Contact No.',
//                   hideText: false,
//                   onlyInt: FilteringTextInputFormatter.digitsOnly,
//                   keyBoardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     const LabelsWidget(label: 'Date : '),
//                     Text(
//                       DateFormat.yMMMMd().format(DateTime.now()),
//                       style: AppStyles.headLineStyle3.copyWith(color: AppStyles.primary),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 GetApptDate(onDateSelected: (date) {
//                   setState(() {
//                     selectedDate = date;
//                   });
//                 }),
//                 const SizedBox(height: 10),
//                 const LabelsWidget(label: 'Day Part'),
//                 const SizedBox(height: 10),
//                 DropdownWidget(
//                   itemList: dayPartsList,
//                   selectedItem: selectedDayparts,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedDayparts = newValue;
//                       selectedTimeSlot = null; // Reset time slot when day part changes
//                     });
//                   },
//                   select: 'Select Day Part',
//                 ),
//                 const SizedBox(height: 20),
//                 const LabelsWidget(label: 'Time Slots '),
//                 const SizedBox(height: 10),
//                 DropdownWidget(
//                   itemList: selectedDayparts != null ? timeSlots[selectedDayparts!] ?? [] : [],
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedTimeSlot = newValue;
//                     });
//                   },
//                   selectedItem: selectedTimeSlot,
//                   select: 'Select Time Slot',
//                 ),
//                 const SizedBox(height: 20),
//                 const LabelsWidget(label: 'Schedule Treatment'),
//                 const SizedBox(height: 10),
//                 InputFieldWidget(
//                   defaultHintText: 'Type here',
//                   controller: scheduleTreatmentInput,
//                   requiredInput: 'Text',
//                   hideText: false,
//                 ),
//                 const SizedBox(height: 20),
//                 const LabelsWidget(label: 'Note'),
//                 const SizedBox(height: 10),
//                 InputFieldWidget(
//                   defaultHintText: 'Type here',
//                   controller: noteInput,
//                   requiredInput: 'Text',
//                   hideText: false,
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: setApptData,
//                   child: const Text('Set Appointment'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
