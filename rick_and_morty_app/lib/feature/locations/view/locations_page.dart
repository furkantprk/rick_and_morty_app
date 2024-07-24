import 'package:api_veri/feature/locations/bloc/locations_page_bloc.dart';
import 'package:api_veri/feature/locations/bloc/locations_page_event.dart';
import 'package:api_veri/feature/locations/bloc/locations_page_state.dart';
import 'package:api_veri/product/utility/constants/view_status_enum.dart';
import 'package:api_veri/product/utility/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_veri/feature/widgets/locations_page_card.dart';
import 'package:api_veri/product/utility/constants/color_constants.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackGround,
      body: BlocBuilder<LocationsPageBloc, LocationsPageState>(
        builder: (context, state) {
          if (state.status == ViewStatus.initial ||
              state.status == ViewStatus.loading) {
            if (state.status == ViewStatus.initial) {
              context.read<LocationsPageBloc>().add(FetchLocations());
            }
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ViewStatus.loaded) {
            return ListView.builder(
              itemCount: state.locations?.length ?? 0,
              itemBuilder: (context, index) {
                final location = state.locations![index];
                return LocationsPageCard(
                  location: location,
                  showDetails: state.detailList![index],
                  residents: state.residentList![index],
                  onToggleDetail: () {
                    context
                        .read<LocationsPageBloc>()
                        .add(ToggleDetailVisibilityAndFetchResidents(index));
                  },
                );
              },
            );
          } else if (state.status == ViewStatus.error) {
            return Center(
                child: Text(state.errorMessage ?? AppString.unknownStateText));
          } else {
            return Center(child: Text(AppString.unknownStateText));
          }
        },
      ),
    );
  }
}
