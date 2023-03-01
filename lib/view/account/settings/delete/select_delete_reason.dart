import 'package:flutter/material.dart';
import '../../../../components/deafult_button.dart';
import '../../../../language/language_constant.dart';
import '../../../../utils/mytheme.dart';
import '../../../../utils/routes/routes_name.dart';

class SelectDeleteReason extends StatefulWidget {
  const SelectDeleteReason({Key? key}) : super(key: key);

  @override
  State<SelectDeleteReason> createState() => _SelectDeleteReasonState();
}

class _SelectDeleteReasonState extends State<SelectDeleteReason> {
  List<RadioModel> reasonData = [];
  bool buttonEnable = false;

  @override
  void initState() {
    super.initState();
    reasonData.add(RadioModel(false, 'Did not find services'));
    reasonData.add(RadioModel(false, 'Don’t have use for the app'));
    reasonData.add(RadioModel(false, 'I don’t understand how to use app'));
    reasonData.add(RadioModel(false, 'Other'));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: MyTheme.greenColor,
        title: Text(
          translation(context).deleteAccount,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              translation(context).selectReason,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: size.width * 0.85,
                      child: const Divider(),
                    )
                  ],
                ),
              );
            },
            padding: EdgeInsets.zero,
            itemCount: reasonData.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                // highlightColor: Colors.red,
                splashColor: Colors.transparent.withOpacity(0.1),
                onTap: () {
                  setState(() {
                    for (var element in reasonData) {
                      element.isSelected = false;
                      buttonEnable = true;
                    }
                    reasonData[index].isSelected = true;
                  });
                  // print(reasonData[index].reasonText);
                },
                child: ReasonItem(radioModel: reasonData[index]),
              );
            },
          ),
          if (buttonEnable)
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 60, 60, 0),
              child: DeafultButton(
                title: '${translation(context).continueTxt}...',
                onPress: () {
                  Navigator.pushNamed(context, RouteName.confirmDelete);
                  // print(post.isPoster);
                },
                // onPress: null,
              ),
            )
        ],
      ),
    );
  }
}

class ReasonItem extends StatelessWidget {
  final RadioModel radioModel;
  const ReasonItem({
    Key? key,
    required this.radioModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Container(
            height: 26.0,
            width: 26.0,
            decoration: BoxDecoration(
              color: radioModel.isSelected ? MyTheme.greenColor : Colors.white,
              border: Border.all(
                width: 1.0,
                color: radioModel.isSelected ? Colors.transparent : Colors.grey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              // shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Text(radioModel.reasonText, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String reasonText;

  RadioModel(this.isSelected, this.reasonText);
}
