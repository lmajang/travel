import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:path/path.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  void initState() {
    _tabController = TabController(length: (3), vsync: this);
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<String> path = [
    'p1.png',
    'p5.png',
    'p12.png',
    'p13.png',
    'p20.png',
    'p21.png',
    'p2.png',
    'p6.png',
    'p11.png',
    'p14.png',
    'p19.png',
    'p22.png',
    'p3.png',
    'p7.png',
    'p10.png',
    'p15.png',
    'p18.png',
    'p23.png',
    'p4.png',
    'p8.png',
    'p9.png',
    'p16.png',
    'p17.png',
    'p24.png',
    'p1.png',
    'p5.png',
    'p12.png',
    'p13.png',
    'p20.png',
    'p21.png',
    'p2.png',
    'p6.png',
    'p11.png',
    'p14.png',
    'p19.png',
    'p22.png',
  ];

  final List<String> headers = [
    "h10",
    "h5",
    "h6",
    "h2",
    "h4",
    "h3",
    "h2",
    "h7"
  ];

  final List<String> routePath = [
    "assets/profileImages/p3.png",
    "assets/profileImages/p6.png",
    "assets/profileImages/p4.png",
    "assets/profileImages/p10.png",
    "assets/profileImages/p16.png",
    "assets/profileImages/p19.png",
    "assets/profileImages/p8.png",
    "assets/profileImages/p14.png",
    "assets/profileImages/p13.png",
    "assets/profileImages/p15.png",
    "assets/profileImages/p17.png",
    "assets/profileImages/p18.png",
    "assets/profileImages/p11.png",
  ];

  Widget _buildProfileView() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = (constraints.maxWidth - 4) / 3;
      return Wrap(
        spacing: 2,
        runSpacing: 2,
        children: [
          for (final p in path)
            Image(
              image: AssetImage("assets/profileImages/$p"),
              width: width,
              height: width,
              fit: BoxFit.cover,
            ),
        ],
      );
    });
  }

  BoxDecoration _buildButtonDecoration(String imageName,) {
    return BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: AssetImage(
          'assets/images/$imageName.jpg',
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildButtonText(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBorderDecoration(Color color) {
    return BoxDecoration(
      shape: BoxShape.circle,
      // borderRadius: const BorderRadius.all(
      //   Radius.circular(15.0),
      // ),
      border: Border.fromBorderSide(
        BorderSide(
          color: color,
          width: 1.8,
        ),
      ),
    );
  }

  Widget _buildHeaderViewList(Color color, String text) {
    return Container(
        decoration: _buildBorderDecoration(color),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            child: Stack(
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: _buildButtonDecoration(text),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    //splashFactory: widget.buttonData.inkFeatureFactory ??
                    //InkRipple.splashFactory,
                    //onTap: _onTap,
                    child: const SizedBox(
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildPersistentHeader({double? minHeight, double? maxHeight}) =>
      SliverPersistentHeader(
        pinned: true,
        delegate: _SliverAppBarDelegate(
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: _tabs,
          ),
          maxHeight: maxHeight ?? 45.0,
          minHeight: minHeight ?? 45.0,
        ),
      );

  Widget _buildUserInformation() {
    return Stack(
      children: [
        // 用户头像
        Positioned(
          top: 25.0,
          left: 16.0,
          child: Container(
              decoration: _buildBorderDecoration(Colors.orange),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: _buildButtonDecoration('h9'),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          //splashFactory: widget.buttonData.inkFeatureFactory ??
                          //InkRipple.splashFactory,
                          //onTap: _onTap,
                          child: const SizedBox(
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
        Positioned(
          top: 50.0,
          right: 58.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('517',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              height: 1,
                              fontWeight: FontWeight.w500)),
                      Text('帖子',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              height: 1,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(17)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('25万',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              height: 1,
                              fontWeight: FontWeight.w500)),
                      Text('粉丝',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              height: 1,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(17)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('51',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              height: 1,
                              fontWeight: FontWeight.w500)),
                      Text('关注',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              height: 1,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 145,
          left: 25,
          child: Text(
              "Capturing & Sharing Siesta Key Beach Life 📸💫\n"
              "📍 Siesta Key, FL\n"
              "📸 prints available on my website or DM\n"
              "📸 Photos/Reels shareable w/credit",
              style: TextStyle(
                  //fontFamily: 'Finesse-Future',
                  color: Colors.black,
                  fontSize: 17,
                  height: 1.3,
                  fontWeight: FontWeight.w300)),
        ),
        // Positioned(
        //   top: 250,
        //   left: 16,
        //   child: SizedBox(
        //     height: 70,
        //     child: ListView.builder(
        //         physics: const ClampingScrollPhysics(),
        //         shrinkWrap: true,
        //         scrollDirection: Axis.horizontal,
        //         itemCount: headers.length,
        //         itemBuilder: (BuildContext context, int index) =>
        //             _buildHeaderViewList(Colors.orange, headers[index])
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget _buildRouteView(){
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: ListView.builder(
          itemCount: routePath.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondPage(heroTag: index,routePath:routePath)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Hero(
                      tag: index,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        // child: Image.network(
                        //   _images[index],
                        //   width: 200,
                        // ),
                        child: Image(
                          image: AssetImage(routePath[index]),
                          width: 200,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(
                          'Title: $index',
                          style: Theme.of(context).textTheme.headline6,
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _mainView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 250,
            child: _buildUserInformation(),
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 70,
              child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: headers.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildHeaderViewList(Colors.orange, headers[index])),
            ),
          ),
        ),
        _buildPersistentHeader(),
        SliverFillRemaining(
          fillOverscroll: true,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildProfileView(),
              _buildProfileView(),
              _buildRouteView(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        //primary: true,
        // leading:GFIconButton(
        //   icon: Icon(
        //     Icons.message,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {},
        //   type: GFButtonType.transparent,
        // ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          'TravelBy',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Finesse',
              fontWeight: FontWeight.w600,
              fontSize: 33),
        ),
        actions: <Widget>[
          GFIconButton(
            icon: const Icon(
              EvaIcons.plus_square_outline,
              color: Colors.black38,
              shadows: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 18, // Shadow position
                )
              ],
            ),
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
          GFIconButton(
            icon: const Icon(
              TDIcons.view_list,
              color: Colors.black38,
              shadows: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 18, // Shadow position
                )
              ],
            ),
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
        ],
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
      ),
      body: _mainView(context),
    );
  }
}

const _tabs = [
  Tab(
      icon: Icon(
    EvaIcons.film_outline,
    size: 30,
  )),
  Tab(
      icon: Icon(
    EvaIcons.heart,
    size: 30,
  )),
  Tab(
      icon: Icon(
    EvaIcons.map_outline,
    size: 30,
  )),
];

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(
    this._tabBar, {
    required this.maxHeight,
    required this.minHeight,
  });
  final double maxHeight;
  final double minHeight;
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}

class SecondPage extends StatelessWidget {
  final int heroTag;
  final List<String> routePath;
  const SecondPage({Key? key, required this.heroTag ,required this.routePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hero ListView Page 2")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: AssetImage(routePath[heroTag]),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Content goes here",
              style: Theme.of(context).textTheme.headline5,
            ),
          )
        ],
      ),
    );
  }
}