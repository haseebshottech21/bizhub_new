import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/view_model/all_services_view_model.dart';
// import 'package:bizhub_new/widgets/common/input_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPosts extends StatefulWidget {
  const SearchPosts({Key? key}) : super(key: key);

  @override
  State<SearchPosts> createState() => _SearchPostsState();
}

class _SearchPostsState extends State<SearchPosts> {
  final searchController = TextEditingController();

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     getAllServices();
  //   });
  //   super.initState();
  // }

  // Future<void> getAllServices() async {
  //   await Provider.of<AllServicesViewModel>(context, listen: false)
  //       .getAllServicesList(context);
  // }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.grey[50],
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     title: Expanded(
    //       child: InputTextfield(
    //         hintText: 'Search...',
    //         controller: searchController,
    //         icon: Icons.search,
    //       ),
    //     ),
    //   ),
    // );
    // final size = MediaQuery.of(context).size;

    // final allService = context

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
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextField(
              // controller: widget.controller,
              onChanged: (value) =>
                  context.read<AllServicesViewModel>().searchList(value),

              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  left: 15,
                  bottom: 12,
                  top: 12,
                  right: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
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
                  ),
                ),
                prefixText: '  ',
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.clear,
                    size: 18,
                  ),
                ),
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
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      title: Text(
                        allServiceViewModel.displayList[index].serviceTitle!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        allServiceViewModel.displayList[index].serviceAmount
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      // trailing: Text(
                      //   '${displayList[index].rating!}',
                      //   style: const TextStyle(
                      //     color: Colors.amber,
                      //   ),
                      // ),
                      leading: allServiceViewModel
                              .displayList[index].imagesList!.isNotEmpty
                          ? Image.network(
                              AppUrl.baseUrl +
                                  allServiceViewModel
                                      .displayList[index].imagesList![0].image
                                      .toString(),
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              color: Colors.greenAccent,
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
