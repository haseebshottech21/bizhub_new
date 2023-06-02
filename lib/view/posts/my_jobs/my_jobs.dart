import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/no_internet.dart';
import '../../../utils/dynamic_links.dart';
import '../../../widgets/common/skelton.dart';
import '../components/my_post_job_item.dart';

class JobsPost extends StatefulWidget {
  const JobsPost({Key? key}) : super(key: key);

  @override
  State<JobsPost> createState() => _JobsPostState();
}

class _JobsPostState extends State<JobsPost> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyPostserList();
    });
    super.initState();
  }

  Future<void> getMyPostserList() async {
    await Provider.of<MyServiceViewModel>(context, listen: false)
        .getMyPosterServiceList(context: context);
  }

  @override
  Widget build(BuildContext context) {
    // final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    // final postViewModel = context.watch<PostViewModel>();

    return Consumer<MyServiceViewModel>(
      builder: (context, postView, _) {
        if (postView.isInternetConnect) {
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
          } else if (postView.posterServiceList.isEmpty) {
            return const Center(
              child: Text(
                'No Job Available',
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
              // physics: const ClampingScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.all(8.0),
              itemCount: postView.posterServiceList.length,
              itemBuilder: (context, index) {
                return MyPostJobItem(
                  serviceModel: postView.posterServiceList[index],
                );
              },
            );
          }
        } else {
          return NoInternetWidget(
            onPressed: () async {
              postView.noInternetAndGetJobs(context: context);
            },
          );
        }
      },
    );
  }
}
