import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sweet_corn_app/views/client/details/details_page.dart';
import 'package:sweet_corn_app/views/client/map/map_card.dart';
import 'package:sweet_corn_app/common/user_service/user_service.dart';
import 'package:sweet_corn_app/views/pre_login/pre_login_page.dart';

import 'map_bloc.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapContent extends StatelessWidget {
  final panelController = PanelController();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _logout() async {
      await UserService().logout();
      Navigator.push(
        context,
        PageTransition(type: PageTransitionType.rightToLeft, child: PreLogin()),
      );
    }

    // Listen to location
    return BlocListener<MapBloc, MapState>(
      condition: (previous, current) =>
          previous.userLocation != current.userLocation,
      listener: (context, state) {
        if (state.userLocation != null) _getStores(context, state);
      },
      // Listen to error messages
      child: BlocListener<MapBloc, MapState>(
        condition: (previous, current) =>
            previous.errorMessage != current.errorMessage,
        listener: (context, current) {
          if (current.errorMessage != null) {
            final snackbar = SnackBar(
              duration: Duration(seconds: 6),
              content: Text(current.errorMessage),
              action: SnackBarAction(
                label: 'Repetir',
                onPressed: () => _getStores(context, current),
              ),
            );
            Scaffold.of(context).showSnackBar(snackbar);
            context.bloc<MapBloc>().add(ClearErrorMessage());
          }
        },
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) => Stack(
            children: <Widget>[
              SlidingUpPanel(
                minHeight: 160,
                maxHeight: 470,
                renderPanelSheet: false,
                controller: panelController,
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: state.userLocation == null
                      ? null
                      : Stack(
                          children: [
                            Container(
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    state.userLocation.latitude,
                                    state.userLocation.longitude,
                                  ),
                                  zoom: 15,
                                ),
                                myLocationEnabled: true,
                                markers: state.markers != null
                                    ? Set<Marker>.of(state.markers.values)
                                    : null,
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 58,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [BoxShadow(color: Colors.black)],
                                ),
                                width: MediaQuery.of(context).size.width - 32,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Pesquise aqui',
                                        ),
                                        controller: controller,
                                        style: TextStyle(fontSize: 18),
                                        onEditingComplete: () {
                                          context.bloc<MapBloc>().add(
                                              GetNearbyStores(
                                                  userLocation:
                                                      state.userLocation,
                                                  context: context,
                                                  search: controller.text));
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon: Icon(Icons.search),
                                        onPressed: () {
                                          context.bloc<MapBloc>().add(
                                              GetNearbyStores(
                                                  userLocation:
                                                      state.userLocation,
                                                  context: context,
                                                  search: controller.text));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                panel: GestureDetector(
                  onTap: () {
                    // if (!panelController.isPanelOpen) panelController.open();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      child: BlocBuilder<MapBloc, MapState>(
                        builder: (context, state) => Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 64,
                              color: Theme.of(context).primaryColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Estabelecimentos proximos',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  IconButton(
                                    icon: Icon(Icons.exit_to_app,
                                        color: Colors.white),
                                    onPressed: _logout,
                                    tooltip: 'Sair do aplicativo',
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: state.loading
                                  ? <Widget>[
                                      ListTile(title: Text('Buscando ...'))
                                    ]
                                  : state.stores != null
                                      ? state.stores
                                          .map((item) => MapCard(
                                                store: item,
                                                onTap: () =>
                                                    _showDetails(context, item),
                                              ))
                                          .toList()
                                      : [
                                          ListTile(
                                              title: Text(
                                                  'Nenhum estabelecimento encontrado'))
                                        ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, Map store) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: DetailsPage(store: store),
      ),
    );
  }

  void _getStores(BuildContext context, MapState state) {
    context.bloc<MapBloc>().add(GetNearbyStores(
          userLocation: state.userLocation,
          context: context,
        ));
  }
}
