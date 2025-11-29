import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.places, required this.onTap});

  final List<GeoPlaceModel> places;
  final void Function(GeoPlaceModel place)? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(sizeFactor: animation, child: child),
        );
      },
      child:
          places.isEmpty
              ? const SizedBox.shrink()
              : Container(
                key: const ValueKey('list'),
                color: Colors.white,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                          onTap: () {
                            if (onTap != null) onTap!(places[index]);
                          },
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.red[700],
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              if (onTap != null) onTap!(places[index]);
                              print('place id ${places[index].formatted}');
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                            ),
                          ),
                          title: Text(places[index].formatted ?? ''),
                        )
                        .animate()
                        .fadeIn(duration: 300.ms)
                        .slideY(
                          begin: -0.2,
                          end: 0,
                          duration: 300.ms,
                          delay: (index * 50).ms,
                        );
                  },
                  separatorBuilder:
                      (context, index) => const Divider(height: 0),
                  itemCount: places.length,
                ),
              ),
    );
  }
}
