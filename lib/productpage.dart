import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosku_app/items.dart';
import 'package:kiosku_app/product.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

//untuk platform channel
const PLATFORM_CHANNEL = "com.kiosku.kiosku_app.channel";
const KEY_NATIVE = "showPaymentMidtrans";

class ProductPage extends StatefulWidget {
  final String pageTitle;
  final Product productData;

  ProductPage({Key key, this.pageTitle, this.productData}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //inisialisai platform
  static const platform = const MethodChannel(PLATFORM_CHANNEL);

  double _rating = 4.5;
  int _quantity = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar(widget.productData.name),
      body: ListView(
        children: <Widget>[
          //base layout 1
          Container(
            //color: Colors.red,
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: Stack(
                //stack layout
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      //base layout 2
                      margin: EdgeInsets.only(top: 100, bottom: 100),
                      padding: EdgeInsets.only(top: 100, bottom: 50),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //part nama produk
                          Text(widget.productData.name),
                          //part harga produk
                          Text("Rp ${widget.productData.price.toString()}"),
                          //part rating produk
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 20),
                            child: SmoothStarRating(
                              allowHalfRating: true,
                              onRated: (v) {
                                setState(() {
                                  _rating = v;
                                });
                              },
                              starCount: 5,
                              rating: _rating,
                              size: 27,
                              color: Colors.amber,
                              borderColor: Colors.amber,
                            ),
                          ),
                          //part quantity produk
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 25),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text('Jumlah'),
                                  margin: EdgeInsets.only(bottom: 15),
                                ),
                                // bagian + / - jumlah barang yg dibeli
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // + btn
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: OutlineButton(
                                        onPressed: () {
                                          setState(() {
                                            _quantity += 1;
                                          });
                                        },
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                    //quantity text
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Text(_quantity.toString()),
                                    ),
                                    // - btn
                                    Container(
                                      width: 55,
                                      height: 55,
                                      child: OutlineButton(
                                        onPressed: () {
                                          setState(() {
                                            if (_quantity == 1) return;
                                            _quantity -= 1;
                                          });
                                        },
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          //part btn beli
                          Container(
                            width: 100,
                            child: RaisedButton(
                              onPressed: () {
                                _showNativeView(); //akses platform channel untuk pake midtrans
                              },
                              child: Text('Beli'),
                            ),
                          ),
                        ],
                      ),
                      //decor untuk base layout 2
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                spreadRadius: 5,
                                color: Color.fromRGBO(0, 0, 0, 0.5))
                          ]),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 220,
                      height: 160,
                      margin: EdgeInsets.only(top: 40),
                      child: productItem(widget.productData,
                          isProductPage: true,
                          onTapped: () {},
                          imgWidth: 250,
                          onLike: () {}),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appbar(String title) {
    return AppBar(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      backgroundColor: Colors.purple,
      elevation: 0,
      leading: BackButton(color: Colors.white),
    );
  }

  //fungsi implementasi platform channel
  Future<Null> _showNativeView() async {
    await platform.invokeMethod(KEY_NATIVE, {
      "name": widget.productData.name,
      "price": widget.productData.price,
      "quantity": _quantity
    });
  }
}
