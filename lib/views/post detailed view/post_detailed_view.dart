import 'package:flutter/material.dart';

class PostDetailedView extends StatefulWidget {
  const PostDetailedView({super.key, required this.snap});
  final snap;

  @override
  State<PostDetailedView> createState() => _PostDetailedViewState();
}

class _PostDetailedViewState extends State<PostDetailedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag:'hello',
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.snap['postUrl']),
            ),
          ),
        ),
      ),
    );
  }
}
