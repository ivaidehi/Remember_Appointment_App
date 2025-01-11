import 'package:appointment_app/gets/previous_patient_appt_details.dart';
import 'package:appointment_app/myViews/wrapped_appt_view.dart';
import 'package:appointment_app/myWidgets/sub_heading_widget.dart';
import 'package:appointment_app/screens/addnew_appt_screen.dart';
import 'package:appointment_app/styles/app_styles.dart';
import 'package:flutter/material.dart';
import '../gets/current_patient_appt_details.dart';

class WrappedApptScreen extends StatefulWidget {
  const WrappedApptScreen({super.key});

  @override
  State<WrappedApptScreen> createState() => _WrappedApptScreenState();
}

class _WrappedApptScreenState extends State<WrappedApptScreen> {
  late int wrappedApptIndex = 0;
  late Map<String, dynamic> wrappedApptData = {};

  @override
  void didChangeDependencies() {
    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      wrappedApptIndex = args["TappedCardIndex"] ?? 0;
      wrappedApptData = args["appointmentData"] ?? {};
      wrappedApptData['documentID'] = args['documentID'] ?? 'No ID Available';
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Appointment Details",
          style: TextStyle(color: AppStyles.primary).copyWith(fontSize: 20),
        ),
        backgroundColor: AppStyles.bgColor,
      ),
      backgroundColor: AppStyles.bgColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          WrappedApptView(
            index: wrappedApptIndex,
            appointmentData: wrappedApptData,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Fetch and print the documentID for assurance
                final documentID = wrappedApptData['documentID'] ?? 'No ID Available';
                debugPrint('Document ID: $documentID');

                // Navigate to AddnewApptScreen and pass the required arguments
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddnewApptScreen(),
                    settings: RouteSettings(
                      arguments: {
                        'name': wrappedApptData['Patient Name'] ?? '',
                        'contact': wrappedApptData['Contact No.'] ?? '',
                        'documentID': documentID, // Pass the documentID here
                      },
                    ),
                  ),
                );
              },
              child: Text(
                '+  Add New ',
                style: AppStyles.headLineStyle3.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const SubHeadingWidget(subHeading: "Current Appointment Details"),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: AppStyles.inputBoxShadowStyle.copyWith(color: Colors.white),
            child: CurrentPatientApptDetails(
              contact: _getStringFromMap(wrappedApptData, 'Contact No.') ?? 'N/A',
              scheduleTreatment: _getStringFromMap(wrappedApptData, 'Schedule Treatment') ?? 'N/A',
              note: _getStringFromMap(wrappedApptData, 'Note') ?? 'N/A',
            ),
          ),


          const SizedBox(height: 25),
          const SubHeadingWidget(subHeading: "Previous Appointment Details"),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: AppStyles.inputBoxShadowStyle
                .copyWith(color: Colors.white),
            child: const PreviousPatientApptDetails(
              previous_appt_date: "01-07-2024",
              schedule_treatment:
              "Physical Therapy Session - Lower Back Pain and Muscle Pain",
              note:
              "Daily Yoga, Exercise and Patient needs to follow up in two weeks.",
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
String? _getStringFromMap(Map<String, dynamic> map, String key) {
  var value = map[key];
  if (value is String) {
    return value;
  } else if (value != null) {
    return value.toString();  // Ensure non-string values are cast to strings
  }
  return null;  // If the value is null or not found
}
