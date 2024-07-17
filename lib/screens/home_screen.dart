import 'package:appointment_app/gets/get_docnm.dart';
import 'package:flutter/material.dart';
import '../data/wrapped_patient_appt_json.dart';
import '../myViews/search_view.dart';
import '../myViews/wrapped_appt_view.dart';
import '../myWidgets/sub_heading_widget.dart';
import '../styles/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: ListView(
          children: [
            // Doc. Name, Profile Pic. & Search bar
            Column(
              children: [
                // Doc. Name & Profile Pic.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Doc. Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello,", style: AppStyles.headLineStyle2),
                        const SizedBox(height: 5),
                        const GetDoctorfnm(doctor_fname: "Nolan"),
                      ],
                    ),
                    // Profile Pic.
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/user_logo.jpg"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Search bar
                const SearchView(),
              ],
            ),
            const SizedBox(height: 40),
            //
            //
            // Recently Opened Appointments
            // title - Recently Opened Appointments & view all
            const SubHeadingWidget(subHeading: "Recent Appointments"),
            const SizedBox(height: 15),
            // Wrapped Appointment
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: wrappedApptList.map((takeSingleWrappedAppt) {
                  var index = wrappedApptList.indexOf(takeSingleWrappedAppt);
                  return GestureDetector(
                    onTap: () {
                      print("Tapped on : $index");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const WrappedApptScreen(),
                      //   ),
                      //   arguments :
                      // );
                      Navigator.pushNamed(context, "wrapped_appt_screen",
                          arguments: {"index": index});
                    },
                    child: WrappedApptView(wrappedAppt: takeSingleWrappedAppt),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
