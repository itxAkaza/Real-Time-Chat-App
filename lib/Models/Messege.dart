import 'package:cloud_firestore/cloud_firestore.dart';

class Messege {
  final String Senderid;
  final String SenderEmail;
  final String Reciverid;
  final String messege;
  final Timestamp timestamp;

  Messege({

    required this.Senderid,
    required this.SenderEmail,
    required this.Reciverid,
    required this.messege,
    required this.timestamp,

  });


  Map<String, dynamic> toMap() {
    return {
      "Senderid": Senderid,
      "SenderEmail": SenderEmail,
      "Reciverid": Reciverid,
      "messege": messege,
      "timestamp": timestamp,
    };
  }

}