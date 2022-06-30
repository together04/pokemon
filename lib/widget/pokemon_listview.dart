import 'package:flutter/material.dart';

class PokemonListView extends StatelessWidget {
  final ScrollController scrollController;
  final List<String> images;

  const PokemonListView(
      {Key? key, required this.scrollController, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 1,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Image.asset(
              'assets/image/${images[index]}',
              width: 100,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
