import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MakeOffer extends StatelessWidget {
  const MakeOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController offerController = TextEditingController();
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 16.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 20,
              left: 12,
              right: 12,
            ),
            child: Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const Text(
            'Enter Your Offer',
            style: TextStyle(fontSize: 24),
          ),
          TextField(
            controller: offerController,
            style: const TextStyle(color: Colors.black, fontSize: 36),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            autofocus: true,
            // cursorColor: Colors.transparent,
            keyboardType: TextInputType.number,
            showCursor: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(7),
            ],
            decoration: const InputDecoration(
              hintText: '\$ 0',
              hintStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // var task = Task(title: titileController.text);
                  // context.read<TaskBloc>().add(AddTask(task: task));
                  Navigator.pop(context);
                },
                child: const Text('Send Offer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
