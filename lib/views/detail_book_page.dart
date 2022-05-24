import 'package:book_bootcamp/constant/const.dart';
import 'package:book_bootcamp/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatefulWidget {
  final String isbn;
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? bookController;

  @override
  void initState() {
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookDetailApi(isbn: widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Book"),
        centerTitle: true,
      ),
      body: Consumer<BookController>(builder: (context, controller, child) {
        return bookController!.detailBookResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Image.network(
                                      bookController!
                                          .detailBookResponse!.image!,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ));
                        });
                      },
                      child: Image.network(
                        bookController!.detailBookResponse!.image!,
                        height: 200,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        Uri uri =
                            Uri.parse(bookController!.detailBookResponse!.url!);
                        try {
                          (await canLaunchUrl(uri))
                              ? launchUrl(uri)
                              : print("cant Launch URL");
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blueGrey[300]),
                        child: Text(
                          "Buy This Book",
                          textAlign: TextAlign.center,
                          style: priceStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          5,
                          (index) => Icon(
                                Icons.star,
                                color: index >
                                        int.parse(bookController!
                                            .detailBookResponse!.rating!)
                                    ? Colors.blueGrey[100]
                                    : Colors.blueGrey[500],
                                size: 20,
                              )),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      bookController!.detailBookResponse!.title!,
                      textAlign: TextAlign.center,
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      bookController!.detailBookResponse!.authors!,
                      style: subtitleStyle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Publisher",
                              style: labelStyle,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${bookController!.detailBookResponse!.publisher!} ${bookController!.detailBookResponse!.year!}",
                              style: titleStyle,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              style: labelStyle,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              bookController!.detailBookResponse!.price!,
                              style: titleStyle,
                            ),
                          ],
                        ),
                        const Spacer()
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: labelStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      bookController!.detailBookResponse!.desc!,
                      style: isbnStyle,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                    ),
                    bookController!.similarBook == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemCount:
                                    bookController!.similarBook!.books!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final currentBook = bookController!
                                      .similarBook!.books![index];
                                  return Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 80),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          currentBook.image!,
                                          fit: BoxFit.cover,
                                          height: 100,
                                        ),
                                        Text(
                                          currentBook.title!,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: subtitleStyle,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                  ],
                ),
              );
      }),
    );
  }
}
