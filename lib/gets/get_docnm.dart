import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/app_styles.dart';

class GetDoctorfnm extends StatefulWidget {

  const GetDoctorfnm({super.key});

  @override
  State<GetDoctorfnm> createState() => _GetDoctorfnmState();
}

class _GetDoctorfnmState extends State<GetDoctorfnm> {
  String? userfname;
  String? userRole;

  @override
  void initState() {
    super.initState();
    getDocfname();
  }

  Future<void> getDocfname() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email)
          .get();

      setState(() {
        userfname = doc.get('First Name');
        userRole = doc.get('Role');
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${userRole == 'As a Receptionist' ? '': 'Dr.'} $userfname",
      style: AppStyles.headLineStyle1.copyWith(color: AppStyles.primary),
    );
  }
}
