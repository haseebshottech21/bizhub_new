import 'package:bizhub_new/view/posts/components/my_post_detail.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_loader.dart';

class MyJobDetail extends StatefulWidget {
  const MyJobDetail({
    required this.serviceId,
    Key? key,
  }) : super(key: key);

  final String serviceId;

  @override
  State<MyJobDetail> createState() => _MyJobDetailState();
}

class _MyJobDetailState extends State<MyJobDetail> {
  getMyPosterServiceDetail() async {
    final provider = Provider.of<MyServiceViewModel>(context, listen: false);
    await provider.getMyPostDetail(
      context: context,
      serviceId: widget.serviceId,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getMyPosterServiceDetail(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<MyServiceViewModel>(
            builder: (context, myServiceViewModel, _) {
              if (myServiceViewModel.loading) {
                return const CustomLoader();
              } else {
                return MyPostDetail(myServiceViewModel: myServiceViewModel);
              }
            },
          ),
        ],
      ),
    );
  }
}
