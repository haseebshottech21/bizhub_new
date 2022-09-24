import 'package:flutter/material.dart';

import '../../../utils/mytheme.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 20,
              left: 12,
              right: 12,
            ),
            child: Center(
              child: Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const Text(
            'Enter Your Message',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: messageController,
            style: const TextStyle(color: Colors.black),
            cursorColor: MyTheme.greenColor,
            autofocus: true,
            // keyboardType: TextInputType.multiline,
            // maxLines: null,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 15,
                bottom: 10,
                top: 10,
                right: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: MyTheme.greenColor,
                ),
              ),
              hintText: 'Send your message',
              // hintStyle: const TextStyle(color: Colors.black45),
              fillColor: Colors.white,
              filled: true,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.only(left: 12),
              //   child: Icon(
              //     widget.icon,
              //     color: MyTheme.greenColor,
              //   ),
              // ),
              prefixText: ' ',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // var task = Task(title: titileController.text);
                  // context.read<TaskBloc>().add(AddTask(task: task));
                  Navigator.pop(context);
                },
                child: const Text('Send'),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
