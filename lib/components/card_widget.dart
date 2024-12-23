import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  String img;
  String txt;
  CardWidget({super.key, required this.img, required this.txt});
//card widget to build gridview contains column of imge and row has txt and icon
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: Image(
                image: NetworkImage(img),
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height *0.2 ,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: [
                Text(txt,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      var snackBar = const SnackBar(
                          content: Text('item added to the cart'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: const Icon(Icons.add_shopping_cart_outlined))
              ],
            ),
          )
        ],
      ),
    );
  }
}
