import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starbucks/colors.dart';
import 'dart:math' as math;
import 'Model/drink.dart';

class DrinkCard extends StatelessWidget {
  Drink drink;
  double pageOffset;
  double animation;
  double columnAnimation = 0;
  double animate;
  double rotate = 0;
  int index;
  DrinkCard(this.drink, this.pageOffset, this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = size.width - 60;
    double cardHeight = size.height * .55;
    double count = 0;
    rotate = index - pageOffset;

    double page;
    for (page = pageOffset; page > 1;) {
      page--;
      count++;
    }
    animation = Curves.easeOutBack.transform(page);
    animate = 100 * (count + animation);
    columnAnimation = 50 * (count + animation);
    for (int a = 0; a < index; a++) {
      animate -= 100;
      columnAnimation -= 50;
    }
    return Container(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          buildToptext(),
          buildBackgroundImage(cardWidth, cardHeight, size),
          buildAboveCard(cardWidth, cardHeight, size),
          buildCupImage(size),
          buildBlurImage(cardWidth, size),
          buildSmallImage(size),
          buildTopImage(size, cardHeight, cardWidth)
        ],
      ),
    );
  }

  Widget buildToptext() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          Text(
            drink.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: drink.lightColor),
          ),
          Text(
            drink.conName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: drink.darkColor),
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
        width: cardWidth,
        height: cardHeight,
        bottom: size.height * .15,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              drink.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget buildAboveCard(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: drink.darkColor.withOpacity(0.50),
            borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.all(30),
        child: Transform.translate(
          offset: Offset(-columnAnimation, 0),
          child: Column(
            children: <Widget>[
              Text(
                'Frappuccino',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                drink.description,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset("images/cupL.png"),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset("images/cupM.png"),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset("images/cupS.png"),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: appGreen, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '\$',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '4.',
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                      Text(
                        '80',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCupImage(Size size) {
    return Positioned(
      bottom: 20,
      right: -size.width * .2 / 1.3,
      child: Transform.rotate(
        angle: -math.pi / 14 * rotate,
        child: Image.asset(
          drink.cupImage,
          height: size.height * .55 - 15,
        ),
      ),
    );
  }

  Widget buildBlurImage(double cardWidth, Size size) {
    return Positioned(
      right: cardWidth / 2 - 60 + animate,
      bottom: size.height * .10,
      child: Image.asset(drink.blurImage),
    );
  }

  Widget buildSmallImage(Size size) {
    return Positioned(
        right: -10 + animate,
        top: size.height * .3,
        child: Image.asset(drink.smallImage));
  }

  Widget buildTopImage(Size size, double cardHeight, double cardWidth) {
    return Positioned(
        left: cardWidth / 4 - animate,
        bottom: size.height * .15 + cardHeight - 25,
        child: Image.asset(drink.topImage));
  }
}
