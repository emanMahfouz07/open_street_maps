import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.places, required this.onTap});

  final List<GeoPlaceModel> places;
  final void Function(GeoPlaceModel place)? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            onTap: () {
                              if (onTap != null) onTap!(places[index]);
                            },
                            leading: Icon(
                              Icons.location_on,
                              color: colorScheme.error,
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                if (onTap != null) onTap!(places[index]);
                                print('place id ${places[index].formatted}');
                              },
                              child: Icon(
                                Icons.arrow_circle_right_outlined,
                                color: theme.iconTheme.color,
                              ),
                            ),
                            title: Text(
                              places[index].formatted ?? '',
                              style: theme.textTheme.bodyLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                        (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            height: 0,
                            color: colorScheme.outline.withOpacity(0.3),
                          ),
                        ),
                    itemCount: places.length,
                  ),
                ),
              ),
    );
  }
}
