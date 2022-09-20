import 'package:bizhub_new/widgets/common/input_textfield.dart';
import 'package:flutter/material.dart';

class SearchPosts extends StatefulWidget {
  const SearchPosts({Key? key}) : super(key: key);

  @override
  State<SearchPosts> createState() => _SearchPostsState();
}

class _SearchPostsState extends State<SearchPosts> {
  final searchController = TextEditingController();

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            snap: false,
            elevation: 0,
            // centerTitle: true,
            backgroundColor: Colors.white,
            // automaticallyImplyLeading: true,

            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
                size: 25,
              ),
            ),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            title: const Text('Serach'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 4,
                  left: 12,
                  right: 12,
                ),
                child: SizedBox(
                  height: size.height * 0.07,
                  // child: InputTextfield(
                  //   hintText: 'Serach',
                  //   controller: searchController,
                  //   icon: Icons.search,
                  // ),
                  child: TextField(
                    // controller: widget.controller,
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
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 30,
              top: 12,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: ClampingScrollPhysics(),
                  //   itemCount: 100,
                  //   itemBuilder: (context, index) {
                  //     return Text('data');
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
