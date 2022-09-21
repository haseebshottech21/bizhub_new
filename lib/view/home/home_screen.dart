import 'package:bizhub_new/utils/dummy_data.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view/home/components/all_posts_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    // );

    final size = MediaQuery.of(context).size;

    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        // return Scaffold(
        //   backgroundColor: Colors.grey[200],
        //   appBar: myAppBar(context: context, appBarTitle: 'Earn Money'),
        //   body: GridView(
        //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: isPortrait ? 2 : 3,
        //       mainAxisSpacing: 8,
        //       crossAxisSpacing: 8,
        //     ),
        //     children: List.generate(
        //       9,
        //       (index) {
        //         return jobItem();
        //       },
        //     ),
        //   ),
        // );
        return Scaffold(
          backgroundColor: Colors.grey[50],
          resizeToAvoidBottomInset: true,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                elevation: 0,
                // centerTitle: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                title: GestureDetector(
                  onTap: () {
                    selectTypeBottom();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('Earn Money'),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 22,
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(55.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4,
                      left: 12,
                      right: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.searchPost);
                          },
                          child: Container(
                            width: size.width * 0.80,
                            height: size.height * 0.05,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.search,
                                  size: 22,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Find Jobs, Service and more',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.045,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RouteName.filter);
                            },
                            color: MyTheme.greenColor,
                            padding: EdgeInsets.zero,
                            icon:
                                const Icon(CupertinoIcons.slider_horizontal_3),
                          ),
                        ),
                      ],
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
                      GridView.builder(
                        addAutomaticKeepAlives: true,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: 9,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isPortrait ? 2 : 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return const AllPostsItem();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  selectTypeBottom() {
    // List typeList = ['Jobs Near By', 'Service Near By'];
    final typeList = getType();
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      // isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (context) {
        // print(object)

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 15,
                  left: 12,
                  right: 12,
                ),
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 20),
                child: Column(
                  children: List.generate(
                    typeList.length,
                    (i) {
                      return type(
                        typeText: typeList[i].typeTitle,
                        typeIcon: typeList[i].typeIcon,
                        isSelected: typeList[i].typeSelect,
                        onTap: () {
                          // setState(() {
                          //   typeList[index].typeSelect =
                          //       !typeList[index].typeSelect;
                          //   print(typeList[index].typeSelect);
                          // });
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  InkWell type({
    required String typeText,
    required IconData typeIcon,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return InkWell(
      // onTap: () {
      //   // serviceType.todo(true, context);
      //   setState(() {
      //     isSelected = !isSelected;
      //     print(isSelected);
      //   });
      // },
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Row(
          children: [
            Icon(
              typeIcon,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              typeText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              isSelected
                  ? CupertinoIcons.checkmark_alt_circle_fill
                  : CupertinoIcons.circle,
              color: MyTheme.greenColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
