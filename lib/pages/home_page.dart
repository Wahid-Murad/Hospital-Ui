import 'package:day25/my_db/db.dart';
import 'package:day25/widgets/hospital_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double pageNumber = 0.0;
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 1);
    pageController!.addListener(() {
      setState(() {
        pageNumber = pageController!.page!;
      });
    });
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              itemBuilder: (context, index) =>
              HospitalItem(hospitals[index], pageNumber, index.toDouble()),
              controller: pageController,
              itemCount: hospitals.length,
              ),
          ],
        ),
      ),
    );
  }
}