import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import './settingPage.dart';
import './timerPage.dart';
import './schedulePage.dart';
import './quizPage.dart';
import './profilePage.dart';
import './flashcard.dart';




class HomeMenu extends StatefulWidget {

  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenu();
}

class _HomeMenu extends State<HomeMenu> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
 return Scaffold(
        extendBody: true,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
          ),
          child: SizedBox(
            height: 100,
            child: FloatingNavbar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.blue.shade700,
              borderRadius: 40,
              onTap: (int val) {
                setState(() {
                  _currentIndex = val;
                });
                if (_currentIndex == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeMenu()),
                  );
                }
                if (_currentIndex == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => profile()),
                  );
                }
                if (_currentIndex == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setting()),
                  );
                }
              },
              currentIndex: _currentIndex,
              unselectedItemColor: Colors.grey,
              iconSize: 33,
              fontSize: 15,
              items: [
                FloatingNavbarItem(icon: Icons.home, title: 'Home'),
                FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
                FloatingNavbarItem(icon: Icons.settings, title: 'Setting'),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.blue.shade100,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'LEARNMATE',
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TestYourselfPage()),
                          );
                        },
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Icon(
                                Icons.lightbulb_outline_rounded,
                                size: 90,
                                color: Colors.blue.shade200,
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'FLASHCARDS',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade200,
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuizPage()),
                          );
                        },
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Icon(
                                Icons.menu_book,
                                size: 90,
                                color: Colors.blue.shade200,
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'QUIZ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade200,
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //--------------------------------------------------------
              //end of 1 row
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DeadlinePage()),
                          );
                        },
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Icon(
                                Icons.calendar_today,
                                size: 90,
                                color: Colors.blue.shade200,
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'SCHEDULE',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade200,
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CountdownPage()),
                          );
                        },
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Icon(
                                Icons.timer_outlined,
                                size: 90,
                                color: Colors.blue.shade200,
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'TIMER',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade200,
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //------------------------------------------------
              //end of second row
            ],
          ),
        ),
    );
  }
}

/*
class _HomeMenu extends State<HomeMenu> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // start of the  bar
        extendBody: true,
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
            ),
            child: SizedBox(
              height: 100,
              child: FloatingNavbar(
                backgroundColor: Colors.white,

                selectedItemColor: Colors.blue.shade700, // new line
                borderRadius: 40,
                onTap: (int val) {
                  setState(() {
                    _currentIndex = val;
                  });
                },
                currentIndex: _currentIndex,
                unselectedItemColor: Colors.grey,
                iconSize: 33,
                fontSize: 15,
                items: [
                  FloatingNavbarItem(icon: Icons.home, title: 'Home'),
                  FloatingNavbarItem(icon: Icons.menu_book, title: 'Quiz'),
                  FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
                ],
              ),
            )
        ),

        // start of the app
        //let me die please

        backgroundColor: Colors.blue.shade100,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('LEARNMATE',
                        style: TextStyle(
                            fontSize: 27,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [

                    Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                      ),
                      onPressed: (){},
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Icon(Icons.lightbulb_outline_rounded,
                              size: 90,
                              color: Colors.blue.shade200,),
                            SizedBox(height: 10,),
                            Text('FLASHCARDS',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade200,
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),
                    ),

                    SizedBox(width: 15,),


                    Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                      ),
                      onPressed: (){},
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Icon(Icons.menu_book,
                              size: 90,
                              color: Colors.blue.shade200,),
                            SizedBox(height: 10,),
                            Text('QUIZ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade200,
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),

              //--------------------------------------------------------
              //end of 1 row

              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [

                    Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),

                          )
                      ),
                      onPressed: (){},
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Icon(Icons.calendar_today,
                              size: 90,
                              color: Colors.blue.shade200,),
                            SizedBox(height: 10,),
                            Text('SCHEDULE',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade200,
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),
                    ),

                    SizedBox(width: 15,),


                    Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),

                          )
                      ),
                      onPressed: (){},
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Icon(Icons.timer_outlined,
                              size: 90,
                              color: Colors.blue.shade200,),
                            SizedBox(height: 10,),
                            Text('TIMER',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade200,
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),

              //------------------------------------------------
              //end of second row

              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [

                    Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),

                          )
                      ),
                      onPressed: (){},
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Icon(Icons.lightbulb_outline_rounded,
                              size: 90,
                              color: Colors.blue.shade200,),
                            SizedBox(height: 10,),
                            Text('FLASHCARDS',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade200,
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),
                    ),

                    SizedBox(width: 15,),


                    Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),

                          )
                      ),
                      onPressed: (){},
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Icon(Icons.menu_book,
                              size: 90,
                              color: Colors.blue.shade200,),
                            SizedBox(height: 10,),
                            Text('QUIZ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade200,
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/