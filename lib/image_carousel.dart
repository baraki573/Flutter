import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'SizeConfig.dart';

class ImageCaroussel extends StatefulWidget {
  final List<AssetImage> images;

  const ImageCaroussel.fromImages(this.images, {Key key}) : super(key: key);

  ImageCaroussel.fromStrings(List<String> list, {Key key})
      : images = List<AssetImage>(),
        super(key: key) {
    for (var s in list) {
      try {
        AssetImage a = AssetImage(s);
        images.add(a);
      } catch (e) {
        continue;
      }
    }
  }

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCaroussel> {
  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images == null || widget.images.isEmpty) return Container();
    var tag = DateTime.now().toString();
    return Column(children: [
      CarouselSlider(
        //enlargeCenterPage: true,
        onPageChanged: (index) => setState(() => _currentImage = index),
        viewportFraction: 1.0,
        height: verSize(52, 68.5),
        enableInfiniteScroll: false,
        items: widget.images
            .map(
              (img) => GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => _ImageDetail(tag, img))),
                //_ImageDetail("A", img))),
                //onTap: () => _imagePopup(widget.stop.imgs[_currentImage]),
                child: Container(
                  //color: Colors.green,
                  //height: verSize(52, 68.5),
                  //margin: EdgeInsets.symmetric(horizontal: 16),
                  //height: SizeConfig.safeBlockVertical * 40,
                  //width: SizeConfig.safeBlockHorizontal * 100,
                  //decoration: BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  //border: Border.all(color: Colors.black),
                  //image: DecorationImage(image: img, fit: BoxFit.cover),
                  //),
                  child: Hero(
                    transitionOnUserGestures: true,
                    child: Image(
                        //height: verSize(57, 68.5),
                        width: horSize(100, 100),
                        image: img,
                        fit: BoxFit.cover),
                    tag: tag,
                  ),
                ),
                /*Positioned(
                      top: 7,
                      right: 23,
                      height: SizeConfig.safeBlockVertical * 6,
                      width: SizeConfig.safeBlockVertical * 6,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.all(0),
                        color: Colors.black.withOpacity(0.3),
                        child: Icon(Icons.zoom_out_map,
                            color: Colors.white, size: 30),
                        onPressed: () {
                          _imagePopup(widget.stop.imgs[_currentImage]);
                        },
                      ),*/
              ),
            )
            .toList(),
      ),
      // Dot Indicator
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.images.length,
          (index) => Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentImage == index
                  ? Colors.black
                  : Colors.grey.withOpacity(0.75),
            ),
          ),
        ),
      ),
    ]);
  }
}

class _ImageDetail extends StatelessWidget {
  final ImageProvider _img;
  final _tag;

  _ImageDetail(this._tag, this._img);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        //onVerticalDragEnd: (a)=>print(a.primaryVelocity),
        child: Stack(
          children: [
            PhotoView(
              heroAttributes: PhotoViewHeroAttributes(
                  tag: _tag, transitionOnUserGestures: true),
              imageProvider: _img,
              maxScale: 3.0,
              minScale: PhotoViewComputedScale.contained,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            Positioned(
              top: 35,
              left: 7,
              height: SizeConfig.safeBlockVertical * 6,
              width: SizeConfig.safeBlockVertical * 6,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(0),
                color: Colors.black.withOpacity(0.3),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
