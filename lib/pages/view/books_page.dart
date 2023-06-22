import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  List<String> bookList = [
    'Book 1',
    'Book 2',
    'Book 3',
    'Book 4',
    'Book 5',
    'Book 1',
    'Book 2',
    'Book 3',
    'Book 4',
    'Book 5',
    'Book 1',
    'Book 2',
    'Book 3',
    'Book 4',
    'Book 5',
  ];

  List<String> filteredBooks = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredBooks.addAll(bookList);
  }

  void filterBooks(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredBooks = bookList.where((book) {
        return book.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  filterBooks(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Search Books',
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredBooks[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
