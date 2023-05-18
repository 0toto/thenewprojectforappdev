import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import './settingPage.dart';
import './profilePage.dart';
import '../widgets/round-button.dart';

import 'homeMenu.dart';


class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = false;
  int _currentIndex = 0;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  bool isDialogOpen = false;

  double progress = 1.0;

  void notify() {
    if (countText == '0:00:00' && !isDialogOpen) {
      isDialogOpen = true; // Set the flag to true
      FlutterRingtonePlayer.playNotification();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Good job, you finished studying!',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          isDialogOpen = false; // Reset the flag
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }






  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.blue.shade100,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 300,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey.shade300,
                                  value: progress,
                                  strokeWidth: 6,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.isDismissed) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                        height: 300,
                                        child: CupertinoTimerPicker(
                                          initialTimerDuration:
                                          controller.duration!,
                                          onTimerDurationChanged: (time) {
                                            setState(() {
                                              controller.duration = time;
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: AnimatedBuilder(
                                  animation: controller,
                                  builder: (context, child) => Text(
                                    countText,
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (controller.isAnimating) {
                                    controller.stop();
                                    setState(() {
                                      isPlaying = false;
                                    });
                                  } else {
                                    controller.reverse(
                                        from: controller.value == 0
                                            ? 1.0
                                            : controller.value);
                                    setState(() {
                                      isPlaying = true;
                                    });
                                  }
                                },
                                child: RoundButton(
                                  icon: isPlaying == true
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.reset();
                                  setState(() {
                                    isPlaying = false;
                                  });
                                },
                                child: RoundButton(
                                  icon: Icons.stop,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(),
        child: SizedBox(
          height: 100,
          child: FloatingNavbar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue.shade700,
            borderRadius: 40,
            // new line
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
    );
  }
}
