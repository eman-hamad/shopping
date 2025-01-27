import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'components/grid_view.dart';

// a Statefull Widget displays two 3 sections : pageview of images ,
// gridview of cards and listview of products

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2 lists to  make imgs and txt reusable
  var imgs = [
    "https://images.pexels.com/photos/2587370/pexels-photo-2587370.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/3612182/pexels-photo-3612182.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        "https://images.pexels.com/photos/2587370/pexels-photo-2587370.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  ];
  // translate to arabic
  var txts = [tr("item1"), tr("item2"), tr("item3"), tr("item1"), tr("item2")];
  @override
  Widget build(BuildContext context) {
    // set translatin to arabic
    context.setLocale(const Locale('en', 'US'));
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 204, 218, 225),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 229, 243),
          title: Center(
            // translate to arabic
            child: Text(tr("title"),
                style: const TextStyle(color: Colors.blueGrey)),
          ),
        ),
        // make page scrollable vertically
        body: SingleChildScrollView(
          child: SizedBox(
            height: 550,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: Text(
                      // translate to arabic
                      tr("section1"),
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // first section
                Expanded(
                  flex: 1,
                  child: PageView(children: [
                    Image(
                      image: NetworkImage(
                        imgs[0],
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 120,
                    ),
                    Image(
                      image: NetworkImage(
                        imgs[1],
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100,
                    ),
                    Image(
                      image: NetworkImage(
                        imgs[2],
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100,
                    ),
                  ]),
                ),
                // second section
                Expanded(
                  flex: 1,
                  child: GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 5,
                    ),
                    children: [
                      // reusable widget
                      MyGridContent(
                        img: imgs[0],
                        txt: txts[0],
                      ),
                      MyGridContent(
                        img: imgs[1],
                        txt: txts[1],
                      ),
                      MyGridContent(
                        img: imgs[2],
                        txt: txts[2],
                      ),
                    ],
                  ),
                ),
                Text(
                  // translate to arabic
                  tr("section2"),
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                // third section
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            Image(
                              image: NetworkImage(imgs[index]),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.16,
                            ),
                            Text(txts[index],
                                style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    },
                    itemCount: imgs.length,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
