import 'dart:convert';
import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/readHolyBookScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Import your styles and fonts
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';

import '../RestAPI/model.dart';
import '../Style/style.dart';

class HolyBookScreen extends StatefulWidget {
  const HolyBookScreen({Key? key}) : super(key: key);

  @override
  _HolyBookScreenState createState() => _HolyBookScreenState();
}

class _HolyBookScreenState extends State<HolyBookScreen> {
  late Future<List<Book>> booksFuture;

  @override
  void initState() {
    super.initState();
    booksFuture = fetchBooks();
  }

  Future<List<Book>> fetchBooks() async {
    final url = Uri.parse('https://basillia.genzit.xyz/api/v1/books/all');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwt_token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          return data.map((book) => Book.fromJson(book)).toList();
        } else {
          throw Exception('Unexpected JSON structure.');
        }
      } else {
        throw Exception(
            'Failed to load books. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching books: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Greeting Section
            Stack(
              children: [
                Container(
                  height: 214,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: bookPageColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Text(
                          'Hello, $userFullname 👋', // Replace with actual user name
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: poppins_semibold,
                            color: primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'What do you want to',
                          style: TextStyle(
                            fontFamily: poppins_regular,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: chatTxtColor,
                          ),
                        ),
                        const Text(
                          'read today?',
                          style: TextStyle(
                            fontFamily: poppins_regular,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: chatTxtColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Exercise Card Section
                Padding(
                  padding: const EdgeInsets.only(top: 165, left: 40, right: 40),
                  child: Container(
                    height: 91,
                    width: 327,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'More serious exercise',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: poppins_regular,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Get more features and',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: poppins_regular,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text('Read Holy Books',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
            ),
            // Book List Section
            FutureBuilder<List<Book>>(
              future: booksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No books available'),
                  );
                } else {
                  final books = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      print(
                          'Parsed books: ${books.map((book) => book.name).toList()}');
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Container(
                            height: 114,
                            width: 93,
                            decoration: BoxDecoration(
                              color: lightPrimary_2,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                book.name,
                                style: const TextStyle(
                                    fontFamily: poppins_regular,
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                               Text(
                                book.language,
                                style: const TextStyle(
                                    fontFamily: poppins_regular,
                                    color: primaryTxt,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Primary_Button(
                                    onTap: () {Get.to(ReadHolyBookScreen(),arguments: {'bookId':book.id});},
                                    text: 'Read Now',
                                  ),
                                  
                                ],
                              ),
                            ],
                          ),
                        ]),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
