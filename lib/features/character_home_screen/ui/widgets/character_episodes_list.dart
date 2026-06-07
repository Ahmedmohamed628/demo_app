import 'package:flutter/material.dart';

class CharacterEpisodesList extends StatelessWidget {
  final List<String> episodesUrls;

  const CharacterEpisodesList({super.key, required this.episodesUrls});

  //function to extract episode number from the url
  String _getEpisodeNumber(String url) {
    try {
      //url:  https://rickandmortyapi.com/api/episode/1
      // separate the url by '/' and take the last part which is the episode number
      final id = url.split('/').last;
      return 'Episode $id';
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    //if character has no episodes (rare case) we show nothing
    if (episodesUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: episodesUrls.length,
        itemBuilder: (context, index) {
          final episodeName = _getEpisodeNumber(episodesUrls[index]);

          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple[100]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.movie_creation_outlined,
                  size: 18,
                  color: Colors.deepPurple,
                ),
                const SizedBox(width: 8),
                Text(
                  episodeName,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
