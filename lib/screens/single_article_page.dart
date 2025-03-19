import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/services/api_service.dart';
import 'package:pickitup/utils/constants.dart'; // contains apiImages constant

class SingleArticlePage extends StatefulWidget {
  const SingleArticlePage({Key? key}) : super(key: key);

  @override
  _SingleArticlePageState createState() => _SingleArticlePageState();
}

class _SingleArticlePageState extends State<SingleArticlePage> {
  late Future<Map<String, dynamic>> _articleFuture;
  late int articleId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the article id from route arguments.
    articleId = ModalRoute.of(context)!.settings.arguments as int;
    _articleFuture = ApiService().getSpecificArticle(articleId);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final scaleHeight = mediaQuery.size.height / 812.0;
    final scaleWidth = mediaQuery.size.width / 375.0;

    return FutureBuilder<Map<String, dynamic>>(
      future: _articleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
            bottomNavigationBar: const custom_nav.CustomBottomNavigationBar(),
          );
        }
        if (!snapshot.hasData || snapshot.data!['success'] != true) {
          return Scaffold(
            body: Center(child: Text("Article not found.")),
            bottomNavigationBar: const custom_nav.CustomBottomNavigationBar(),
          );
        }

        final article = snapshot.data!['data'];
        // If article['picture'] is available, build the URL with apiImages; otherwise, use asset image.
        final pictureUrl =
            (article['picture'] != null && article['picture'] != "")
                ? "$apiImages/${article['picture']}"
                : 'assets/images/bg_single_article.png';

        return Scaffold(
          bottomNavigationBar: const custom_nav.CustomBottomNavigationBar(),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 250 * scaleHeight,
                  pinned: false,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Image(
                      image: pictureUrl.startsWith('http')
                          ? NetworkImage(pictureUrl)
                          : AssetImage(pictureUrl) as ImageProvider,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/bg_single_article.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0 * scaleWidth,
                  vertical: 16.0 * scaleHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article title
                    Text(
                      article['title'] ?? 'Untitled Article',
                      style: TextStyle(
                        fontSize: 20 * scaleWidth,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                    SizedBox(height: 8 * scaleHeight),
                    // Author
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16, color: Colors.grey),
                        SizedBox(width: 4 * scaleWidth),
                        Text(
                          article['writer'] ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 14 * scaleWidth,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8 * scaleHeight),
                    // Date
                    Text(
                      article['date'] ?? '',
                      style: TextStyle(
                        fontSize: 14 * scaleWidth,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 16 * scaleHeight),
                    // Article content
                    Text(
                      article['content'] ?? '',
                      style: TextStyle(
                        fontSize: 14 * scaleWidth,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 40 * scaleHeight),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
