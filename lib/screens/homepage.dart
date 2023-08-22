import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import '../constants/strings.dart';
import 'fullscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List images = [];
  int pageNo = 1;

  final Map<String, String> headers = {
    // ignore: unnecessary_string_interpolations
    'Authorization': '$apiKey',
  };

  fetchWallpaper() async {
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      setState(() {
        images = jsonData['photos'];
      });
      print('>>>>> Total ${images.length} photos fetched from API <<<<<');
    }
  }

  loadMore() async {
    setState(() {
      pageNo = pageNo + 1;
    });
    String url2 =
        "https://api.pexels.com/v1/curated?per_page=78&page=${pageNo.toString()}";
    var response = await http.get(
      Uri.parse(url2),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      setState(() {
        images.addAll(jsonData['photos']);
      });
      print('>>>>> Total ${images.length} photos in the images <<<<<');
    }
  }

  @override
  void initState() {
    fetchWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: MasonryGridView.builder(
                shrinkWrap: true,
                itemCount: images.length,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                physics: const BouncingScrollPhysics(),
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Fullscreen(
                          img: images[index],
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      images[index]['src']['tiny'],
                      fit: BoxFit.cover,
                      height: 200,
                      width: 280,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            height: 50,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total ${images.length} wallpapers'),
                    TextButton(
                      onPressed: () => loadMore(),
                      child: const Text(
                        'Load More 🔻',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
