import 'dart:convert';
import 'package:basileia/Screen/bibleScreen.dart';
import 'package:basileia/Screen/readbookScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../RestAPI/RestClient.dart';
import '../RestAPI/model.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';

class ReadHolyBookScreen extends StatefulWidget {
  const ReadHolyBookScreen({super.key});

  @override
  _ReadHolyBookScreenState createState() => _ReadHolyBookScreenState();
}

class _ReadHolyBookScreenState extends State<ReadHolyBookScreen> {
  late Future<Book> bookFuture;

  @override
  void initState() {
    super.initState();
    // Get the book ID passed via arguments
    final String bookId = Get.arguments['bookId'] ?? '';
    bookFuture = fetchBook(bookId);
  }

  Future<Book> fetchBook(String bookId) async {
    final url = Uri.parse('https://basillia.genzit.xyz/api/v1/books/$bookId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwt_token', // Replace with your token
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Book.fromJson(data);
      } else {
        throw Exception(
            'Failed to load book. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching book: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back_rounded),
                    ),
                    FutureBuilder<Book>(
                      future: bookFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: poppins_semibold,
                              color: Colors.black,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: poppins_semibold,
                              color: Colors.red,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final book = snapshot.data!;
                          return Text(
                            book.name,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: poppins_semibold,
                              color: Colors.black,
                            ),
                          );
                        } else {
                          return const Text(
                            'Unknown',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: poppins_semibold,
                              color: Colors.black,
                            ),
                          );
                        }
                      },
                    ),
                    const Icon(Icons.more_vert),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Title Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Continue Reading',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Chapters Section
              FutureBuilder<Book>(
                future: bookFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    final book = snapshot.data!;
                    final chapters = book.chapters;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: chapters.length,
                      itemBuilder: (context, index) {
                        final chapter = chapters[index];
                        return Books(
                          name: chapter.name,
                          chapters: chapter.chapters ?? 0,
                          onTap: () {
                            Get.to(BibleReadingScreen(
                              abbrev: chapter.abbrev,
                              lang: book.abbrev,
                              chapter: chapter.chapters!,
                              ChapterName: chapter.name,
                            ));
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No chapters available'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

