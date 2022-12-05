import 'package:flutter/material.dart';

class MessageBottom extends StatelessWidget {
  const MessageBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.only(
            right: 8,
            left: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 15 : 20,
            top: 8,
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          splashRadius: 20,
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey.shade700,
                            size: 28,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            child: TextField(
                              // controller: textController,
                              minLines: 1,
                              maxLines: 5,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                  right: 16,
                                  left: 20,
                                  bottom: 10,
                                  top: 10,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                                hintText: 'Type a message',
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 0,
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 0,
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              onChanged: (value) {
                                // if (value.length > 0) {
                                //   hideTheMic();
                                // } else {
                                //   showTheMic();
                                // }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    splashRadius: 20,
                    icon: Icon(
                      Icons.send,
                      // color: isVisible
                      //     ? Colors.grey.shade700
                      //     : Colors.blue,
                      color: Colors.grey.shade700,
                    ),
                    onPressed: () {
                      // if (textController.text.length > 0) {
                      //   addToMessages(textController.text);
                      //   textController.clear();
                      //   showTheMic();
                      // }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
