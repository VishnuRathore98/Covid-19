import 'package:corona_app/screens/location_screen.dart';
import 'package:corona_app/screens/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Future WorldScreen1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WorldScreen()));
  }
    Future LocationScreen1(context) async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen()));
    }


  @override

  Widget build(BuildContext context) {
    int _currentindex =0;

    final CurvedNavigationBarState navBarState =
        _bottomNavigationKey.currentState;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: _currentindex,
          key:_bottomNavigationKey,
          height: 70.0,
          items: <Widget>[
            Icon(Icons.public, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.settings_input_svideo, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.info, size: 30,),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {

            switch (index){
              case 0: { WorldScreen1(context);
              _currentindex = index;
             }
              break;
              case 1: { LocationScreen1(context);
              _currentindex = index;}
              break;
              default : { print("defalut");}
              break;

            }
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                RaisedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    final CurvedNavigationBarState navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState.setPage(1);
                  },
                )
              ],
            ),
          ),
        ));
  }
}


