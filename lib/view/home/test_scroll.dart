import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../utils/app_url.dart';
import '../../view_model/all_services_view_model.dart';

class TestScroll extends StatefulWidget {
  const TestScroll({Key? key}) : super(key: key);

  @override
  State<TestScroll> createState() => _TestScrollState();
}

class _TestScrollState extends State<TestScroll> {
  // final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final _baseUrlNew = 'https://dev.bizhub.ai/bizhub/public/api/service';

  // '?page=2&type=0'

  int _page = 1;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;

  List _posts = [];

  late ScrollController _controller;

  var next;

  // bool get kDebugMode => null;

  void _loadMore() async {
    if (next != '' &&
        _hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http.get(
          Uri.parse("$_baseUrlNew?page=$_page&type=0"),
          headers: await AppUrl().headerWithAuth(),
        );

        print("$_baseUrlNew?page=$_page&type=0");
        final loadedData = json.decode(res.body);

        next = loadedData['links']['next'];
        final List fetchedPosts = loadedData['data'];
        print(next);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // void _firstLoad() async {
  //   // _posts.clear();
  //   setState(() {
  //     _isFirstLoadRunning = true;
  //   });

  //   // _isFirstLoadRunning = true;

  //   try {
  //     final res = await http.get(
  //       Uri.parse("$_baseUrlNew?&type=0"),
  //       headers: await AppUrl().headerWithAuth(),
  //     );

  //     // print(res.body);

  //     final loadedData = json.decode(res.body);

  //     setState(() {
  //       _posts = loadedData['data'];
  //       // print(_posts);
  //     });
  //   } catch (err) {
  //     if (kDebugMode) {
  //       print('Something went wrong');
  //     }
  //   }

  //   setState(() {
  //     _isFirstLoadRunning = false;
  //   });

  //   // _isFirstLoadRunning = false;
  // }

  // late ScrollController controller;

  @override
  void initState() {
    super.initState();
    // _firstLoad();
    getAllServices();
    final provider = Provider.of<AllServicesViewModel>(context, listen: false);
    provider.controller = ScrollController()
      ..addListener(provider.getAllServiceMore);
  }

  Future<void> getAllServices() async {
    await Provider.of<AllServicesViewModel>(context, listen: false)
        .getAllService();
  }

  // Future<void> getAllServicesMore() async {
  //   await Provider.of<AllServicesViewModel>(context, listen: false)
  //       .getAllServiceMore();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllServicesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your news',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: provider.isFirstLoadRunning
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: _posts.length,
                //     controller: _controller,
                //     itemBuilder: (_, index) => Card(
                //       margin: const EdgeInsets.symmetric(
                //           vertical: 8, horizontal: 10),
                //       child: ListTile(
                //         title: Text(
                //           _posts[index]['title'],
                //           style: const TextStyle(color: Colors.black),
                //         ),
                //         subtitle: Text(
                //           _posts[index]['amount'].toString(),
                //           style: const TextStyle(color: Colors.black),
                //         ),
                //         trailing: Text(
                //           index.toString(),
                //           style: const TextStyle(color: Colors.black),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: GridView.builder(
                    controller: provider.controller,
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: provider.posts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      // if (index <
                      //     allServiceViewModel
                      //         .allServiceList.length) {
                      // print(allServiceViewModel.hasmore);
                      // return AllServiceIem(
                      //   serviceModel: allServiceViewModel.allServiceList[index],
                      //   index: index,
                      // );

                      return Card(
                        child: Column(
                          children: [
                            Text(
                              provider.posts[index].serviceTitle.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                      // }

                      //else {
                      //   print(allServiceViewModel.hasmore);
                      //   return Padding(
                      //     padding:
                      //         const EdgeInsets.symmetric(
                      //             vertical: 32.0),
                      //     child: Center(
                      //       child: allServiceViewModel
                      //               .hasmore
                      //           ? const CircularProgressIndicator()
                      //           : const Text(
                      //               'No More Data'),
                      //     ),
                      //   );
                      // }
                    },
                  ),
                ),
                if (provider.isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (provider.hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }
}
