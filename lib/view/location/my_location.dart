import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view/location/other_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/location_view_model.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            // padding: EdgeInsets.all(16.0),
            width: size.width,
            height: size.height * 0.45,
            child: const Image(
              // fit: BoxFit.fitHeight,
              image: AssetImage('assets/images/location.png'),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65),
            child: Column(
              children: const [
                Text(
                  'Where do you want to see jobs / services ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'To enjoy all that Bizhub has to other you, we need to know where to look for them.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Consumer<LocationViewModel>(
            builder: (context, provider, _) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 30,
                  bottom: 12,
                ),
                child: DeafultIconButton(
                  icon: CupertinoIcons.location,
                  isloading: provider.loading,
                  loadingTitle: 'Getting location',
                  title: 'Near me',
                  onPress: () {
                    provider.getMyLatLong(context: context);
                    // provider.getStoreLocationIfExist(context);
                    // provider.updateMyLocation();
                  },
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              // Navigator.pushNamed(
              //   context,
              //   RouteName.otherAddress,
              //   arguments: true,
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const MyOtherLocation(),
                  settings: const RouteSettings(
                    arguments: true,
                  ),
                ),
              );
            },
            child: const Text(
              'Other address',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
