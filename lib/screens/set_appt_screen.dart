import 'package:appointment_app/data/timeslots_list.dart';
import 'package:appointment_app/gets/get_date.dart';
import 'package:appointment_app/gets/get_time.dart';
import 'package:appointment_app/styles/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
  var scheduleTreatmentInput = TextEditingController();
  var noteInput = TextEditingController();

  String? selectedDayparts;
  var dayPartsList = ['Morning', 'Afternoon', 'Evening'];

  DateTime? selectedDate;

  Map<String, bool> blockedTimeSlots = {};
  String? selectedTimeSlot;

  final _formKey = GlobalKey<FormState>();

  // Fetch globally blocked time slots
  Future<void> fetchBlockedTimeSlots() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Appointments")
        .doc('Blocked Time Slots')
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['Blocked Time Slots'] != null) {
        setState(() {
          blockedTimeSlots = Map<String, bool>.from(data['Blocked Time Slots']);
        });
      }
    }
  }

  /// Permanently block the selected time slot in Firestore
  Future<void> permanentlyBlockTimeSlotInFirestore(String timeSlot) async {
    await FirebaseFirestore.instance
        .collection("Appointments")
        .doc('Blocked Time Slots')
        .set({
      'Blocked Time Slots.$timeSlot': true,
    }, SetOptions(merge: true));
  }

  /// Check if the time slot is already booked
  Future<bool> isTimeSlotAlreadyBooked(String timeSlot) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Appointments")
        .where("Selected Time Slot", isEqualTo: timeSlot)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  /// Function to set appointment data
  Future<void> setApptData() async {
    if (_formKey.currentState?.validate() == true) {
      // Check if the contact number is empty
      if (contactInput.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contact number cannot be empty.'),
          ),
        );
        return;
      }

      // Check if the selected time slot is blocked
      if (blockedTimeSlots[selectedTimeSlot] == true &&
          blockedTimeSlots[selectedTimeSlot] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Selected time slot is blocked, please choose another one.'),
          ),
        );
        return;
      }

      // Check if the selected time slot is already booked
      bool isBooked = await isTimeSlotAlreadyBooked(selectedTimeSlot ?? '');
      if (isBooked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Selected time slot is already Booked.'),
          ),
        );
        return;
      }

      // Block the time slot permanently in Firestore
      if (selectedTimeSlot != null) {
        await permanentlyBlockTimeSlotInFirestore(selectedTimeSlot!);
      }

      // Save appointment data to Firestore
      await FirebaseFirestore.instance
          .collection("Appointments")
          .doc(contactInput.text.trim()) // Unique user document
          .set({
        'Patient Name': nameInput.text.trim(),
        'Phone no.': contactInput.text.trim(),
        'Selected Date': selectedDate.toString(),
        'Day Part': selectedDayparts.toString(),
        'Selected Time Slot': selectedTimeSlot,
        'Schedule Treatment': scheduleTreatmentInput.text.trim(),
        'Note': noteInput.text.trim(),
      });

      // Clear form after submission
      nameInput.clear();
      contactInput.clear();
      scheduleTreatmentInput.clear();
      noteInput.clear();
      setState(() {
        selectedDayparts = null;
        // selectedDate = null;
        // selectedTimeSlot = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment set successfully!')),
      );
    }
  }

  Future<List<Widget>> _buildTimeSlots() async {
    List<Widget> timeSlotAsPerDayparts = [];

    if (selectedDayparts != null && timeSlots.containsKey(selectedDayparts)) {
      for (var timeSlot in timeSlots[selectedDayparts]!) {
        bool isBooked = await isTimeSlotAlreadyBooked(timeSlot); // Check if it's booked

        timeSlotAsPerDayparts.add(
          GetApptTime(
            selectedTime: timeSlot,
            onTimeSelected: (selectedTime) {
              // Check if the time slot is blocked
              if (blockedTimeSlots[selectedTime] == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This time slot is already booked.'),
                  ),
                );
              } else {
                // Block the time slot immediately in the local map
                setState(() {
                  blockedTimeSlots[selectedTime] = true;
                  selectedTimeSlot = selectedTime;
                });

                // After blocking locally, send the update to Firestore
                permanentlyBlockTimeSlotInFirestore(selectedTime);
              }
            },
            isTimeSlotBlocked: blockedTimeSlots[timeSlot] ?? false,
            isTimeSlotBooked: isBooked, // Pass the booked status
          ),
        );
      }
    }

    return timeSlotAsPerDayparts;
  }

  //Hello world
  @override
  void initState() {
    super.initState();
    fetchBlockedTimeSlots(); // Fetch globally blocked time slots
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelsWidget(label: 'Name'),
                const SizedBox(height: 10),
                InputFieldWidget(
                  defaultHintText: 'Enter Name',
                  controller: nameInput,
                  requiredInput: 'Name',
                  hideText: false,
                ),
                const SizedBox(height: 20),
                const LabelsWidget(label: 'Contact'),
                const SizedBox(height: 10),
                InputFieldWidget(
                  defaultHintText: 'Enter Contact No.',
                  controller: contactInput,
                  requiredInput: 'Contact No.',
                  hideText: false,
                  onlyInt: FilteringTextInputFormatter.digitsOnly,
                  keyBoardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const LabelsWidget(label: 'Date : '),
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: AppStyles.headLineStyle3
                          .copyWith(color: AppStyles.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GetApptDate(onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                }),
                const SizedBox(height: 10),
                const LabelsWidget(label: 'Day Part'),
                const SizedBox(height: 10),
                DropdownWidget(
                  itemList: dayPartsList,
                  selectedItem: selectedDayparts,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDayparts = newValue;
                    });
                    fetchBlockedTimeSlots();
                  },
                  select: 'Morning',
                ),
                const SizedBox(height: 20),
                const LabelsWidget(label: 'Time Slots '),
                const SizedBox(height: 10),
                FutureBuilder<List<Widget>>(
                  future: _buildTimeSlots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text('Error loading time slots');
                    }
                    return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: snapshot.data ?? []);
                  },
                ),
                const SizedBox(height: 20),
                const LabelsWidget(label: 'Schedule Treatment'),
                const SizedBox(height: 10),
                InputFieldWidget(
                  defaultHintText: 'Enter Treatment',
                  controller: scheduleTreatmentInput,
                  requiredInput: 'Schedule Treatment',
                  hideText: false,
                ),
                const SizedBox(height: 20),
                const LabelsWidget(label: 'Notes'),
                const SizedBox(height: 10),
                InputFieldWidget(
                  defaultHintText: 'Add a Note (optional)',
                  controller: noteInput,
                  requiredInput: 'Note',
                  hideText: false,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.primary,
                  ),
                  onPressed: setApptData,
                  child: Text(
                    'Set Appointment',
                    style: AppStyles.headLineStyle3.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
