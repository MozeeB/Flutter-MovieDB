import 'package:flutter/material.dart';
import 'package:flutter_movie_db/model/menu_item.dart';
import 'package:flutter_movie_db/model/paginated_search_results.dart';
import 'package:flutter_movie_db/page/fragment_page.dart';
import 'package:flutter_movie_db/page/movie/search_widget.dart';
import 'package:flutter_movie_db/service/movie_service.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key key}) : super(key: key);

  final menuItems = [
    new MenuItem("Home", Icons.home),
    new MenuItem("Now Playing", Icons.play_circle_outline),
    new MenuItem("Top Rated", Icons.rate_review),
    new MenuItem("Upcoming", Icons.airplay)
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedDrawerIndex = 0;
  SearchBar searchBar;
  String searchQuery = "";

  PaginatedSearchResults searchResults;


  _HomePageState() {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        closeOnSubmit: false,
        clearOnSubmit: false,
        onSubmitted: (String query) {
          setState(() {
            searchQuery = query;
            var call = MovieDB.getInstance().search(searchQuery);
            call.then((result) {
              setState(() {
                this.searchResults = result;
              });
            });
          });
        },
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text(widget.menuItems[_selectedDrawerIndex].title),
        actions: [searchBar.getSearchAction(context)]);
  }

  _getDrawerFragment(int pos) {
    switch (pos) {
      case 0:
        return Home();
      case 1:
        return NowPlaying();
      case 2:
        return TopRated();
      case 3:
        return Upcoming();
      case 4:
        return About();
      default:
        return new Text("Error");
    }
  }
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {

    List<Widget> drawerOptions = [];

    for (var i = 0; i < widget.menuItems.length; i++) {
      var d = widget.menuItems[i];
      drawerOptions.add(
           ListTile(
            leading:  Icon(d.icon),
            title:  Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }


    return Scaffold(
      appBar: searchBar.build(context),
      drawer:  Drawer(
        child:  Column(
          children: <Widget>[
             UserAccountsDrawerHeader(
              accountName:  Text("Flutter Movie"),
              currentAccountPicture:  CircleAvatar(
                backgroundImage: AssetImage("assets/bioicon.png"),),
              decoration:  BoxDecoration(
                  color: Colors.blue
              ), accountEmail: Text("Mujiburr741@gmail.com"),
            ),
             Column(children: drawerOptions),
            Divider(),
             Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('About'),
                  onTap: () {
                    Toast.show("Coming Soon!", context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
      body: (() {
        if(searchBar.isSearching.value == true){
          return SearchMovieWidget(searchResults);

        }else{
          return _getDrawerFragment(_selectedDrawerIndex);
        }
      }())
    );
  }
}
