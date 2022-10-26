import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/my_service_view_model.dart';
import '../../../widgets/common/skelton.dart';
import '../components/my_post_item.dart';

class MyWorkerServices extends StatefulWidget {
  const MyWorkerServices({Key? key}) : super(key: key);

  @override
  State<MyWorkerServices> createState() => _MyWorkerServicesState();
}

class _MyWorkerServicesState extends State<MyWorkerServices> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MyServiceViewModel>(context, listen: false)
          .getMyWorkerServiceList(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyServiceViewModel>(
      builder: (context, postView, _) {
        if (postView.loading) {
          return ListView.separated(
            padding: const EdgeInsets.all(12.0),
            itemCount: 8,
            itemBuilder: (context, index) {
              return const PostItemSkelton();
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          );
        } else if (postView.workerServiceList.isEmpty) {
          return const Center(
            child: Text(
              'No Service Available',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(8.0),
            itemCount: postView.workerServiceList.length,
            itemBuilder: (context, index) {
              return MyPostItem(
                serviceModel: postView.workerServiceList[index],
                myServices: true,
              );
            },
          );
        }
      },
    );
  }
}
