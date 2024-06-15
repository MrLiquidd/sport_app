import "package:flutter/material.dart";

import "story_view_page.dart";

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with TickerProviderStateMixin {
  //gap between the dots
  late Animation<double> gap;

// the point of animation
  late Animation<double> base;

  // it  reverse the animation
  late Animation<double> reverse;

  // constructor whenever you create a new animation controller.
  late AnimationController controller;

  var model = [
    "http://127.0.0.1:8000/api/v1/images/images/Frame_461.png",
    "http://127.0.0.1:8000/api/v1/images/images/Frame_462.png",
    "http://127.0.0.1:8000/api/v1/images/images/Frame_463.png",
  ];

  @override
  void initState() {
    super.initState();

// We pass vsync: this to the animation controller to create an Animation controller in a class
// that uses this mixin
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
// curved animation  applies curves to animation
//it is especially used if we want different curves when animation is moving forward or backward

    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
// A linear interpolation between a beginning and ending value.
    //to revert the animation of the image when borders are animating
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);

    gap = Tween<double>(begin: 15.0, end: 0.0)
        .animate(base) //the gap between the dots
      ..addListener(() {
        //.. This syntax means that the addListener() method is called
        // with the return value from animate().
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView.builder(
              itemCount: model.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return StoryViewPage(model, index);
                  })),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 130,
                            height: 180,
                            alignment: Alignment.center,
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(model[index]),
                            )),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
