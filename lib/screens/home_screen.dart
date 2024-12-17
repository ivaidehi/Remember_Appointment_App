import 'dart:developer';

import 'package:appointment_app/gets/get_docnm.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> deleteFirestoreAppointment(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Appointments')
          .doc(documentId)
          .delete();
      log('Appointment $documentId deleted successfully');
    } catch (e) {
      log('Error deleting appointment: $e');
    }
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
              // Doctor's Name, Profile Pic. & Search bar
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
              const SubHeadingWidget(subHeading: "  Recent Appointments"),
              const SizedBox(height: 15),

              // Wrapped Appointment - Fetching from Firestore
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Appointments')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("-No Appointments Found-"));
                  }

                  final appointments = snapshot.data!.docs;

                  if (appointments.isEmpty) {
                    return const Center(
                        child: Text("-No Appointments Available-"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointmentData = appointments[index];
                      final documentId = appointmentData.id;

                      // Cast the data to Map<String, dynamic>
                      final appointmentMap =
                          appointmentData.data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          print("Tapped on document: $documentId");
                          Navigator.pushNamed(
                            context,
                            "wrapped_appt_screen",
                            arguments: {
                              "documentId": documentId,
                              "TappedCardIndex": index,
                              "appointmentData": appointmentMap
                            },
                          );
                        },
                        child: WrappedApptView(
                          appointmentData: appointmentMap,
                          onDelete: () =>
                              deleteFirestoreAppointment(documentId),
                          index: index,
                        ),
                      );
                    },
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
