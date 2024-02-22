import 'package:flutter/material.dart';
import 'package:travel_app/ui/theme/colors.dart';


class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.mainBackground,
          child: Column(
            children: [
              Container(
                color: AppColors.mainBackground,
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: (){
                        },
                        child: Text('Изменить')
                    ),
                    IconButton(
                        color: Colors.grey,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        icon: const Icon(Icons.settings)),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                          image: AssetImage('img/welcome-one.png')
                      )
                    ),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    child: Text('Демидова Алина, 34',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          color: Colors.grey,
                          iconSize: 30,
                          onPressed: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          icon: const Icon(Icons.location_on)),
                      Text('Казань',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                      ),),
                    ],
                  ),
                  SizedBox(height: 26,),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: double.infinity
                    ),
                    width: 343,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                      child:  const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('О себе: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey
                          )),
                          SizedBox(width: 5,),
                          Flexible(child:
                          Text('Играю в бадминтон с 5 лет, веду активный образ жизни',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal
                            ),))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 73,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text('29',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              Center(
                                child: Text('Друзей',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal
                                  ),),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: 215,
                          height: 73,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text('4',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              Center(
                                child: Text('Количество посещений',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}