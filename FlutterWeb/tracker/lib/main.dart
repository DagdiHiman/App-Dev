import 'package:flutter/material.dart';
import 'package:tracker/home/homepage.dart';
import 'package:tracker/nav/navbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Montserrat"),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      initialRoute: MyHomePage.route,
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    );
  }
}

class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument is any RegEx matches if such are
  /// included inside of the pattern.
  final Widget Function(BuildContext, Map<String, String>) builder;
}

class RouteConfiguration {
  /// List of [Path] to for route matching. When a named route is pushed with
  /// [Navigator.pushNamed], the route name is matched with the [Path.pattern]
  /// in the list below. As soon as there is a match, the associated builder
  /// will be returned. This means that the paths higher up in the list will
  /// take priority.
  static List<Path> paths = [
    Path(
      r'^' + ArticlePage.baseRoute + r'/(?<slug>[\w-]+)$',
      (context, matches) => Article.getArticlePage(matches['slug']),
    ),
    Path(
      r'^' + OverviewPage.route,
      (context, matches) => OverviewPage(),
    ),
    Path(
      r'^' + MyHomePage.route,
      (context, matches) => MyHomePage(),
    ),
  ];

  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name)) {
        final match = regExpPattern.firstMatch(settings.name);
        Map<String, String> groupNameToMatch = {};
        for (String groupName in match.groupNames) {
          groupNameToMatch[groupName] = match.namedGroup(groupName);
        }
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, groupNameToMatch),
          settings: settings,
        );
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
}

// In a real application this would probably be some kind of database interface.
const List<Article> articles = [
  Article(
    title: 'A very interesting article',
    slug: 'a-very-interesting-article',
  ),
  Article(
    title: 'Newsworthy news',
    slug: 'newsworthy-news',
  ),
  Article(
    title: 'RegEx is cool',
    slug: 'regex-is-cool',
  ),
];

class Article {
  const Article({this.title, this.slug});

  final String title;
  final String slug;

  static Widget getArticlePage(String slug) {
    for (Article article in articles) {
      if (article.slug == slug) {
        return ArticlePage(article: article);
      }
    }
    return UnknownArticle();
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key key, this.article}) : super(key: key);

  static String baseRoute = '/article';
  static String Function(String slug) routeFromSlug =
      (String slug) => baseRoute + '/$slug';

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(article.title),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unknown article'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Unknown article'),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class OverviewPage extends StatelessWidget {
  static String route = '/overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(Article article in articles)
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ArticlePage.routeFromSlug(article.slug),
                  );
                },
                child: Text(article.title),
              ),
            RaisedButton(
              onPressed: () {
                // Navigate back to the home screen by popping the current route
                // off the stack.
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  
  static String route = '/';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                //Color.fromRGBO(54, 209, 220, 1.0),
                //Color.fromRGBO(91, 134, 229, 1.0),
                Color.fromRGBO(0, 0, 0, 1.0),
                Color.fromRGBO(15, 32, 39, 1.0),
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Navbar(),
              Center(
                child: RaisedButton(
                  child: Text('Overview page'),
                  onPressed: () {
                    // Navigate to the overview page using a named route.
                    Navigator.pushNamed(context, OverviewPage.route);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: LandingPage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}