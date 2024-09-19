import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Style/colors.dart';
import '../Style/style.dart';
import 'groupsScreen.dart'; // Assuming primary, bordar, and primaryTxt colors are defined here

// Simulating a random data generator for posts
class PostData {
  final String userName;
  final String userRole;
  final String content;
  final List<String> tags;
  final int voteCount;
  final int commentCount;
  final String imageUrl;

  PostData({
    required this.userName,
    required this.userRole,
    required this.content,
    required this.tags,
    required this.voteCount,
    required this.commentCount,
    required this.imageUrl,
  });
}

// Dummy random data generator
List<PostData> generateRandomPosts(int count) {
  final random = Random();
  final sampleUserNames = [
    'John Doe',
    'Tiana Rosser',
    'Jane Smith',
    'Alex Roe'
  ];
  final sampleRoles = ['Artist', 'Song Writer', 'Photographer', 'Director'];
  final sampleContents = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'Vestibulum commodo nisl ac eros euismod, a lobortis purus egestas.',
    'Sed facilisis laoreet tristique. Donec elementum auctor aliquam.',
    'Donec elementum auctor aliquam. Vivamus in magna posuere.'
  ];
  final sampleTags = ['Music', 'Entertainment', 'Art', 'Technology'];
  final sampleImages = [
    '',
    'https://via.placeholder.com/150', // Simulating an image URL
  ];

  return List.generate(count, (index) {
    return PostData(
      userName: sampleUserNames[random.nextInt(sampleUserNames.length)],
      userRole: sampleRoles[random.nextInt(sampleRoles.length)],
      content: sampleContents[random.nextInt(sampleContents.length)],
      tags: [
        sampleTags[random.nextInt(sampleTags.length)],
        sampleTags[random.nextInt(sampleTags.length)],
      ],
      voteCount: random.nextInt(500),
      commentCount: random.nextInt(50),
      imageUrl: sampleImages[random.nextInt(sampleImages.length)],
    );
  });
}

class ForumsProfile extends StatelessWidget {
  ForumsProfile({super.key});

  final List<PostData> randomPosts =
      generateRandomPosts(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 131,
                  color: primary,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 70, left: 150, right: 150),
                  child: randomPosts[0].imageUrl.isEmpty
                      ? Container(
                          height: 104,
                          width: 104,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                        )
                      : Container(
                          height: 104,
                          width: 104,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: Image.network(
                            randomPosts[0].imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    randomPosts[0].userName,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    randomPosts[0].userRole,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 30),

                  // Section for "My Post"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Post',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      seeAllButton(onTap: () {})
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Using ListView.builder inside a Column
                  ListView.builder(
                    shrinkWrap: true, // Important to avoid scroll conflict
                    primary: false,
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable ListView's scrolling
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: forumPost(
                          userName: randomPosts[index].userName,
                          userRole: randomPosts[index].userRole,
                          content: randomPosts[index].content,
                          tags: randomPosts[index].tags,
                          voteCount: randomPosts[index].voteCount,
                          commentCount: randomPosts[index].commentCount,
                          imageUrl: randomPosts[index].imageUrl,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),

                  // Section for "Saved Post"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Saved Post',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      seeAllButton(onTap: () {
                        Get.to(() => GroupsScreen());
                      })
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Reusing ListView.builder for saved posts
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: forumPost(
                          userName: randomPosts[index].userName,
                          userRole: randomPosts[index].userRole,
                          content: randomPosts[index].content,
                          tags: randomPosts[index].tags,
                          voteCount: randomPosts[index].voteCount,
                          commentCount: randomPosts[index].commentCount,
                          imageUrl: randomPosts[index].imageUrl,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
