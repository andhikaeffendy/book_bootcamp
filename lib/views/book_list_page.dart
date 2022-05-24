import 'package:book_bootcamp/constant/const.dart';
import 'package:book_bootcamp/controllers/book_controller.dart';
import 'package:book_bootcamp/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;

  @override
  void initState() {
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Catalogue"),
        centerTitle: true,
      ),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controller, child) => Container(
          child: bookController!.bookListResponse == null
              ? child
              : ListView.builder(
                  itemCount: bookController!.bookListResponse!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBooks =
                        bookController!.bookListResponse!.books![index];
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailBookPage(isbn: currentBooks.isbn13!),
                      )),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 2.0,
                                offset: const Offset(1.0, 2.0),
                                color: Colors.blueGrey[100]!,
                              )
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              currentBooks.image!,
                              height: 100,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentBooks.title!,
                                    overflow: TextOverflow.clip,
                                    style: titleStyle,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    currentBooks.subtitle!,
                                    style: subtitleStyle,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "ISBN: ${currentBooks.isbn13!}",
                                        style: isbnStyle,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(16),
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16)),
                                          color: Colors.yellow[700],
                                        ),
                                        child: Text(
                                          currentBooks.price!,
                                          style: priceStyle,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
