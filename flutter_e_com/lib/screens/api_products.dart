import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_ui_redesign/models/AllProductsModel.dart';
import 'package:http/http.dart' as http;

class HttpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<AllProductDetail>(
          future: getAllProduct(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              final product = snapshot.data;
              print("LENGTH:--" + product.data.length.toString());
//              if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          snapshot.data.data[index].productName.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Text(
                              "Rs " +
                                  snapshot.data.data[index].variants.data[0]
                                      .actualPrice
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                            SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data.data[index].variants.data[0].price
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red[300],
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                            SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "discount:" +
                                    snapshot.data.data[index].variants.data[0]
                                        .discount
                                        .toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green[400],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              "https://toppng.com/uploads/preview/free-food-plate-png-food-plate-above-11562895161lk3xxcz0yu.png"),
                        ),
                      ),
                    ),
                  );
                },
              );
//            }

//              final product = snapshot.data;
//              return Text(
//                  "Name :${product.data[0].productId} and ${product.data[0].productName}  \n Meta: ${product.meta.pagination.currentPage}");
            } else if (snapshot.hasError) {
              return Text("error:" + snapshot.error.toString());
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<AllProductDetail> getAllProduct() async {
  final url =
      "http://demo-api.gitodemos.com/v1/product?include=details,variants,variants.vendor,variants&client_id=8&client_secret=0Ut3EQ2jONe33HBK9B31Db2DQ9NFDXyI1ouO3iaW";
  final response = await http.get(url);

  if (response.statusCode == 200) {
//    final jsonProduct = jsonDecode(response.body);
//    return AllProductDetail.fromJson(jsonProduct);

    final AllProductDetail prod = allProductDetailFromJson(response.body);
//    print(prod.length);
    return prod;
  } else {
    throw Exception();
  }
}
