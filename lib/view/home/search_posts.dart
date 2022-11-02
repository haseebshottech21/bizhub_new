import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view_model/all_services_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'all_service_detail_screen.dart';

class SearchPosts extends StatefulWidget {
  const SearchPosts({Key? key}) : super(key: key);

  @override
  State<SearchPosts> createState() => _SearchPostsState();
}

class _SearchPostsState extends State<SearchPosts> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Search Service',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: TextField(
              // controller: searchController,
              onChanged: (value) =>
                  context.read<AllServicesViewModel>().searchList(value),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  bottom: 12,
                  top: 12,
                  right: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.black45),
                fillColor: Colors.grey.shade50,
                filled: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.search,
                    color: MyTheme.greenColor,
                  ),
                ),
                prefixText: ' ',
                // suffixIcon: const Padding(
                //   padding: EdgeInsets.only(right: 4),
                //   child: Icon(
                //     Icons.clear,
                //     size: 18,
                //     color: MyTheme.greenColor,
                //   ),
                // ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<AllServicesViewModel>(
              builder: (context, allServiceViewModel, _) {
                if (allServiceViewModel.displayList.isEmpty) {
                  return const Center(
                    child: Text(
                      'Not result found',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: allServiceViewModel.displayList.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        // print(allServiceViewModel.displayList[index].serviceId);
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => PostJobDetail(
                        //       serviceId: allServiceViewModel
                        //           .displayList[index].serviceId
                        //           .toString(),
                        //     ),
                        //   ),
                        // );
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                        title: Text(
                          allServiceViewModel.displayList[index].serviceTitle!,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          '\$ ${allServiceViewModel.displayList[index].serviceAmount.toString()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        leading: allServiceViewModel
                                .displayList[index].imagesList!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  AppUrl.baseUrl +
                                      allServiceViewModel.displayList[index]
                                          .imagesList![0].image
                                          .toString(),
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                color: Colors.greenAccent,
                              ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
