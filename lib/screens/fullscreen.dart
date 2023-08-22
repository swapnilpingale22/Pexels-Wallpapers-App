// ignore_for_file:, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Fullscreen extends StatefulWidget {
  dynamic img;
  Fullscreen({super.key, required this.img});

  @override
  State<Fullscreen> createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {
  Future<void> setWallpaperHome() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file =
        await DefaultCacheManager().getSingleFile(widget.img['src']['large2x']);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    print('$result.  Wallpaper set to home screen');
    if (result == true) {
      await Fluttertoast.showToast(
          msg: "Wallpaper set to home screen",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  Future<void> setWallpaperLock() async {
    int location = WallpaperManager.LOCK_SCREEN;
    var file =
        await DefaultCacheManager().getSingleFile(widget.img['src']['large2x']);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    print('$result.  Wallpaper set to lockscreen');
    if (result == true) {
      await Fluttertoast.showToast(
          msg: "Wallpaper set to lockscreen",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                (widget.img['width'] > widget.img['height'])
                    ? Image.network(
                        widget.img['src']['large2x'],
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        widget.img['src']['large2x'],
                        fit: BoxFit.cover,
                      ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  bottom: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Wallpaper will be downloaded",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green.shade300,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black54.withOpacity(0.6),
                          radius: 38,
                          child: const Icon(
                            Icons.download,
                            size: 30,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: setWallpaperHome,
                        child: CircleAvatar(
                          backgroundColor: Colors.black54.withOpacity(0.6),
                          radius: 38,
                          child: const Icon(
                            Icons.add_to_home_screen,
                            size: 30,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setWallpaperLock();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black54.withOpacity(0.6),
                          radius: 38,
                          child: const Icon(
                            Icons.screen_lock_portrait,
                            size: 30,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  bottom: 0,
                  child: Container(
                    color: Colors.black54.withOpacity(0.6),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'By: ${widget.img['photographer']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  (widget.img['width'] > widget.img['height'])
                                      ? const Text(
                                          'Layout: Landscape',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )
                                      : const Text(
                                          'Layout: Portrait',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                  Text(
                                    'Size: ${widget.img['width']} x ${widget.img['height']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
