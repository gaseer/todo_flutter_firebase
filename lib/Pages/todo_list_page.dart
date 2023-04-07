
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodolistPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodolistPage({super.key});

  void _addTask() {
    FirebaseFirestore.instance
        .collection("todo")
        .add({"title": _controller.text});
  }

  onDelete(String id) {
    FirebaseFirestore.instance.collection("todo").doc(id).delete();
  }

  Widget buildbody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Type todo list",
                  filled: true,
                  fillColor: Color.fromARGB(255, 110, 171, 202),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                ),
                controller: _controller,
              ),
            ),
            TextButton(
                onPressed: () {
                  _addTask();
                },
                child: Icon(
                  Icons.add,
                  size: 55,
                  color: Colors.blueGrey,
                )),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 15,
          child: Text("<<<<Swipe left to DELETE<<<<"),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("todo").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Dismissible(
                          key: Key(document.id),
                          onDismissed: (direction) {
                            onDelete(document.id);
                          },
                          background: Container(
                            color: Colors.redAccent,
                            child: Icon(Icons.delete),
                          ),
                          child: ListTile(
                            title: Text(document["title"]),
                          ));
                    }).toList(),
                  ),
                );
              }
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 208, 224, 232),
        appBar: AppBar(
          title: Text("Todo list app "),
        ),
        body: buildbody(context));
  }
}