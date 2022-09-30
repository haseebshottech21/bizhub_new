import 'package:flutter/material.dart';
import '../components/rate_review.dart';

class JobComplete extends StatelessWidget {
  const JobComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );

    const nameStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: const Text(
          'Mark as Complete',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _uiTop(size),
            const SizedBox(height: 20),
            const Text('Who can complete your job ?', style: titleStyle),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 5,
              itemBuilder: (context, index) {
                index = index + 1;
                return GestureDetector(
                  onTap: () {
                    rateReviewDialog(
                      status: '1',
                      userName: 'John Cary',
                      context: context,
                    );
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/job2.jpg'),
                    ),
                    title: Text(
                      'Username $index',
                      style: nameStyle,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _uiTop(Size size) {
    return SizedBox(
      height: size.height * 0.12,
      // padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      // color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height * 0.50,
            width: size.width * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/job2.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.65,
                child: const Text(
                  'I will create your bussiness webiste with new features asdasd asdasdasd',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                '\$ 50',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
