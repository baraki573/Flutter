import 'package:flutter/material.dart';
import 'package:museum_app/login_page/login_page.dart';
import 'onboarding_data.dart';
import 'Page_indicator.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:museum_app/SizeConfig.dart';


class Onboarding extends StatefulWidget {
  Onboarding({Key key}) : super(key: key); //necessary? this will be by statefulbldr snippet created.

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  bool lastPage = false;
  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFFE6E6E6), Color(0xFFFFFFFF)],
            tileMode: TileMode.clamp,
            begin: Alignment.topCenter,
            stops: [0.0, 1.0],
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
              itemCount: pageList.length,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  if (currentPage == pageList.length - 1) {
                    lastPage = true;
                    animationController.forward();
                  } else {
                    lastPage = false;
                    animationController.reset();
                  }
                  print(lastPage);
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    var page = pageList[index];
                    var delta;
                    var y = 1.0;
                    if (_controller.position.haveDimensions) {
                      delta = _controller.page - index;
                      y = 1 - delta.abs().clamp(0.0, 1.0);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: SafeArea(
                            bottom: false,
                            child: Image.asset(page.imageUrl, 
                            width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 80 : SizeConfig.safeBlockHorizontal * 80, 
                            height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * 45 : SizeConfig.safeBlockVertical * 40,)
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16.0, right:16.0),
                          alignment: Alignment.center,
                          height: SizeConfig.safeBlockVertical * 30,
                          width: SizeConfig.safeBlockHorizontal * 100,
                          child: Stack(
                            children: <Widget>[
                              // Opacity(
                              //   opacity: .10,
                              //   child: GradientText(
                              //     page.title,
                              //     gradient: LinearGradient(
                              //         colors: pageList[index].titleGradient),
                              //     style: TextStyle(
                              //         fontSize: 30.0,
                              //         fontFamily: "Montserrat-Black",
                              //         letterSpacing: 1.0),
                              //   ),
                              // ),
                              Container(
                                padding: EdgeInsets.all(1.0),
                                margin: EdgeInsets.only(left:16.0, right:16.0, top:10.0, bottom:6.0),
                                alignment: Alignment.center,
                                child: GradientText(
                                  page.title,
                                  gradient: LinearGradient(
                                    colors: pageList[index].titleGradient),
                                  style: TextStyle(
                                    fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 12 : SizeConfig.safeBlockHorizontal * 7,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Transform(
                            transform:
                                Matrix4.translationValues(0, 50.0 * (1 - y), 0),
                              child: Text(
                              page.body,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 8 : SizeConfig.safeBlockHorizontal * 5,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF1A1A1A)),
                              )                                                     
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
            Positioned(
              left: 20.0,
              bottom: 25.0,
              child: Container(
                  width: 160.0,
                  child: PageIndicator(currentPage, pageList.length)),
            ),
            Positioned(
              right: 30.0,
              bottom: 30.0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: lastPage
                    ? FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LogIn()),
                        );},
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}