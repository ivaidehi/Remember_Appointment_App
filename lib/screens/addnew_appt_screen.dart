import 'package:appointment_app/data/timeslots_list.dart';
import 'package:appointment_app/gets/get_date.dart';
import 'package:appointment_app/styles/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import '../gets/get_time.dart';
import '../myWidgets/dropdown_widget.dart';
import '../myWidgets/input_field_widget.dart';
import '../myWidgets/labels_widget.dart';
import '../services/twilio_service.dart';

class AddnewApptScreen extends StatefulWidget {
  String? documentID;

  AddnewApptScreen({super.key, String? documentID});

  @override
  State<AddnewApptScreen> createState() => _AddnewApptScreenState();
}

class _AddnewApptScreenState extends State<AddnewApptScreen> {
  late TwilioService twilioService;

  late String docID;

  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
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

  @override
  void didChangeDependencies() {
    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      nameInput.text = args['name'] ?? '';
      contactInput.text = args['contact'] ?? '';
      docID = args['documentID'] ??
          FirebaseFirestore.instance.collection('Appointments').doc().id;
      print("Document ID: $docID"); // Print the documentID for assurance
    }
    super.didChangeDependencies();
  }

  // Fetch blocked time slots for the current date
  Future<void> fetchBlockedTimeSlots() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Appointments")
        .doc('Blocked Time Slots')
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        blockedTimeSlots = data[formattedDate] != null
            ? Map<String, bool>.from(data[formattedDate])
            : {};
      });
    }
  }

  // Block the selected time slot in Firestore for the current date
  Future<void> permanentlyBlockTimeSlotInFirestore(String timeSlot) async {
    await FirebaseFirestore.instance
        .collection("Appointments")
        .doc('Blocked Time Slots')
        .set({
      formattedDate: {...blockedTimeSlots, timeSlot: true}
    }, SetOptions(merge: true));

    setState(() {
      blockedTimeSlots[timeSlot] = true;
    });
  }

  // Check if the selected time slot is already booked
  Future<bool> isTimeSlotAlreadyBooked(String timeSlot) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Appointments")
        .where("Selected Time Slot", isEqualTo: timeSlot)
        .where("Selected Date", isEqualTo: formattedDate)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  // Set appointment data in Firestore and allow appending duplicate values to fields
  Future<void> addNewApptData() async {
    if (_formKey.currentState?.validate() == true) {
      if (contactInput.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contact number cannot be empty.')),
        );
        return;
      }

      if (blockedTimeSlots[selectedTimeSlot] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Selected time slot is blocked, please choose another one.'),
          ),
        );
        return;
      }

      bool isBooked = await isTimeSlotAlreadyBooked(selectedTimeSlot ?? '');
      if (isBooked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selected time slot is already booked.'),
          ),
        );
        return;
      }

      if (selectedTimeSlot != null) {
        await permanentlyBlockTimeSlotInFirestore(selectedTimeSlot!);
      }

      // Retrieve existing data from Firestore and handle types properly
      final userDocumentRef =
          FirebaseFirestore.instance.collection('Appointments').doc(docID);
      final snapshot = await userDocumentRef.get();

      Map<String, dynamic> existingData = snapshot.data() ?? {};

      // Safely handle existing data and ensure it's a list
      List<dynamic> ensureList(dynamic field) {
        if (field == null) {
          return []; // Initialize as empty list if field is null
        }
        if (field is List) {
          return field; // Field is already a list
        }
        return [field]; // Wrap single value in a list
      }

      // Append new data to existing fields
      existingData['Selected Date'] = ensureList(existingData['Selected Date'])
        ..add(formattedDate);
      existingData['Day Part'] = ensureList(existingData['Day Part'])
        ..add(selectedDayparts);
      existingData['Selected Time Slot'] =
          ensureList(existingData['Selected Time Slot'])..add(selectedTimeSlot);
      existingData['Schedule Treatment'] =
          ensureList(existingData['Schedule Treatment'])
            ..add(scheduleTreatmentInput.text.trim());
      existingData['Note'] = ensureList(existingData['Note'])
        ..add(noteInput.text.trim());
      existingData['timestamp'] = ensureList(existingData['timestamp'])
        ..add(Timestamp.now());

      // Update Firestore with merged data
      await userDocumentRef.set(existingData, SetOptions(merge: true));

      await twilioService.sendSms(
        toNumber: contactInput.text.trim(),
        name: nameInput.text.trim(),
        date: formattedDate,
        timeSlot: selectedTimeSlot ?? '',
        context: context,
      );

      await twilioService.sendWhatsappMsg(
        toNumber: contactInput.text.trim(),
        name: nameInput.text.trim(),
        date: formattedDate,
        timeSlot: selectedTimeSlot ?? '',
        context: context,
      );

      // Clear input fields
      nameInput.clear();
      contactInput.clear();
      scheduleTreatmentInput.clear();
      noteInput.clear();
      setState(() {
        selectedDayparts = null;
        selectedTimeSlot = null;
      });

      // Notify user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment added successfully!')),
      );
    }
  }

  // Build time slot buttons and apply blocking/booked logic
  Future<List<Widget>> _buildTimeSlots() async {
    List<Widget> timeSlotAsPerDayparts = [];

    if (selectedDayparts != null && timeSlots.containsKey(selectedDayparts)) {
      for (var timeSlot in timeSlots[selectedDayparts]!) {
        bool isBooked = await isTimeSlotAlreadyBooked(timeSlot);
        bool isBlocked = blockedTimeSlots[timeSlot] ?? false;
        bool isTapped = selectedTimeSlot == timeSlot;

        timeSlotAsPerDayparts.add(
          GetApptTime(
            selectedTime: timeSlot,
            onTimeSelected: (selectedTime) {
              // Set selected time slot without blocking it immediately
              setState(() {
                selectedTimeSlot = selectedTime; // Store selected time slot
              });
            },
            isTimeSlotBooked: isBooked,
            isTimeSlotBlocked: isBlocked,
            isTimeSlotTapped: isTapped,
          ),
        );
      }
    }
    return timeSlotAsPerDayparts;
  }

  @override
  void initState() {
    fetchBlockedTimeSlots();
    super.initState();
    docID = widget.documentID ??
        FirebaseFirestore.instance.collection('Appointments').doc().id;
    // Assign the passed documentID to docID

    twilioService = TwilioService(
      accountSID: dotenv.env['TWILIO_ACCOUNT_SID'] ?? '',
      authToken: dotenv.env['TWILIO_AUTH_TOKEN'] ?? '',
      smsTwilioNumber: dotenv.env['TWILIO_PHONE_NUMBER'] ?? '',
      whatsappTwilioNumber: dotenv.env['TWILIO_WHATSAPP_NUMBER'] ?? '',
    );
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
            Navigator.pop(
                context); // Change this line to pop the current screen
          },
        ),
        title: Text(
          'Add New Appointment',
          style: TextStyle(color: AppStyles.primary).copyWith(fontSize: 18),
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
                  isReadOnly: true,
                  isEnabled: false,
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
                  isReadOnly: true,
                  isEnabled: false,
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
                    formattedDate = DateFormat('dd-MM-yyyy').format(date);
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
                const LabelsWidget(label: 'Select Time Slot'),
                const SizedBox(height: 10),
                FutureBuilder<List<Widget>>(
                  future: _buildTimeSlots(),
                  builder: (context, snapshot) {
                    if (selectedDayparts == null) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                // color: Colors.grey.withOpacity(0.3),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                // color: Colors.grey.withOpacity(0.3),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return Wrap(
                        spacing: 5,
                        children: snapshot.data!,
                      );
                    } else {
                      return const Text('Error loading time slots.');
                    }
                  },
                ),
                const SizedBox(height: 20),
                const LabelsWidget(label: 'Schedule Treatment'),
                const SizedBox(height: 10),
                InputFieldWidget(
                  defaultHintText: 'Schedule Treatment',
                  controller: scheduleTreatmentInput,
                  requiredInput: 'Schedule Treatment',
                  hideText: false,
                  keyBoardType: TextInputType.multiline,
                ),
                const SizedBox(height: 20),
                const LabelsWidget(label: 'Note'),
                const SizedBox(height: 10),
                InputFieldWidget(
                  defaultHintText: 'Additional Notes',
                  controller: noteInput,
                  requiredInput: 'Additional Notes',
                  hideText: false,
                  keyBoardType: TextInputType.multiline,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 50),
                    backgroundColor: AppStyles.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Adjust the radius value as needed
                    ),
                  ),
                  onPressed: addNewApptData,
                  child: Text(
                    'Set Appointment',
                    style: AppStyles.headLineStyle3.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
