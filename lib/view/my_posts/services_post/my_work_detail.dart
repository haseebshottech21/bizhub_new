import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/my_service_view_model.dart';
import '../components/worker_detail_body.dart';

class MyWorkDetail extends StatefulWidget {
  const MyWorkDetail({Key? key, required this.serviceId}) : super(key: key);

  final String serviceId;

  @override
  State<MyWorkDetail> createState() => _MyWorkDetailState();
}

class _MyWorkDetailState extends State<MyWorkDetail> {
  getMyPosterServiceDetail() async {
    final provider = Provider.of<MyServiceViewModel>(context, listen: false);
    await provider.getMyPosterServiceDetail(
      context: context,
      serviceId: widget.serviceId,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getMyPosterServiceDetail());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MyServiceViewModel>(
        builder: (context, serviceViewModel, _) {
          if (serviceViewModel.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return MyWorkerDetailBody(myServiceViewModel: serviceViewModel);
          }
        },
      ),
    );
  }
}
