import 'package:flutter/material.dart';

class BibleReadingScreen extends StatefulWidget {
  @override
  _BibleReadingScreenState createState() => _BibleReadingScreenState();
}

class _BibleReadingScreenState extends State<BibleReadingScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Bible › Genesis',
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Hide Options',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.blue,
            indicatorWeight: 3,
            labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            tabs: List.generate(
              7,
                  (index) => Column(
                children: [
                  Text(
                    'Chap',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Text('${index + 1}', style: TextStyle(color: Colors.black)),
                        if (_tabController?.index == index)
                          Icon(Icons.circle, size: 5, color: Colors.blue), // Indicator dot for selected tab
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
          7,
              (index) => BibleChapterContent(),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class BibleChapterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chapter 1\nBroken Ribs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SelectableText.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                    "That summer, while her boy is on vacation with their father, she goes to visit her lover in Berlin.\n\n",
                  ),
                  WidgetSpan(
                    child: CustomSelectableOverlay(
                      child: const Text(
                        "A meters tall and built like a heavyweight...",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomSelectableOverlay extends StatelessWidget {
  final Widget child;
  const CustomSelectableOverlay({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // Show overlay menu for Copy and Highlight
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(100, 300, 100, 100), // Adjust position as needed
          items: [
            PopupMenuItem(
              value: 'copy',
              child: Row(
                children: const [
                  Icon(Icons.copy, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Copy'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'highlight',
              child: Row(
                children: const [
                  Icon(Icons.highlight, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Highlight'),
                ],
              ),
            ),
          ],
        );
      },
      child: child,
    );
  }
}

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.bookmark_border, color: Colors.black54),
                SizedBox(height: 4),
                Text('Chapter 1', style: TextStyle(color: Colors.black54)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.brightness_3, color: Colors.black54),
                SizedBox(height: 4),
                Text('Night Mode', style: TextStyle(color: Colors.black54)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.text_fields, color: Colors.black54),
                SizedBox(height: 4),
                Text('Font', style: TextStyle(color: Colors.black54)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.more_horiz, color: Colors.black54),
                SizedBox(height: 4),
                Text('More', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
