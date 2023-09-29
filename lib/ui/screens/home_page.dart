import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:basiclogin/const/colors.dart';
import 'package:basiclogin/ui/screens/add_note_screen.dart';
import 'package:basiclogin/widgets/stream_notes.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: custom_green,
      ),
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Add_creen(),
            ));
          },
          backgroundColor: custom_green,
          child: Icon(Icons.add, size: 30),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: Column(
            children: [
              Stream_note(false),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
                // Add some padding to create space for the border
                child: Text(
                  'Tasks Completed',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Stream_note(true),
            ],
          ),
        ),
      ),
    );
  }
}
