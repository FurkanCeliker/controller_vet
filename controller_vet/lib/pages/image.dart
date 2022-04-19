import 'package:controller_vet/constant/constants.dart';
import 'package:flutter/material.dart';

class ImageGet extends StatefulWidget {
  String url;
  ImageGet({Key? key,required String this.url}) : super(key: key);

  @override
  State<ImageGet> createState() => _ImageGetState();
}

class _ImageGetState extends State<ImageGet> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.url,
      child: Container(
        height: Constants.getSizeHeight(context),
        width: Constants.getSizeWidth(context),
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.url))),
      ),
    );
  }
}