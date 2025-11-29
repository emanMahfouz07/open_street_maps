import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maps/Features/Favorites/fav_service.dart';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';

class FavoritesView extends StatelessWidget {
  final void Function(GeoPlaceModel place) onOpen;
  final bool closeOnSelect;

  const FavoritesView({
    super.key,
    required this.onOpen,
    this.closeOnSelect = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          Consumer<FavoritesService>(
            builder: (context, service, _) {
              if (service.favoritePlaces.isEmpty)
                return const SizedBox.shrink();

              return IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Clear all favorites',
                onPressed: () => _showClearAllDialog(context, service),
              );
            },
          ),
        ],
      ),
      body: Consumer<FavoritesService>(
        builder: (context, favoritesService, _) {
          final items = favoritesService.favoritePlaces;

          if (items.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder:
                (_, index) => _FavoriteListItem(
                  place: items[index],
                  onTap: () {
                    onOpen(items[index]);
                    Navigator.of(context).pop(); // Close favorites screen
                  },
                  onRemove:
                      () => _handleRemove(
                        context,
                        favoritesService,
                        items[index],
                      ),
                ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              'No favorites yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tap the heart icon on any place\nto save it here for quick access',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRemove(
    BuildContext context,
    FavoritesService service,
    GeoPlaceModel place,
  ) {
    service.togglePlace(place);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${place.formatted ?? place.city ?? 'Place'} removed'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => service.togglePlace(place),
        ),
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, FavoritesService service) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Clear all favorites?'),
            content: const Text(
              'This will remove all saved places from your favorites.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  service.clearAll();
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All favorites cleared')),
                  );
                },
                child: const Text('Clear', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}

class _FavoriteListItem extends StatelessWidget {
  final GeoPlaceModel place;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteListItem({
    required this.place,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = place.formatted ?? place.city ?? 'Unknown Location';
    final subtitle = _buildSubtitle();

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.location_on, color: Colors.red, size: 24),
      ),
      title: Text(
        displayName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle:
          subtitle != null
              ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              )
              : null,
      trailing: IconButton(
        icon: const Icon(Icons.favorite),
        color: Colors.red,
        tooltip: 'Remove from favorites',
        onPressed: onRemove,
      ),
      onTap: onTap,
    );
  }

  String? _buildSubtitle() {
    final parts = <String>[];

    if (place.city != null && place.city != place.formatted) {
      parts.add(place.city!);
    }
    if (place.country != null) {
      parts.add(place.country!);
    }

    return parts.isEmpty ? null : parts.join(', ');
  }
}
