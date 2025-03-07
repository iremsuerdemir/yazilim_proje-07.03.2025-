import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/product.dart';
import 'package:yazilim_muh_proje/Models/product_items.dart';
import 'package:yazilim_muh_proje/Models/user_fav_items.dart';

class FavoritePage extends StatefulWidget {
  final int userId;

  const FavoritePage({super.key, required this.userId});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    List<int> favItemsId = UserFavItems.getAllValuesByUserId(widget.userId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorilerim",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:
          favItemsId.isEmpty
              ? Center(
                child: Text(
                  "Henüz favori ürün eklemediniz",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
              : ListView.builder(
                itemCount: favItemsId.length,
                itemBuilder: (context, i) {
                  // ID'ye göre favori ürünleri filtreliyoruz
                  var item = ProductItems.items.firstWhere(
                    (product) => product.id == favItemsId[i],
                    orElse:
                        () => Product(
                          id: 0,
                          category: "",
                          details: "",
                          name: "",
                          price: 0,
                          image: "",
                        ),
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Image.asset(item.image, fit: BoxFit.cover),
                            ),
                            SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "\$${item.price}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: Text(
                                            "${item.name} favorilerden çıkarılsın mı?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                  context,
                                                ); //Dialog'u kapatmak için
                                              },
                                              child: Text(
                                                "İptal",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  Navigator.pop(
                                                    context,
                                                  ); //Dialog'u kapatmak için
                                                  // Favorilerden çıkarma işlemi
                                                  UserFavItems.removeFavorite(
                                                    widget.userId,
                                                    item.id,
                                                  );
                                                  favItemsId =
                                                      UserFavItems.getAllValuesByUserId(
                                                        widget.userId,
                                                      );
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        "Ürün favorilerden kaldırıldı.",
                                                      ),
                                                      showCloseIcon: true,
                                                    ),
                                                  );
                                                });
                                              },
                                              child: Text(
                                                "Onayla",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
