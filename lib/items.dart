import 'package:flutter/material.dart';
import 'package:kiosku_app/product.dart';

Widget productItem(Product product,
    {double imgWidth, onLike, onTapped, bool isProductPage = false}) {
  return Container(
    width: 180,
    height: 200,
    margin: EdgeInsets.only(left: 20, bottom: 30),
    child: Stack(
      children: <Widget>[
        Container(
          width: 180,
          height: 300,
          child: RaisedButton(
              color: Colors.white,
              elevation: (isProductPage) ? 20 : 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: onTapped,
              child: Hero(
                  tag: product.name,
                  transitionOnUserGestures: true,
                  child: Image.asset(product.image,
                      width: (imgWidth != null) ? imgWidth : 100))),
        ),
        Positioned(
            bottom: 10,
            left: 10,
            child: (!isProductPage)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(product.name, style: TextStyle(fontSize: 16)),
                      SizedBox(height: 6),
                      Text(
                        "Rp ${product.price.toString()}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                : Text(' ')),
        Positioned(
            top: 10,
            left: 10,
            child: (product.discount != null)
                ? Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(50)),
                    child: Text("${product.discount.toString()} %",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  )
                : SizedBox(width: 0))
      ],
    ),
  );
}
