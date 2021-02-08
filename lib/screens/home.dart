import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starbucks/Model/drink.dart';
import 'package:starbucks/drinkCard.dart';

import '../colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  PageController pageController;
  double PageOffset = 0;
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction: .8);
    pageController.addListener(() {
      setState(() {
        PageOffset = pageController.page;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildAppbar(),
            buildLogo(size),
            buildPager(size),
            buildPagerIndecator()
          ],
        ),
      ),
    );
  }

  Widget buildAppbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return Transform.translate(
                    offset: Offset(
                      -200 * (1 - animation.value),
                      0,
                    ),
                    child: Image.asset(
                      'images/location.png',
                      width: 30,
                      height: 30,
                    ));
              }),
          Spacer(),
          AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return Transform.translate(
                  offset: Offset(200 * (1 - animation.value), 0),
                  child: Image.asset(
                    'images/drawer.png',
                    width: 30,
                    height: 30,
                  ),
                );
              }),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
        top: 10,
        right: size.width / 2 - 25,
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform(
                transform: Matrix4.identity()
                  ..translate(0.0, size.height / 2 * (1 - animation.value))
                  ..scale(1 + (1 - animation.value)),
                origin: Offset(25, 25),
                child: InkWell(
                  onTap: () => controller.isCompleted
                      ? controller.reverse()
                      : controller.forward(),
                  child: Image.asset(
                    'images/logo.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              );
            }));
  }

  Widget buildPager(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(400 * (1 - animation.value), 0),
              child: PageView.builder(
                itemCount: getDrinks().length,
                controller: pageController,
                itemBuilder: (context, index) =>
                    DrinkCard(getDrinks()[index], PageOffset, index),
              ),
            );
          }),
    );
  }

  List<Drink> getDrinks() {
    List<Drink> list = [];
    list.add(Drink(
        'Tirami',
        'Su',
        'images/TiramisuBg.png',
        'images/beanTop.png',
        'images/beanSmall.png',
        'images/beanBlur.png',
        'images/TriamsuiCup.png',
        'then top with whipped cream and mocha drizzle to bring you endless java joy',
        brownLight,
        brownDark));

    list.add(Drink(
        'Green',
        'Tea',
        'images/GreenTeaBG.png',
        'images/green.png',
        'images/greenSmall.png',
        'images/greenBlur.png',
        'images/greenteaCup.png',
        'milk and ice and top it with sweetened whipped cream to give you a delicious boost of energy.',
        greenLight,
        greenDark));

    list.add(Drink(
        'Triple',
        'Mocha',
        'images/GreenMochabBG.png',
        'images/chocolateTop.png',
        'images/chocolateSmall.png',
        'images/chocolateBlur.png',
        'images/mochaCup.png',
        'layers of whipped cream that’s infused with cold brew, white chocolate mocha and dark cramel',
        brownLight,
        brownDark));
    return list;
  }

  Widget buildPagerIndecator() {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Row(
        children:
            List.generate(getDrinks().length, (index) => buildContainer(index)),
      ),
    );
  }

  Widget buildContainer(int index) {
    double animate = PageOffset - index;
    double size = 10;
    animate = animate.abs();
    Color color = Colors.grey;
    if (animate < 1 && animate >= 0) {
      size = 10 + 10 * (1 - animate);
      color = ColorTween(begin: Colors.grey, end: appGreen)
          .transform((1 - animate));
    }
    return Container(
      margin: EdgeInsets.all(4),
      height: size,
      width: size,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
    );
  }
}
