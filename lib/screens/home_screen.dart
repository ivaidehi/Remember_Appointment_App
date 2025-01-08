import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../myViews/wrapped_appt_view.dart';
import '../myWidgets/input_field_widget.dart';
import '../myWidgets/sub_heading_widget.dart';
import '../styles/app_styles.dart';
import '../gets/get_docnm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> filteredAppointments = [];
  List<DocumentSnapshot> allAppointments = []; // To hold all appointments

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterAppointments);
  }

  // Function to filter appointments based on patient name
  void _filterAppointments() {
    String query = _searchController.text.trim().toLowerCase();
    setState(() {
      filteredAppointments = allAppointments.where((appt) {
        final data = appt.data() as Map<String, dynamic>;
        final patientName = data['Patient Name']?.toLowerCase() ?? '';
        return patientName.contains(query);
      }).toList();
    });
  }

  // Function to delete an appointment from Firestore
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
          child: Column(
            children: [
              // Header: Doctor's Name, Profile Picture, and Search Bar
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                  // Search Bar
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: InputFieldWidget(
                      defaultHintText: "Search Appointment",
                      controller: _searchController,
                      requiredInput: 'Please enter valid text',
                      hideText: false,
                      suffixIcon: const Icon(Icons.search, color: Colors.grey,),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SubHeadingWidget(subHeading: "  Recent Appointments"),
              const SizedBox(height: 15),

              // Fetch Appointments from Firestore and Filter
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Appointments")
                      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    // Load appointments into `allAppointments` and `filteredAppointments`
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      allAppointments = snapshot.data!.docs;
                      filteredAppointments = filteredAppointments.isEmpty
                          ? allAppointments
                          : filteredAppointments;
                    } else {
                      return const Text("Appointments Not Available. ");
                    }
                    return ListView.builder(
                      itemCount: filteredAppointments.length,
                      itemBuilder: (context, index) {
                        final appointmentData =
                        filteredAppointments[index].data()
                        as Map<String, dynamic>;
                        final documentId = filteredAppointments[index].id;

                        return GestureDetector(
                          onTap: () {
                            print("Tapped on document: $documentId");
                            Navigator.pushNamed(
                              context,
                              "wrapped_appt_screen",
                              arguments: {
                                "documentId": documentId,
                                "TappedCardIndex": index,
                                "appointmentData": appointmentData,
                              },
                            );
                          },
                          child: WrappedApptView(
                            appointmentData: appointmentData,
                            onDelete: () => deleteFirestoreAppointment(documentId),
                            index: index,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}