import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadedPage extends StatefulWidget {
  const LoadedPage({super.key});

  @override
  State<LoadedPage> createState() => _LoadedPageState();
}

class _LoadedPageState extends State<LoadedPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('img/loaded.svg',
            width: 128,
            height: 128,
          ),
          const SizedBox(height: 24,),
          const Text('Спортивный.Я',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}
