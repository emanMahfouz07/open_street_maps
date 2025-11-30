import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps/Features/Favorites/fav_service.dart';
import 'package:maps/Models/geo_place_model/geo_place_model.dart';
import 'package:maps/Models/place_deailes_model/properties.dart';
import 'package:maps/utils/helper.dart';
import 'package:maps/utils/location_service.dart';
import 'package:maps/utils/route_test_service.dart';
import 'package:maps/widgets/custom_country_info.dart';
import 'package:flutter_map/flutter_map.dart';

class CustomModelBottomSheet extends StatelessWidget {
  final Properties feature;
  final double lat;
  final double lon;
  final LocationService locationService;

  final RoutingService routeTestService;
  final MapController mapController;
  final FavoritesService favoritesService;
  final Function(List<LatLng>) onShowRoute;

  const CustomModelBottomSheet({
    super.key,
    required this.feature,
    required this.lat,
    required this.lon,
    required this.locationService,
    required this.routeTestService,
    required this.mapController,
    required this.favoritesService,
    required this.onShowRoute,
  });

  static Future<void> show(
    BuildContext context, {
    required Properties feature,
    required double lat,
    required double lon,
    required LocationService locationService,
    required RoutingService routeTestService,
    required MapController mapController,
    required FavoritesService favoritesService,
    required Function(List<LatLng>) onShowRoute,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => CustomModelBottomSheet(
            feature: feature,
            lat: lat,
            lon: lon,
            locationService: locationService,
            routeTestService: routeTestService,
            mapController: mapController,
            favoritesService: favoritesService,
            onShowRoute: onShowRoute,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildInfoSection(),
          const SizedBox(height: 20),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            feature.name ?? 'Unknown Place',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _buildFavoriteButton(),
      ],
    );
  }

  Widget _buildFavoriteButton() {
    return ListenableBuilder(
      listenable: favoritesService,
      builder: (context, _) {
        final isFavorite = favoritesService.containsPlace(feature.placeId);

        return IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color: Colors.red,
          tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
          onPressed: () => _toggleFavorite(context),
        );
      },
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (feature.country != null) ...[
          CustomCountryInfo(label: 'Country:', value: feature.country!),
          const SizedBox(height: 12),
        ],
        if (feature.formatted != null) ...[
          CustomCountryInfo(label: 'Address:', value: feature.formatted!),
          const SizedBox(height: 12),
        ],
        if (feature.contact?.email != null)
          CustomCountryInfo(label: 'Email:', value: feature.contact!.email!),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
          label: const Text('Close'),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () => _getDirections(context),
          icon: const Icon(Icons.navigation),
          label: const Text('Directions'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ],
    );
  }

  void _toggleFavorite(BuildContext context) {
    final place = GeoPlaceModel(
      placeId: feature.placeId,
      city: feature.name,
      formatted: feature.formatted,
      country: feature.country,
    );

    favoritesService.togglePlace(place);

    final isFavorite = favoritesService.containsPlace(feature.placeId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Added to favorites' : 'Removed from favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _getDirections(BuildContext context) async {
    try {
      // تأكد من صلاحيات الموقع أولاً (لا نغلق الـ bottom sheet الآن)
      final hasService = await locationService.checkAndRequestLocationService();
      final hasPermission =
          await locationService.checkAndRequestLocationPermission();

      if (!hasService || !hasPermission) {
        if (context.mounted) {
          UIHelper.showErrorSnackBar(
            context,
            'Location access is required for directions',
          );
        }
        return;
      }

      final currentLocation = await locationService.getCurrentLocation();
      if (currentLocation?.latitude == null ||
          currentLocation?.longitude == null) {
        if (context.mounted) {
          UIHelper.showErrorSnackBar(
            context,
            'Could not determine your current location',
          );
        }
        return;
      }

      final origin = LatLng(
        currentLocation!.latitude!,
        currentLocation.longitude!,
      );
      final destination = LatLng(lat, lon);

      // استخدم context الآمن للـ dialog: root navigator / overlay context
      final rootCtx = Navigator.of(context, rootNavigator: true).context;

      // اعرض loading باستخدام rootCtx واطمئِن إننا سنغلقه لاحقاً
      UIHelper.showLoadingDialog(rootCtx);

      List<LatLng> routePoints = [];
      try {
        // Fetch route (قد يرمي استثناء)
        routePoints = await routeTestService.getRoute(
          origin: origin,
          destination: destination,
        );
      } catch (e) {
        // لو الفetch فشل: اغلق الـ loading واظهر رسالة خطأ
        UIHelper.closeDialog(rootCtx);
        UIHelper.showErrorSnackBar(
          rootCtx,
          'Failed to calculate route: ${e.toString()}',
        );
        return;
      }

      // لو مفيش راوت
      if (routePoints.isEmpty) {
        UIHelper.closeDialog(rootCtx);
        UIHelper.showErrorSnackBar(rootCtx, 'No route found to this location');
        return;
      }

      // نغلق الـ bottom sheet الآن (الـ context للـ bottom sheet قد يبقى mounted لكن ختامياً هنستخدم rootCtx للـ dialog)
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // أرسل الراوت للـ caller
      onShowRoute(routePoints);

      // Close loading dialog safely (لو لسه مفتوح)
      UIHelper.closeDialog(rootCtx);

      // حاول تحرك الخريطة (لو فشل، اطبع فقط)
      try {
        mapController.move(destination, 14.0);
      } catch (e) {
        debugPrint('Could not move map: $e');
      }
    } catch (e) {
      // أي خطأ غير متوقع: حاول تغلق أي loading مفتوح وتظهر رسالة
      try {
        final rootCtx = Navigator.of(context, rootNavigator: true).context;
        UIHelper.closeDialog(rootCtx);
        UIHelper.showErrorSnackBar(
          rootCtx,
          'Failed to calculate route: ${e.toString()}',
        );
      } catch (_) {
 
        debugPrint('Error while closing dialog or showing error: $e');
      }
    }
  }
}
