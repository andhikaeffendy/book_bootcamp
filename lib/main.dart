import 'package:book_bootcamp/constant/const.dart';
import 'package:book_bootcamp/controllers/book_controller.dart';
import 'package:book_bootcamp/views/book_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookController>(
      create: (context) => BookController(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        color: appBarColors,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const BookListPage(),
      ),
    );
  }
}
