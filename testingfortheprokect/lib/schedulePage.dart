import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'homeMenu.dart';
import './profilePage.dart';
import './settingPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Deadlines Page',
    home: DeadlinePage(),
  ));
}

class Deadline {
  final String name;
  final DateTime date;
  DeadlineStatus status;

  Deadline({
    required this.name,
    required this.date,
    this.status = DeadlineStatus.NotStarted,
  });
}

enum DeadlineStatus {
  NotStarted,
  InProgress,
  Done,
}

class DeadlinePage extends StatefulWidget {
  const DeadlinePage({Key? key}) : super(key: key);

  @override
  _DeadlinePageState createState() => _DeadlinePageState();
}

class _DeadlinePageState extends State<DeadlinePage> {
  int _currentIndex = 0;
  List<Deadline> deadlines = [];
  TextEditingController deadlineNameController = TextEditingController();

  void addDeadline(String deadlineName, DateTime date) {
    setState(() {
      deadlines.add(Deadline(name: deadlineName, date: date));
    });
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, y').format(dateTime);
  }

  void updateStatus(int index, DeadlineStatus newStatus) {
    setState(() {
      deadlines[index].status = newStatus;
    });
  }

  void deleteDeadline(int index) {
    setState(() {
      deadlines.removeAt(index);
    });
  }

  Widget buildDeadlineList() {
    return ListView.separated(
      itemCount: deadlines.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1),
      itemBuilder: (BuildContext context, int index) {
        final deadline = deadlines[index];
        return DeadlineWidget(
          deadline: deadline,
          onUpdateStatus: (newStatus) {
            updateStatus(index, newStatus);
          },
          onDelete: () {
            deleteDeadline(index);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Deadlines',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      DateTime selectedDate = DateTime.now();

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Add Deadline',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextField(
                                  controller: deadlineNameController, // Add this line
                                  decoration: InputDecoration(
                                    labelText: 'Deadline Name',
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          selectedDate = value;
                                        });
                                      }
                                    });
                                  },
                                  child: Text('Select Date'),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Selected Date: ${formatDateTime(selectedDate)}',
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    addDeadline(
                                      deadlineNameController.text, // Use the text from the controller
                                      selectedDate,
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text('Add Deadline'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Text('Add a Deadline'),
              ),
            ),
            Expanded(child: buildDeadlineList()),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(),
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
    );
  }
}

class DeadlineWidget extends StatelessWidget {
  final Deadline deadline;
  final Function(DeadlineStatus) onUpdateStatus;
  final VoidCallback onDelete;

  const DeadlineWidget({
    required this.deadline,
    required this.onUpdateStatus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (deadline.status) {
      case DeadlineStatus.NotStarted:
        statusColor = Colors.red;
        break;
      case DeadlineStatus.InProgress:
        statusColor = Colors.yellow.shade700;
        break;
      case DeadlineStatus.Done:
        statusColor = Colors.green;
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        deadline.name.isEmpty ? 'No Name' : deadline.name,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Date: ${formatDateTime(deadline.date)}',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Status: ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      DropdownButton<DeadlineStatus>(
                        value: deadline.status,
                        onChanged: (DeadlineStatus? newValue) {
                          if (newValue != null) {
                            onUpdateStatus(newValue);
                          }
                        },
                        items: [
                          DropdownMenuItem(
                            value: DeadlineStatus.NotStarted,
                            child: Text('Not Started'),
                          ),
                          DropdownMenuItem(
                            value: DeadlineStatus.InProgress,
                            child: Text('In Progress'),
                          ),
                          DropdownMenuItem(
                            value: DeadlineStatus.Done,
                            child: Text('Done'),
                          ),
                        ],
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );

  }


  String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, y').format(dateTime);
  }

  String getStatusText(DeadlineStatus status) {
    switch (status) {
      case DeadlineStatus.NotStarted:
        return 'Not Started';
      case DeadlineStatus.InProgress:
        return 'In Progress';
      case DeadlineStatus.Done:
        return 'Done';
      default:
        return '';
    }
  }
}

