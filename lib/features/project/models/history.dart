import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history.g.dart';

@JsonSerializable(explicitToJson: true)
class History {
  String? id;
  String contant;
  DateTime date;
  String imageUrl;

  History(
      {this.id,
      required this.contant,
      required this.date,
      required this.imageUrl});

  getTime() {
    return DateFormat('hh:mm a').format(date).toString();
  }

  getDate() {
    return DateFormat('dd/MM/yyyy').format(date).toString();
  }

// date.year.toString() +
//         "-" +
//         date.month.toString() +
//         "-" +
//         date.day.toString() +
  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);

  factory History.fromFirestore(DocumentSnapshot documentSnapshot) {
    History history =
        History.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    history.id = documentSnapshot.id;
    return history;
  }
}
