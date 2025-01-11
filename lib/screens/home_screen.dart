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
  List<DocumentSnapshot> allAppointments = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterAppointments);
  }

  void _filterAppointments() {
    String query = _searchController.text.trim().toLowerCase();
    setState(() {
      filteredAppointments = allAppointments.where((appt) {
        final data = appt.data() as Map<String, dynamic>;
        final patientNames = data['Patient Name'] as List<dynamic>? ?? [];
        return patientNames.any((name) =>
            name.toString().toLowerCase().contains(query));
      }).toList();
    });
  }

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
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: InputFieldWidget(
                      defaultHintText: "Search Appointment",
                      controller: _searchController,
                      requiredInput: 'Please enter valid text',
                      hideText: false,
                      suffixIcon: const Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SubHeadingWidget(subHeading: "  Recent Appointments"),
              const SizedBox(height: 15),
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

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("Appointments Not Available."));
                    }

                    // Ensure allAppointments is refreshed with new data
                    final allAppointments = snapshot.data!.docs;

                    // Keep filteredAppointments synchronized with the stream
                    filteredAppointments = List.from(allAppointments);

                    return RefreshIndicator(
                      color: AppStyles.primary,
                      backgroundColor: AppStyles.bgColor,
                      onRefresh: () async {
                        // Trigger the stream to refresh
                        setState(() {
                          filteredAppointments = List.from(allAppointments);
                        });
                        await Future.delayed(const Duration(milliseconds: 500));
                      },
                      child: ListView.builder(
                        itemCount: filteredAppointments.length,
                        itemBuilder: (context, index) {
                          final appointmentData =
                          filteredAppointments[index].data() as Map<String, dynamic>;
                          final documentId = filteredAppointments[index].id;

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "wrapped_appt_screen",
                                arguments: {
                                  "documentID": documentId,
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
                      ),
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
