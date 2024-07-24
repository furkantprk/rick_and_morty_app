import 'package:api_veri/feature/characters/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:api_veri/feature/locations/model/location_model.dart';
import 'package:api_veri/product/utility/constants/color_constants.dart';

class LocationsPageCard extends StatelessWidget {
  final LocationModel location;
  final bool showDetails;
  final List<UserModel> residents;
  final VoidCallback onToggleDetail;

  const LocationsPageCard({
    Key? key,
    required this.location,
    required this.showDetails,
    required this.residents,
    required this.onToggleDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
      ),
      color: AppColor.card,
      child: ListTile(
        title: TextButton(
          onPressed: onToggleDetail,
          child: Text(
            '${location.id ?? ''} ${location.name ?? ''} ${location.type ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
        ),
        subtitle: Column(
          children: [
            Visibility(
              visible: showDetails,
              child: Text(location.dimension ?? ''),
            ),
            Visibility(
              visible: showDetails,
              child: Column(
                children: residents
                    .map((resident) => ListTile(
                          title: Text(resident.name ?? ''),
                          subtitle:
                              Text('${resident.species} ${resident.gender}'),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(resident.image ?? ''),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
