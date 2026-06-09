import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/features/character_home_screen/data/model/character_model.dart';
import 'package:demo_project/features/character_home_screen/ui/widgets/info_list_tile.dart';
import 'package:flutter/material.dart';
import '../widgets/character_episodes_list.dart';
import '../widgets/info_card.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel character;
  const CharacterDetailsScreen({super.key, required this.character});

  // status color logic: alive = green, dead = red, unknown = grey
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(character.status);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          //1- appbar with animation with scroll
          SliverAppBar(
            expandedHeight: MediaQuery
                .of(context)
                .size
                .height * 0.45,
            pinned: true,
            //fixed appbar after scrolling
            elevation: 0,
            backgroundColor: Colors.deepPurple,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 16),
              centerTitle: false,
              title: Text(
                character.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: Colors.black45,
                        blurRadius: 6,
                        offset: Offset(0, 2)),
                  ],
                ),
              ),
              background: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // image with hero animation
                      Hero(
                        tag: character.id,
                        child: CachedNetworkImage(
                          imageUrl: character.image,
                          fit: BoxFit.cover,
                          // fadeInDuration: const Duration(milliseconds: 300),
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          placeholder: (context, url) =>
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.grey[200],),
                          errorWidget:
                              (context, url, error) =>
                              Container(
                                color: Colors.grey[100],
                                child: Icon(Icons.broken_image_outlined,
                                  color: Colors.grey[400], size: 40,),
                              ),
                        ),
                      ),
                      // black gradient overlay for better text visibility whatever the image colors are
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black87,
                            ],
                            stops: [0.6, 1.0],
                          ),
                        ),
                      ),
                    ],
                  );
                },

              ),
            ),
          ),

          //2- details content
          _CharacterDetailsBody(character: character, statusColor: statusColor),
        ],
      ),
    );
  }

}

class _CharacterDetailsBody extends StatelessWidget {
  final CharacterModel character;
  final Color statusColor;

  const _CharacterDetailsBody({
    required this.character,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // (Status & Species)
            _buildSectionTitle('Core Information'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    title: 'Status',
                    value: character.status,
                    icon: Icons.circle,
                    iconColor: statusColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InfoCard(
                    title: 'Species',
                    value: character.species,
                    icon: Icons.fingerprint_rounded,
                    iconColor: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // (Gender & Type)
            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    title: 'Gender',
                    value: character.gender,
                    icon: character.gender.toLowerCase() == 'male'
                        ? Icons.male_rounded
                        : character.gender.toLowerCase() == 'female'
                        ? Icons.female_rounded
                        : Icons.wc_rounded,
                    iconColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InfoCard(
                    title: 'Type',
                    value: character.type.isEmpty ? 'Normal Type' : character
                        .type,
                    icon: Icons.bubble_chart_rounded,
                    iconColor: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // (زي الـ Origin أو الـ Location)
            _buildSectionTitle('Origin & Location'),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  InfoListTile(title: 'Origin Planet',
                      subtitle: character.origin.name,
                      icon: Icons.public),
                  const Divider(height: 24, thickness: 0.5),
                  InfoListTile(title: 'Current Location',
                      subtitle: character.location.name,
                      icon: Icons.location_on_rounded)
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Featured Episodes'),
            const SizedBox(height: 12),
            CharacterEpisodesList(episodesUrls: character.episode),
          ],
        ),
      ),
    );
  }

  //widget for section titles like "Core Information", "Origin & Location", "Featured Episodes"
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        letterSpacing: 0.5,
      ),
    );
  }
}