import 'package:flutter/material.dart';

class ImagePlaceHolder extends StatefulWidget {
  String? url;
  double? height;
  double? width;
  BoxFit? fit;

  ImagePlaceHolder({this.url, this.height, this.width, this.fit});

  @override
  _ImagePlaceHolderState createState() => _ImagePlaceHolderState();
}

class _ImagePlaceHolderState extends State<ImagePlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.url!.isEmpty
          ? Image.network(
              "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
          : Image.network(
              widget.url.toString(),
              fit: widget.fit,
            ),
    );
  }
}
