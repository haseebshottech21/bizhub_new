import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../components/poster_detail_body.dart';

// class MyJobDetail extends StatefulWidget {
//   const MyJobDetail({
//     Key? key,
//     required this.arguments,
//   }) : super(key: key);

//   final ScreenArguments arguments;

//   @override
//   State<MyJobDetail> createState() => _MyJobDetailState();
// }

// class _MyJobDetailState extends State<MyJobDetail> {
//   // Future<void> getMyPosterServiceDetail() async {
//   //   // String serviceId = ModalRoute.of(context)!.settings.arguments as String;

//   //   // final arguments = ModalRoute.of(context)!.settings.arguments as Map;

//   //   final Map<String, dynamic>? args =
//   //       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

//   //   var id = args!['id'];

//   //   // print("Route name is:");
//   //   // print(ModalRoute.of(context)!.settings.arguments);
//   //   print("id " + id);

//   //   // final provider = Provider.of<MyServiceViewModel>(context, listen: false);
//   //   // provider.getMyPosterServiceDetail(
//   //   //   context: context,
//   //   // );
//   // }

//   @override
//   void initState() {
//     // print(widget.arguments!.id.toString());
//     super.initState();
//   }

//   // @override
//   // void initState() {
//   //   super.initState();

//   //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//   //     getMyPosterServiceDetail();
//   //   });

//   //   // how can I pass the argument id and argument name to the function?
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<MyServiceViewModel>(
//         builder: (context, serviceViewModel, _) {
//           if (serviceViewModel.loading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           // print(widget.arguments.id.toString());
//           return MyJobDetailBody(myServiceViewModel: serviceViewModel);
//         },
//       ),
//     );
//   }
// }

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
            return MyJobDetailBody(myServiceViewModel: serviceViewModel);
          }
        },
      ),
    );
  }
}
