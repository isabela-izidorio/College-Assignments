import 'package:flutter/material.dart';

void main() => runApp(const GridGalleryApp());

class GridGalleryApp extends StatelessWidget {
  const GridGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Galeria GridView',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const GridGalleryPage(),
    );
  }
}

class GalleryItem {
  const GalleryItem({required this.title, required this.place, required this.imageUrl});

  final String title;
  final String place;
  final String imageUrl;
}

class GridGalleryPage extends StatelessWidget {
  const GridGalleryPage({super.key});

  static const List<GalleryItem> items = [
    GalleryItem(
      title: 'Flower Market',
      place: 'Chennai',
      imageUrl: 'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=700&auto=format&fit=crop&q=80',
    ),
    GalleryItem(
      title: 'Bronze Works',
      place: 'Tanjore',
      imageUrl: 'https://images.unsplash.com/photo-1455390582262-044c68b8a2ca?w=700&auto=format&fit=crop&q=80',
    ),
    GalleryItem(
      title: 'Market',
      place: 'Tanjore',
      imageUrl: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=700&auto=format&fit=crop&q=80',
    ),
    GalleryItem(
      title: 'Thanjavur Temple',
      place: 'Tanjore',
      imageUrl: 'https://images.unsplash.com/photo-1606293926075-69a00dbfaf4f?w=700&auto=format&fit=crop&q=80',
    ),
    GalleryItem(
      title: 'Ancient Temple',
      place: 'Thanjavur',
      imageUrl: 'https://images.unsplash.com/photo-1548013146-72479768bada?w=700&auto=format&fit=crop&q=80',
    ),
    GalleryItem(
      title: 'Salt Farm',
      place: 'Pondicherry',
      imageUrl: 'https://images.unsplash.com/photo-1500375592092-40eb2168fd21?w=700&auto=format&fit=crop&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galeria de lugares')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) => _GalleryCard(item: items[index]),
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.item});

  final GalleryItem item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const ColoredBox(
                color: Color(0xFFE8EEEE),
                child: Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) => const ColoredBox(
              color: Color(0xFFD7E4E2),
              child: Center(child: Icon(Icons.image_not_supported_outlined, size: 42)),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xCC000000)],
                stops: [0.45, 1],
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 8,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.place, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                Text(
                  item.title,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
