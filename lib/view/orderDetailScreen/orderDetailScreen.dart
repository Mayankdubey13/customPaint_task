import 'package:custompaint_assignment/utils/appColor.dart';
import 'package:custompaint_assignment/utils/appString.dart';
import 'package:flutter/material.dart';

import '../customPaintTask.dart';
import 'customWidget/deliverPartner.dart';
import 'customWidget/draggleImage.dart';
import 'customWidget/tellUsMoreCard.dart';
class OrderDetailScreen extends StatefulWidget{
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  var iconKey = GlobalKey();

  final ValueNotifier<Offset> offset = ValueNotifier<Offset>(Offset.zero);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      offset.value = _getOffsetOnCanvas(iconKey, context, Size(54,54));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("+++++1$context");
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.18,
        backgroundColor: AppColor.appBarColor,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Padding(
              padding: const EdgeInsets.only(top: 5),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child:  Icon(
                  Icons.arrow_back_ios_new_sharp, color: AppColor.white, size: 22,),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppString.appBarText1, style: TextStyle(fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.white,),),
                  Text(AppString.appBarText2, style: TextStyle(fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,),),
                  const SizedBox(height: 10,),
                  Text(AppString.appBarText3, style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,),),
                  const SizedBox(height: 20,),
                  Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      width: 190,
                      decoration: BoxDecoration(
                          color: AppColor.appBarContainer,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(child: Text(AppString.appBarText4,
                        style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.white),)))
                ],
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
            DraggleImage(),
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.45,
            maxChildSize: 0.99,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color:AppColor.bottomsheet1,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                       const TellUsMoreCard(),
                    //  const SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(15),
                      //  height: 300,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Column(
                          children: [
                          deliverPartner(),
                            const SizedBox(height: 20,),
                            ValueListenableBuilder(
                              valueListenable: offset,
                              builder:(context,_,__) => CustomPaint(
                                painter: CustomBoxDesigned1(centre:offset.value ),
                                child: Container(
                                  // padding: const EdgeInsets.all(10),
                                  // decoration: BoxDecoration(
                                  //     color: Colors.green.shade50,
                                  //   borderRadius: BorderRadius.circular(10)
                                  // ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(AppString.orderPlacedText,style: TextStyle(color: AppColor.appBarColor),),
                                  )
                                ),
                              ),
                            ),
                             const SizedBox(height: 15,),
                            Container(
                            //  height: 100,
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade400)
                              ),
                              child: Column(
                                children: List.generate(10, (index) =>  Column(
                                  children: [
                                    DeliverPartner(),
                                    SizedBox(height: 10,)
                                  ],
                                )),
                              )
                            ),

                          ],
                        ),


                      )

                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );

  }
  Widget deliverPartner(){
       debugPrint("++++++++++2$context");
       debugPrint("%%%%%%$iconKey");
    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          key:iconKey,
          height: 54,
          width: 54,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.yellow,width: 2),
              borderRadius: BorderRadius.circular(27)
          ),
          child:  Icon(
            // key: iconKey,
            Icons.person,color: Colors.yellow,size: 35,),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppString.nameText ,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
                Text(AppString.deliverPartner ,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
              ],
            ),
          ),
        ),
        Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200,width: 2),
                borderRadius: BorderRadius.circular(21)
            ), child: Icon(Icons.call,size:20,color: AppColor.appBarColor,))
      ],
    );
}

  Offset _getOffsetOnCanvas(GlobalKey key, BuildContext context, Size objectSize) {
    // debugPrint("@@@@@@@@$key");
    // debugPrint("hyhyhy");
    // debugPrint("+++++++++3$context");
    RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox!= null) {
      Offset iconButtonPosition = renderBox.localToGlobal(Offset.zero);
       debugPrint("$iconButtonPosition");
      return Offset(iconButtonPosition.dx + iconButtonPosition.dx/2 ,
          iconButtonPosition.dy + iconButtonPosition.dy/2);
    } else {
      debugPrint("mayank");
      // Handle the case where renderBox is null, possibly by returning a default value or throwing an error.
      return Offset.zero; // or throw an error, depending on your use case
    }
  }
}

class CustomBoxDesigned1 extends CustomPainter{
  Offset centre;
  CustomBoxDesigned1({required  this.centre});

  @override
  void paint(Canvas canvas, Size size) {
    debugPrint("___$centre");
    Paint paint = Paint()
      ..color = Colors.green.shade50
      ..style = PaintingStyle.fill;
    Path path = Path();
    Rect rect = Rect.fromPoints(Offset.zero, Offset(size.width,size.height),);
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));
    canvas.drawPath(path, paint);
    Path path1= Path()
      ..moveTo(centre.dx - 5 - 18, 0)
      ..lineTo(centre.dx - 18, -10)
      ..lineTo(centre.dx + 5 - 18, 0);
    canvas.drawPath(path1, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}

