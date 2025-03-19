import 'package:flutter/material.dart';
import '../components/header_component.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/services/api_service.dart';
import '../utils/constants.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  late Future<List<dynamic>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = ApiService().getArticles();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final scaleHeight = mediaQuery.size.height / 812.0;
    final scaleWidth = mediaQuery.size.width / 375.0;

    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60 * scaleHeight),
        child: HeaderComponent("PickItUp's Article"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
            return Center(child: Text("No articles found."));
          } else {
            final articles = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0 * scaleWidth,
                  vertical: 16.0 * scaleHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Just For You",
                      style: TextStyle(
                        fontSize: 20 * scaleWidth,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 16 * scaleHeight),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return _buildArticleCard(
                            articles[index], scaleWidth, scaleHeight);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: const custom_nav.CustomBottomNavigationBar(),
    );
  }

  /// Card untuk menampilkan 1 artikel dari API.
  Widget _buildArticleCard(
      Map<String, dynamic> article, double scaleWidth, double scaleHeight) {
    // Mengonversi nilai picture menjadi URL lengkap menggunakan apiBaseUrl dan path storage
    final pictureUrl = "$apiImages/${article['picture']}";
    return GestureDetector(
      onTap: () {
        // Navigate to the single article details page, passing the article id.
        Navigator.pushNamed(
          context,
          '/articles-details',
          arguments: article['id'],
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0 * scaleHeight),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade200, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Menampilkan gambar dari URL
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                pictureUrl,
                width: 120 * scaleWidth,
                height: 120 * scaleHeight,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120 * scaleWidth,
                    height: 120 * scaleHeight,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.image,
                        size: 40, color: Colors.grey.shade700),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0 * scaleWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title'] ?? 'Untitled Article',
                      style: TextStyle(
                        fontSize: 16 * scaleWidth,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8 * scaleHeight),
                    Text(
                      article['date'] ?? '',
                      style: TextStyle(
                        fontSize: 14 * scaleWidth,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8 * scaleHeight),
                    Text(
                      article['content'] ?? '',
                      style: TextStyle(
                        fontSize: 14 * scaleWidth,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
