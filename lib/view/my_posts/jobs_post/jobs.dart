import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/common/skelton.dart';
import '../components/post_item.dart';

class JobsPost extends StatefulWidget {
  const JobsPost({Key? key}) : super(key: key);

  @override
  State<JobsPost> createState() => _JobsPostState();
}

class _JobsPostState extends State<JobsPost> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MyServiceViewModel>(context, listen: false)
          .getMyPoseterServiceList(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    // final postViewModel = context.watch<PostViewModel>();

    return Consumer<MyServiceViewModel>(
      builder: (context, postView, _) {
        return postView.posterServiceList.isEmpty
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
                itemCount: postView.posterServiceList.length,
                itemBuilder: (context, index) {
                  return JobPostItem(myJob: postView.posterServiceList[index]);
                },
              );
      },
    );
  }
}
