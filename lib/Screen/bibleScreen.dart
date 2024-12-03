import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../RestAPI/RestClient.dart';

class BibleVerse {
  final String id;
  final String name; // Book name
  final String abbrev; // Abbreviation for the book
  final int chapter; // Chapter number
  final String lang; // Language code
  final String verse; // Actual verse text

  BibleVerse({
    required this.id,
    required this.name,
    required this.abbrev,
    required this.chapter,
    required this.lang,
    required this.verse,
  });

  // From JSON
  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(
      id: json['_id'],
      name: json['name'],
      abbrev: json['abbrev'],
      chapter: json['chapter'],
      lang: json['lang'],
      verse: json['verse'], // Verse text
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'abbrev': abbrev,
      'chapter': chapter,
      'lang': lang,
      'verse': verse,
    };
  }
}

// Fetch Bible verses for a specific chapter
Future<List<BibleVerse>> fetchBibleVerses(
    String chapter, String language, String abbrev) async {
  final url =
      'https://basillia.genzit.xyz/api/v1/books/bible/verses?language=$language&abbrev=$abbrev&chapter=$chapter';

  try {
    print('Fetching verses from: $url');
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $jwt_token',
      'Content-Type': 'application/json',
    });

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];

      return data.map((verse) => BibleVerse.fromJson(verse)).toList();
    } else {
      print('Error fetching verses. Status: ${response.statusCode}');
      print('Response: ${response.body}');
      throw Exception('Failed to load verses.');
    }
  } catch (e) {
    print('Exception occurred: $e');
    throw Exception('Error fetching Bible verses: $e');
  }
}


class BibleReadingScreen extends StatefulWidget {
  final String abbrev; // Abbreviation for the book (e.g., GEN for Genesis)
  final String lang; // Language code (e.g., "en")
  final int chapter;
  final String ChapterName;

  const BibleReadingScreen({
    required this.abbrev,
    required this.lang,
    required this.chapter,
    required this.ChapterName,

  });

  @override
  _BibleReadingScreenState createState() => _BibleReadingScreenState();
}

class _BibleReadingScreenState extends State<BibleReadingScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int totalChapters = 0;
  String bookName = '';

  @override
  void initState() {
    super.initState();
    fetchBookDetails(); // Fetch total chapters and book name
  }

  Future<void> fetchBookDetails() async {
    try {
      setState(() {
        totalChapters = widget.chapter;
        bookName =
            widget.ChapterName; // Replace with actual book name if fetched from API
        _tabController = TabController(length: totalChapters, vsync: this);
      });
    } catch (e) {
      print('Error fetching book details: $e');
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (totalChapters == 0 || _tabController == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading...'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Bible › $bookName',
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.blue,
            indicatorWeight: 3,
            labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            tabs: List.generate(
              totalChapters,
              (index) => Column(
                children: [
                  const Text(
                    'Chap',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Text('${index + 1}',
                            style: const TextStyle(color: Colors.black)),
                        if (_tabController?.index == index)
                          const Icon(Icons.circle, size: 5, color: Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          totalChapters,
          (index) => BibleChapterContent(
            chapter: '${index + 1}',
            abbrev: widget.abbrev,
            lang: widget.lang,
          ),
        ),
      ),
    );
  }
}

class BibleChapterContent extends StatelessWidget {
  final String chapter;
  final String abbrev;
  final String lang;

  const BibleChapterContent({
    required this.chapter,
    required this.abbrev,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BibleVerse>>(
      future: fetchBibleVerses(chapter, lang, abbrev),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final verses = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: verses.length + 1, // +1 for the chapter title
            itemBuilder: (context, index) {
              // Add chapter header at the top
              if (index == 0) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Chapter $chapter',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }

              // Display verses with "Verse" prefix
              final verse = verses[index - 1]; // Adjust index for the header
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$index', // Use index (1-based) for numbering
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      verse.verse,
                      toolbarOptions:
                      const ToolbarOptions(copy: true, selectAll: true),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No verses found.'));
        }
      },
    );
  }
}

