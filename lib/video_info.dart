import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:training_app/home_page.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  VideoPlayerController? _controller;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/videoinfo.json')
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: _playArea == false
          ? BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                  color.AppColor.gradientFirst.withOpacity(0.9),
                  color.AppColor.gradientSecond
                ],
                  begin: const FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight))
          : BoxDecoration(color: color.AppColor.gradientSecond),
      child: Column(
        children: [
          _playArea == false
              ? Container(
                  padding: EdgeInsets.only(top: 70, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => HomePage());
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            ),
                          ),
                          Expanded(child: Container()),
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: color.AppColor.secondPageIconColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Legs Toning',
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.secondPageTitleColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'and Glutes Workout',
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.secondPageTitleColor),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  color.AppColor
                                      .secondPageContainerGradient1stColor
                                      .withOpacity(0.4),
                                  color.AppColor
                                      .secondPageContainerGradient2ndColor
                                      .withOpacity(0.4),
                                ])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '68 min',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 220,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  color.AppColor
                                      .secondPageContainerGradient1stColor
                                      .withOpacity(0.4),
                                  color.AppColor
                                      .secondPageContainerGradient2ndColor
                                      .withOpacity(0.4),
                                ])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.handyman_outlined,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Resistent band, kettebell',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(top: 50, left: 30, right: 30),
                        height: 100,
                        child: Row(children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => HomePage());
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: color.AppColor.secondPageTopIconColor,
                            ),
                          ),
                          Expanded(child: Container()),
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: color.AppColor.secondPageTopIconColor,
                          ),
                        ]),
                      ),
                      _playView(context),
                      _controlView(context),
                    ],
                  ),
                ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
                color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Circuit 1: Legs Toning',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.circuitsColor),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Icon(
                          Icons.loop,
                          size: 30,
                          color: color.AppColor.loopColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '3 sets',
                          style: TextStyle(
                              fontSize: 15, color: color.AppColor.setsColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: _listView())
              ],
            ),
          ))
        ],
      ),
    ));
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        color: color.AppColor.gradientSecond,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  final index = _isPlayingIndex - 1;
                  if (index >= 0 && videoInfo.length > 0) {
                    _onTapVideo(index);
                  } else {
                    Get.snackbar(
                      'Video',
                      '',
                      snackPosition: SnackPosition.BOTTOM,
                      icon: Icon(Icons.face, size: 30, color: Colors.white),
                      backgroundColor:
                          color.AppColor.gradientSecond.withOpacity(0.6),
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                      messageText: Text('No more video to play',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    );
                  }
                  ;
                },
                icon: Icon(Icons.fast_rewind, size: 36, color: Colors.white)),
            SizedBox(
              width: 30,
            ),
            IconButton(
                onPressed: () async {
                  if (_isPlaying) {
                    setState(() {
                      _isPlaying = false;
                    });
                    _controller?.pause();
                  } else {
                    setState(() {
                      _isPlaying = true;
                    });
                    _controller?.play();
                  }
                },
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 36, color: Colors.white)),
            SizedBox(
              width: 30,
            ),
            IconButton(
                onPressed: () async {
                  final index = _isPlayingIndex + 1;
                  if (index <= videoInfo.length - 1) {
                    _onTapVideo(index);
                  } else {
                    Get.snackbar(
                      'Video',
                      '',
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(10),
                      icon: Icon(Icons.face, size: 30, color: Colors.white),
                      backgroundColor:
                          color.AppColor.gradientSecond.withOpacity(0.6),
                      colorText: Colors.white,
                      duration: const Duration(seconds: 3),
                      messageText: Text(
                          'You have finished watchig all the videos. Congrats!',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    );
                  }
                  ;
                },
                icon: Icon(Icons.fast_forward, size: 36, color: Colors.white)),
          ],
        ),
      ),
      InkWell(
        onTap: () {
          if (noMute) {
            _controller?.setVolume(0);
          } else {
            _controller?.setVolume(1.0);
          }
          setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            child: Icon(
              noMute ? Icons.volume_up : Icons.volume_off,
              color: Colors.white,
              size: 25,
            ),
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.0,
                  color: Color(0x31000000))
            ]),
          ),
        ),
      ),
    ]);
  }

  void _onControllerUpdate() async {
    var _onUpdateControllerTime;
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().microsecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }

    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint('controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint('controller can not be initialized');
      return;
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _onTapVideo(int index) async {
    final controller =
        VideoPlayerController.network(videoInfo[index]['videoUrl']);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _listView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      itemCount: videoInfo.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
            onTap: () {
              _onTapVideo(index);
              debugPrint(index.toString());
              setState(() {
                if (_playArea == false) {
                  _playArea = true;
                }
              });
            },
            child: _buildCard(index));
      },
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text(
            'Preparing...',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )));
    }
  }

  _buildCard(int index) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(
                          videoInfo[index]['thumbnail'],
                        ),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[index]['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(videoInfo[index]['time'],
                      style: TextStyle(fontSize: 18, color: Colors.grey[500]))
                ],
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFFeaeefc),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    '15s rest',
                    style: TextStyle(color: Color(0xff839fed)),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                                color: Color(0xff839fed),
                                borderRadius: BorderRadius.circular(2)),
                          )
                        : Container(
                            width: 3,
                            height: 1,
                            color: Colors.white,
                          ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
