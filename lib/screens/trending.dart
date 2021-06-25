import 'package:check_my_news/model/newsClass.dart';
import 'package:check_my_news/services/backend.dart';
import 'package:flutter/material.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  late Future<News> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchTrendingNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<News>(
      future: futureNews,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image.network(
                          snapshot.data!.value[index]['image']['url']),
                      title: Text(snapshot.data!.value[index]['name']),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
