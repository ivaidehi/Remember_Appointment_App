import 'package:appointment_app/data/wrapped_patient_appt_json.dart';
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
  @override
  void didChangeDependencies() {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    print("Opened index ${args["index"]}");
    wrappedApptIndex = args["index"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: AppStyles.bgColor,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Apointment Details",
            style: TextStyle(color: AppStyles.primary).copyWith(fontSize: 20),
          ),
          backgroundColor: AppStyles.bgColor,
        ),
        backgroundColor: AppStyles.bgColor,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            WrappedApptView(wrappedAppt: wrappedApptList[wrappedApptIndex]),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primary,
                  minimumSize: const Size(
                      double.infinity, 50), // Full width and height 50
                  shape: RoundedRectangleBorder(
                    // Rectangular shape
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddnewApptScreen()),
                  );
                },
                child: Text(
                  '+  Add New ',
                  style: AppStyles.headLineStyle3.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SubHeadingWidget(subHeading: "Current Appointment Details"),
            // const LineWidget(),
            const SizedBox(
              height: 20,
            ),
            // Current Patient's Appointment Details
            Container(
              padding: const EdgeInsets.all(15),
              decoration:
                  AppStyles.inputBoxShadowStyle.copyWith(color: Colors.white),
              child: const CurrentPatientApptDetails(
                  contact: "816344842",
                  schedule_treatment:
                      "Physical Therapy Session - Lower Back Pain and Muscle Pain",
                  note: "Patient needs to follow up in two weeks."),
            ),
            // Previous Appointment Details
            const SizedBox(
              height: 25,
            ),
            const SubHeadingWidget(subHeading: "Previous Appointment Details"),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration:
                  AppStyles.inputBoxShadowStyle.copyWith(color: Colors.white),
              child: const PreviousPatientApptDetails(
                  previous_appt_date: "01-07-2024",
                  schedule_treatment:
                      "Physical Therapy Session - Lower Back Pain and Muscle Pain",
                  note:
                      "Daily Yoga, Exercise and Patient needs to follow up in two weeks."),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
