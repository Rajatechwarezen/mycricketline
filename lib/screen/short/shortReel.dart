import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return RotatedBox(
      quarterTurns: 1,
      child: TabBarView(
        controller: _tabController,
        children: List.generate(items.length, (index) {
          return VideoPlayerItem(
            imageUrl: items[index]['imageUrl']!,
            size: size,
            name: items[index]!['name']!,
            caption: items[index]['caption']!,
            songName: items[index]['songName']!,
            profileImg: items[index]['profileImg']!,
            likes: items[index]['likes']!,
            comments: items[index]['comments']!,
            shares: items[index]['shares']!,
            albumImg: items[index]['albumImg']!,
          );
        }),
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String caption;
  final String songName;
  final String profileImg;
  late final String likes;
  final String comments;
  final String shares;
  final String albumImg;
  final Size size;

  VideoPlayerItem({
    required this.imageUrl,
    required this.size,
    required this.name,
    required this.caption,
    required this.songName,
    required this.profileImg,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.albumImg,
  });

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  bool isShowPlaying = false;

  Widget isPlaying() {
    return isShowPlaying
        ? Container()
        : Icon(
            Icons.play_arrow,
            size: 80,
            color: Colors.white.withOpacity(0.5),
          );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isShowPlaying = !isShowPlaying;
        });
      },
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
          height: widget.size.height,
          width: widget.size.width,
          child: Stack(
            children: <Widget>[
              Container(
                height: widget.size.height,
                width: widget.size.width,
                decoration: BoxDecoration(color: Colors.black),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(),
                        child: isPlaying(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: widget.size.height,
                width: widget.size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 20,
                    bottom: 10,
                    right: 15,
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        HeaderHomePage(),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              LeftPanel(
                                size: widget.size,
                                name: widget.name,
                                caption: widget.caption,
                                songName: widget.songName,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // Handle the tap event for RightPanel
                                    print('RightPanel tapped!');
                                  },
                                  child: RightPanel(
                                    size: widget.size,
                                    likes: widget.likes,
                                    comments: widget.comments,
                                    shares: widget.shares,
                                    profileImg: widget.profileImg,
                                    albumImg: widget.albumImg,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(
            Icons.camera_alt,
            size: 25,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class LeftPanel extends StatelessWidget {
  final Size size;
  final String name;
  final String caption;
  final String songName;

  LeftPanel({
    required this.size,
    required this.name,
    required this.caption,
    required this.songName,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              caption,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              songName,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RightPanel extends StatefulWidget {
  final Size size;
  String likes;
  final String comments;
  final String shares;
  final String profileImg;
  final String albumImg;

  RightPanel({
    required this.size,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.profileImg,
    required this.albumImg,
  });

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  void increaseLikes() {
    setState(() {
      int likeCount = int.tryParse(widget.likes) ?? 0;
      likeCount++;
      widget.likes = likeCount.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profileImg),
            radius: 25,
          ),
          getIcons(
            Icons.favorite_border,
            widget.likes,
            35.0,
            increaseLikes,
          ),
          getIcons(
              Icons.chat_bubble_outline, widget.comments, 35.0, increaseLikes),
          getIcons(Icons.reply_outlined, widget.shares, 25.0, increaseLikes),
          CircleAvatar(
            backgroundImage: NetworkImage(widget.albumImg),
            radius: 25,
          ),
        ],
      ),
    );
  }
}

Widget getIcons(IconData icon, String count, double size, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: size,
        ),
        const SizedBox(height: 5),
        Text(
          count,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

List<Map<String?, String?>> items = [
  {
    'imageUrl': 'https://via.placeholder.com/400x300',
    'name': 'User 1',
    'caption': 'Caption 1',
    'songName': 'Song 1',
    'profileImg': 'https://via.placeholder.com/50x50',
    'likes': '100',
    'comments': '50',
    'shares': '30',
    'albumImg': 'https://via.placeholder.com/50x50',
  },
  {
    'imageUrl': 'https://via.placeholder.com/400x300',
    'name': 'User 2',
    'caption': 'Caption 2',
    'songName': 'Song 2',
    'profileImg': 'https://via.placeholder.com/50x50',
    'likes': '200',
    'comments': '70',
    'shares': '40',
    'albumImg': 'https://via.placeholder.com/50x50',
  },
  {
    'imageUrl': 'https://via.placeholder.com/400x300',
    'name': 'User 3',
    'caption': 'Caption 3',
    'songName': 'Song 3',
    'profileImg': 'https://via.placeholder.com/50x50',
    'likes': '150',
    'comments': '60',
    'shares': '20',
    'albumImg': 'https://via.placeholder.com/50x50',
  },
];
