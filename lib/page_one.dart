import 'package:anim_1/page_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lottie/lottie.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with TickerProviderStateMixin {
  double width = 300;
  double height = 300;
  Color color = Colors.red;
  double padding = 100;

  late AnimationController animationController;
  late AnimationController lottieAnimationController;
  late Animation<double> fancyAnimation;
  late Animation<double> circleAnimation;
  late Animation<double> circleFancyAnimation;
  late Animation<double> fastCircleFancyAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    lottieAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animationController.forward();
    animationController.repeat(reverse: true);

    fancyAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);

    circleAnimation =
        Tween<double>(begin: 0.0, end: 2 * 3.1415).animate(animationController);
    circleFancyAnimation =
        Tween<double>(begin: 0.0, end: 2 * 3.1415).animate(fancyAnimation);
    fastCircleFancyAnimation =
        Tween<double>(begin: 0.0, end: 2 * 3.1415).animate(CurvedAnimation(
      parent: fancyAnimation,
      curve: Interval(
        0.500,
        1.000,
        curve: Curves.ease,
      ),
    ));
  }

  @override
  void dispose() {
    animationController.dispose();
    lottieAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('2'),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PageTwo(),
        )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Lottie.asset(
                  'resources/lottie_sample.json',
                  controller: lottieAnimationController,
                  onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    lottieAnimationController
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
                SuperAnimationWidget(
                  listenable: animationController,
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: Duration(seconds: 5),
                  builder: (context, double value, widget) => FlutterLogo(
                    size: value * 500,
                    style: FlutterLogoStyle.stacked,
                    textColor: Color((0xAAAAAA00 + value * 0xFF).toInt()),
                  ),
                ),
                const AnimatedOpacity(
                  opacity: 0.5,
                  duration: kThemeAnimationDuration,
                  child: Icon(
                    Icons.flutter_dash,
                    size: 100,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: width,
                  height: height,
                  color: color,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    margin: EdgeInsets.all(padding),
                    color: Colors.lightGreen,
                  ),
                ),
                Slider(
                  min: 20,
                  max: 100,
                  value: padding,
                  onChanged: (value) {
                    setState(() {
                      padding = value;
                    });
                  },
                ),
                Slider(
                  min: 100,
                  max: 300,
                  value: width,
                  onChanged: (value) {
                    setState(() {
                      width = value;
                    });
                  },
                ),
                Slider(
                  min: 100,
                  max: 300,
                  value: height,
                  onChanged: (value) {
                    setState(() {
                      height = value;
                    });
                  },
                ),
                SizedBox(
                  width: 300,
                  height: 100,
                  child: BlockPicker(
                    pickerColor: color,
                    availableColors: const [
                      Colors.red,
                      Colors.yellow,
                      Colors.green,
                      Colors.blue,
                    ],
                    onColorChanged: (color) {
                      setState(() {
                        this.color = color;
                      });
                    },
                  ),
                ),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: animationController.value,
                      child: widget!,
                    );
                  },
                  child: const FlutterLogo(
                    size: 100,
                  ),
                ),
                AnimatedBuilder(
                  animation: fancyAnimation,
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: fancyAnimation.value,
                      child: widget!,
                    );
                  },
                  child: const FlutterLogo(
                    size: 100,
                  ),
                ),
                AnimatedBuilder(
                  animation: circleAnimation,
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: circleAnimation.value,
                      child: widget!,
                    );
                  },
                  child: const FlutterLogo(
                    size: 100,
                  ),
                ),
                AnimatedBuilder(
                  animation: circleFancyAnimation,
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: circleFancyAnimation.value,
                      child: widget!,
                    );
                  },
                  child: const FlutterLogo(
                    size: 100,
                  ),
                ),
                AnimatedBuilder(
                  animation: fastCircleFancyAnimation,
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: fastCircleFancyAnimation.value,
                      child: widget!,
                    );
                  },
                  child: const FlutterLogo(
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuperAnimationWidget extends AnimatedWidget {
  SuperAnimationWidget({required super.listenable});

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _progress.value * 2.0 * 3.1415,
      child: Icon(
        Icons.flutter_dash_sharp,
        size: _progress.value * 200,
        color: Colors.red,
      ),
    );
  }
}
