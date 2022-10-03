import 'dart:html';
import 'dart:math';

import 'package:day25/models/hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HospitalItem extends StatefulWidget {
  
  final Hospital hospital;
  final double pageNumber;
  final double index;
  HospitalItem(this.hospital,this.pageNumber,this.index);
  @override
  State<HospitalItem> createState() => _HospitalItemState();
}

class _HospitalItemState extends State<HospitalItem> with SingleTickerProviderStateMixin{
    bool isExpanded = false;
    final textWhiteStyle=TextStyle(fontSize: 18,color: Colors.white);
    Animation <double> ? heightAnim;
    Animation <double> ? elevAnim;
    Animation <double> ? yOffsetAnim;
    Animation <double> ? scaleAnim;
    late AnimationController controller;

    @override
    void initState() {
      controller = 
      AnimationController(duration: Duration(seconds: 1), vsync: this);
      controller.addListener(() {
        setState(() {});
      });
      super.initState();
    }
    @override
    void dispose(){
      controller.dispose();
      super.dispose();
    }
    
    @override
  void didChangeDependencies() {
    heightAnim = Tween<double>(begin: 0.0, end: 150).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
    scaleAnim = Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeInOut)));

    yOffsetAnim = Tween<double>(begin: 1.0, end: 10.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeInOut)));

    elevAnim = Tween<double>(begin: 2.0, end: 10.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeInOut)));
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    print(' Page Number : ${widget.pageNumber}');
    print('Index : ${widget.index}');
    double diff=widget.index - widget.pageNumber; 
    return Transform(
      transform: Matrix4.identity()
      ..setEntry(3,2,0.002)
      ..rotateY(-pi/4*diff),
       alignment:
        diff > 0 ? FractionalOffset.centerLeft : FractionalOffset.centerRight,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("${widget.hospital.name}"),
              background: Image.asset("${widget.hospital.image}",
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                children: [
                  Card(
                    color: Colors.deepPurple.withOpacity(0.9),
                     shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                     ),
                     child: Padding(
                      padding: EdgeInsets.only(
                        left: 10,right: 10,top: 100,bottom: 100
                      ),
                      child: Text("${widget.hospital.description}"), 
                      ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          spreadRadius: elevAnim!.value,
                          offset: Offset(0,yOffsetAnim!.value),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: (){
                            if(isExpanded){
                              controller.reverse();
                            }
                            else{
                              controller.forward();
                            }
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          title: Text("${widget.hospital.name}",style: textWhiteStyle,
                          ),
                          subtitle: Text("${widget.hospital.category}",style: textWhiteStyle,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                               Icons.star,
                               color: Colors.white, 
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("${widget.hospital.rating}",style: textWhiteStyle), 
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Transform.scale(
                            scale: scaleAnim!.value,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient( 
                                  colors: [
                                    Colors.deepPurple.shade900,
                                    Colors.deepPurple.shade400,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              alignment: Alignment.center,
                              height: heightAnim!.value,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width/1.5,
                                child: ListView(
                                  children: [
                                    Text("Directed by : ${widget.hospital.director}",style: textWhiteStyle,
                                    ),
                                     Text(
                                  'Produced by : ${widget.hospital.producer}',style: textWhiteStyle,
                                ),
                                Text(
                                  'Production : ${widget.hospital.production}',style: textWhiteStyle,
                                ),
                                Text(
                                  'Laguage : ${widget.hospital.language}',style: textWhiteStyle,
                                ),
                                Text(
                                  'Running Time : ${widget.hospital.runningTime}',style: textWhiteStyle,
                                ),
                                Text(
                                  'Country: ${widget.hospital.country}',style: textWhiteStyle,
                                ),
                                Text(
                                  'Budget: ${widget.hospital.budget}',style: textWhiteStyle,
                                ),
                                Text(
                                  'Box Office: ${widget.hospital.boxOffice}',style: textWhiteStyle,
                                ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],),
          ),
        ],
      ),
    );
  }
}