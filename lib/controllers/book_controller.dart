import 'dart:convert';

import 'package:book_bootcamp/models/book_list_response.dart';
import 'package:book_bootcamp/models/detail_book_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookController extends ChangeNotifier {
  BookListResponse? bookListResponse;

  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookListResponse = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }
  }

  DetailBookResponse? detailBookResponse;
  BookListResponse? similarBook;

  fetchBookDetailApi({required String isbn}) async {
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      detailBookResponse = DetailBookResponse.fromJson(jsonBookList);
      notifyListeners();
      fetchSimilarBookApi(detailBookResponse!.title!);
    }
  }

  fetchSimilarBookApi(String title) async {
    var url = Uri.parse('https://api.itbook.store/1.0/search/$title');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      similarBook = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }
  }
}
