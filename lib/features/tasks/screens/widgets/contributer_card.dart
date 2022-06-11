import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/tasks/models/task_member.dart';

class ContributerCard extends StatelessWidget {
  final TaskMember member;
  const ContributerCard({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: orange,
            child: CircleAvatar(
                radius: 28, backgroundImage: AssetImage(member.profilePicUrl!)),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                member.memberName,
                style:
                    const TextStyle(color: beg, fontFamily: font, fontSize: 16),
              ),
              Text(
                member.role!.name,
                style: const TextStyle(
                    color: beg,
                    fontFamily: font,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                      color: beg.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    (member.submited) ? 'Submited' : 'Not Yet',
                    style: const TextStyle(
                        color: beg, fontFamily: font, fontSize: 14),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
