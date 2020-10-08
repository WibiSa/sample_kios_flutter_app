import 'package:flutter/material.dart';
import 'package:kiosku_app/items.dart';
import 'package:kiosku_app/product.dart';
import 'package:kiosku_app/productpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      storeTab(context),
      Text('Feed'),
      Text('Keranjang'),
      Text('Profile')
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar,
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _appbar = AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.purple,
    title: Text('Kiosku', textAlign: TextAlign.center),
    actions: <Widget>[
      IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(Icons.favorite),
        onPressed: () {},
        iconSize: 21,
      ),
      IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(Icons.alarm),
        onPressed: () {},
        iconSize: 21,
      ),
    ],
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget storeTab(BuildContext context) {
    List<Product> laptopGaming = [
      Product(
          name: "Lenovo Legion y 530",
          image: "assets/lenovo_legion_y530.jpg",
          price: 15000000,
          userLiked: true,
          discount: 10),
      Product(
          name: "Lenovo Legion y 520",
          image: "assets/lenovo_legion_y530.jpg",
          price: 13000000,
          userLiked: false,
          discount: 10),
      Product(
          name: "Lenovo Legion y 510",
          image: "assets/lenovo_legion_y530.jpg",
          price: 11000000,
          userLiked: false,
          discount: 10),
      Product(
          name: "Lenovo Legion y 540",
          image: "assets/lenovo_legion_y530.jpg",
          price: 18000000,
          userLiked: true,
          discount: 10),
    ];

    List<Product> laptopApple = [
      Product(
          name: "Macbook pro 2019",
          image: "assets/macbook.jpg",
          price: 27000000,
          userLiked: true,
          discount: 11),
      Product(
          name: "Macbook pro 2017",
          image: "assets/macbook.jpg",
          price: 18000000,
          userLiked: true,
          discount: 11),
      Product(
          name: "Macbook pro 2015",
          image: "assets/macbook.jpg",
          price: 13000000,
          userLiked: false,
          discount: 11),
      Product(
          name: "Macbook pro 2012",
          image: "assets/macbook.jpg",
          price: 9000000,
          userLiked: false,
          discount: 11),
    ];

    return ListView(
      children: <Widget>[
        deals('Laptop Gaming', onViewMore: () {}, items: <Widget>[
          productItem(
            laptopGaming[0],
            onTapped: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductPage(productData: laptopGaming[0]);
              }));
            },
            onLike: () {},
            imgWidth: 50,
          ),
          productItem(
            laptopGaming[1],
            onTapped: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductPage(productData: laptopGaming[1]);
              }));
            },
            onLike: () {},
          ),
          productItem(
            laptopGaming[2],
            onTapped: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductPage(productData: laptopGaming[2]);
              }));
            },
            onLike: () {},
            imgWidth: 120,
          ),
          productItem(
            laptopGaming[3],
            onTapped: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductPage(productData: laptopGaming[3]);
              }));
            },
            onLike: () {},
            imgWidth: 150,
          ),
        ]),
        deals('Laptop Apple', onViewMore: () {}, items: <Widget>[
          productItem(
            laptopApple[0],
            onTapped: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductPage(productData: laptopApple[0]);
              }));
            },
          ),
          productItem(
            laptopApple[1],
            onTapped: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductPage(productData: laptopApple[1]);
              }));
            },
          ),
          productItem(
            laptopApple[2],
            onTapped: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductPage(productData: laptopApple[2]);
              }));
            },
          ),
          productItem(
            laptopApple[3],
            onTapped: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductPage(productData: laptopApple[3]);
              }));
            },
          ),
        ])
      ],
    );
  }

  Widget deals(String dealTitle, {onViewMore, List<Widget> items}) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          sectionHeader(dealTitle, onViewMore: onViewMore),
          SizedBox(
            height: 250,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: (items != null)
                    ? items
                    : <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text('Tidak ada item tersedia'),
                        )
                      ]),
          )
        ],
      ),
    );
  }

  Widget sectionHeader(String headerTitle, {onViewMore}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 10),
          child: Text(headerTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 2),
          child: FlatButton(
            onPressed: onViewMore,
            child:
                Text('Lihat Semua ›', style: TextStyle(color: Colors.purple)),
          ),
        )
      ],
    );
  }

  // Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
  //   return Container(
  //     margin: EdgeInsets.only(left: 15),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         Container(
  //             margin: EdgeInsets.only(bottom: 10),
  //             width: 86,
  //             height: 86,
  //             child: FloatingActionButton(
  //               shape: CircleBorder(),
  //               heroTag: name,
  //               onPressed: onPressed,
  //               backgroundColor: Colors.white,
  //               child: Icon(icon, size: 35, color: Colors.black87),
  //             )),
  //         Text(name + ' ›')
  //       ],
  //     ),
  //   );
  // }
}
