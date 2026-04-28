import 'package:flutter/material.dart';

class AppBarMessage2 extends StatelessWidget {
  const AppBarMessage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: const NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'David Wayne',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        '(+44) 50 9285 3022',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.videocam_outlined,
                      color: Colors.black, size: 26),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.call_outlined,
                      color: Colors.black, size: 22),
                ),
              ],
            ),
          );
  }
}