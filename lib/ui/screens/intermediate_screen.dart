import 'package:basiclogin/ui/screens/home_page.dart';
import 'package:basiclogin/ui/screens/quiz_screen.dart';
import 'package:basiclogin/ui/screens/relations_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IntermediateScreen extends StatefulWidget {
  const IntermediateScreen({super.key});

  @override
  State<IntermediateScreen> createState() => _IntermediateScreenState();
}

getUser(uid) {
  return FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: uid)
      .snapshots();
}

class _IntermediateScreenState extends State<IntermediateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: getUser(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              var data = snapshot.data!.docs[0];

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: data['momPhoto'] == ''
                            ? Image.asset('assets/images/vector-1.png')
                            : Image.network(data['momPhoto'])),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: data['dadphoto'] == ''
                            ? Image.asset('assets/images/vector-1.png')
                            : Image.network(data['dadphoto'])),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: data['siblingPhoto'] == ''
                            ? Image.asset('assets/images/vector-1.png')
                            : Image.network(data['siblingPhoto'])),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Home_Screen(),
                          ));
                        },
                        child: const Text('Todo')),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RelationScreen()));
                      },
                      child: const Text('Relations'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const QuizScreen()));
                      },
                      child: const Text('Daily Quiz'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
