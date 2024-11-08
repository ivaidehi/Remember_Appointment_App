import 'dart:developer';

import 'package:appointment_app/gets/get_docnm.dart';
import 'package:flutter/material.dart';
import '../data/wrapped_patient_appt_json.dart';
import '../myViews/search_view.dart';
import '../myViews/wrapped_appt_view.dart';
import '../myWidgets/sub_heading_widget.dart';
import '../styles/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  deletedWrappedAppt (int i){
    setState(() {
      try{
        wrappedApptList.removeAt(i);
        log('Appointment $i delete successfully');
      }
      catch(e){
        log('Not Delete. Error Occured.');
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hello,", style: AppStyles.headLineStyle2),
                            const SizedBox(height: 5),
                            const GetDoctorfnm(),
                          ],
                        ),
                      ),
                      // Profile Pic.
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/user_logo.jpg"),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search bar
                  const SearchView(),
                ],
              ),
              const SizedBox(height: 20),
              // Recently Opened Appointments
              // title - Recently Opened Appointments & view all
              const SubHeadingWidget(subHeading: "  Recent Appointments"),
              const SizedBox(height: 15),
              // Wrapped Appointment
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: wrappedApptList.length,
                itemBuilder: (context, index) {
                  var takeSingleWrappedAppt = wrappedApptList[index];
                  return GestureDetector(
                    onTap: () {
                      print("Tapped on : $index");
                      Navigator.pushNamed(context, "wrapped_appt_screen",
                          arguments: {"index": index});
                    },
                    child: WrappedApptView(
                      wrappedAppt: takeSingleWrappedAppt,
                      onDelete: () => deletedWrappedAppt(index),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
