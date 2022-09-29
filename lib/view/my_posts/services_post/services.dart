import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/my_service_view_model.dart';
import '../../../widgets/common/skelton.dart';
import '../components/worker_service_item.dart';

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
        return postView.workerServiceList.isEmpty
            ? ListView.separated(
                padding: const EdgeInsets.all(12.0),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const PostItemSkelton();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                // physics: const ClampingScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.all(8.0),
                itemCount: postView.workerServiceList.length,
                itemBuilder: (context, index) {
                  return WorkerServiceItem(
                    myWorkerService: postView.workerServiceList[index],
                  );
                },
              );
      },
    );
  }
}
