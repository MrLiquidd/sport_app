import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app/domain/cubit/app_cubit_states.dart';
import 'package:travel_app/domain/cubit/app_cubits.dart';
import 'package:travel_app/resources/resources.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'package:travel_app/ui/widgets/elements/app_large_text.dart';
import 'package:travel_app/ui/widgets/elements/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
              child: Container(
                color: AppColors.mainBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Space between header and savearea
                    const SizedBox(
                      height: 25,
                    ),
                    //Header
                    _HomeHeaderWidget(),
                    //Stories?
                    _HomeStoriesWidget(),
                    const SizedBox(
                      height: 34,
                    ),
                    //New trains Text
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: AppLargeText(
                          text: 'Новые занятия',
                          size: 18,
                        )),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(height: 18,),
                    _CheckAllButton(),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: AppLargeText(
                          text: 'Карта',
                          size: 25,
                        )),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
    );
  }
}

class _HomeHeaderWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLargeText(
            text: "Главная",
          ),
          Row(
            children: [
              IconButton(
                  color: Colors.grey,
                  iconSize: 30,
                  onPressed: () {},
                  icon: const Icon(Icons.notifications)),
              IconButton(
                  iconSize: 30,
                  color: Colors.red,
                  onPressed: () {},
                  icon: const Icon(Icons.favorite)),
            ],
          ),
        ],
      ),
    );
  }

}

class _HomeStoriesWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainBackground,
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 144,
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: 106,
                height: 144,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SvgPicture.asset(AppImages.fans3,
                  width: 124,
                  height: 148,
                ),
              ),
            );
          }),
    );
  }

}

class _CheckAllButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Cмотреть все',
            style: TextStyle(color: AppColors.textColor1,
                fontSize: 14, fontWeight: FontWeight.w500),),
          Icon(Icons.arrow_right, color: AppColors.textColor1,
            weight: 500, size: 28,)
        ],
      ),
    );
  }

}

//CARDS

// class _SportCardsWidget extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColors.mainBackground,
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       constraints: BoxConstraints(
//           maxHeight: 500
//       ),
//       width: double.maxFinite,
//       child: ListView.builder(
//         padding: const EdgeInsets.all(0),
//         itemCount: 2,
//         scrollDirection: Axis.vertical,
//         physics: const NeverScrollableScrollPhysics(),
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () {
//               BlocProvider.of<AppCubits>(context)
//                   .detailPage(info[index]);
//             },
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment:
//                   MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                         padding: const EdgeInsets.only(top: 10),
//                         height: 50,
//                         width: 200,
//                         margin: const EdgeInsets.only(left: 15),
//                         child: ListView.builder(
//                             itemCount: 2,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (_, index) {
//                               return Container(
//                                 margin: const EdgeInsets.only(
//                                     right: 10),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       constraints: const BoxConstraints(
//                                           maxWidth: double.infinity
//                                       ),
//                                       height: 30,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                         BorderRadius
//                                             .circular(8),
//                                         color: Colors.white,
//                                       ),
//                                       child: Center(
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                                           child: const Text(
//                                             'Игра',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight:
//                                                 FontWeight
//                                                     .w600,
//                                                 color: AppColors
//                                                     .textColor1),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             })),
//                     Container(
//                         padding: const EdgeInsets.only(top: 20),
//                         child:
//                         const Center(child: Text('10/12')))
//                   ],
//                 ),
//                 Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   child: Column(
//                     crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             right: 15,
//                             left: 25,
//                             top: 20,
//                             bottom: 15),
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: 40,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                     BorderRadius.circular(
//                                         40),
//                                     image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: NetworkImage(
//                                           "http://mark.bslmeiyu.com/uploads/" +
//                                               info[index].img),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 20,
//                                 ),
//                                 AppLargeText(
//                                   text: info[index].name,
//                                   size: 25,
//                                 )
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment
//                                   .spaceBetween,
//                               crossAxisAlignment:
//                               CrossAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Container(
//                                       height: 45,
//                                       width: 90,
//                                       decoration: BoxDecoration(
//                                         color: AppColors
//                                             .cardBackground2,
//                                         borderRadius:
//                                         BorderRadius
//                                             .circular(10),
//                                       ),
//                                       child: const Row(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .center,
//                                         mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .center,
//                                         children: [
//                                           Center(
//                                             child: Text(
//                                               '18:00',
//                                               style: TextStyle(
//                                                   fontSize: 24,
//                                                   fontWeight:
//                                                   FontWeight
//                                                       .w600,
//                                                   color: AppColors
//                                                       .textColor1),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 20,
//                                     ),
//                                     const Text('Вт, 04.10'),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Wrap(
//                                       children: List.generate(5,
//                                               (index) {
//                                             return Icon(
//                                               Icons.star,
//                                               color: index <
//                                                   info[index]
//                                                       .stars
//                                                   ? AppColors
//                                                   .starColor
//                                                   : AppColors
//                                                   .textColor2,
//                                               size: 20,
//                                             );
//                                           }),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment
//                                   .spaceBetween,
//                               crossAxisAlignment:
//                               CrossAxisAlignment.center,
//                               children: [
//                                 AppText(
//                                     text: info[index].location),
//                                 AppText(
//                                   text:
//                                   '${info[index].price} ₽',
//                                   size: 20,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, radius: radius);
  }
}

class CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  CirclePainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;

    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}


// Container(
//   margin: const EdgeInsets.only(left: 20, right: 20),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       AppLargeText(
//         text: "Explore more",
//         size: 22,
//       ),
//       AppText(
//         text: 'See all',
//         color: AppColors.textColor1,
//       )
//     ],
//   ),
// ),
// const SizedBox(
//   height: 10,
// ),
// Container(
//     height: 120,
//     width: double.maxFinite,
//     margin: const EdgeInsets.only(left: 20),
//     child: ListView.builder(
//         itemCount: 4,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (_, index) {
//           return Container(
//             margin: const EdgeInsets.only(right: 30),
//             child: Column(
//               children: [
//                 Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.white,
//                       image: DecorationImage(
//                           image: AssetImage("img/${images.keys.elementAt(index)}"),
//                           fit: BoxFit.cover
//                       )
//                   ),
//                 ),
//                 const SizedBox(height: 10,),
//                 Container(
//                   child: AppText(
//                       text: images.values.elementAt(index),
//                       color: AppColors.textColor1
//                   ),
//                 )
//               ],
//             ),
//           );
//         }))
