import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:room_v2/src/core/bloc/bloc_with_state.dart';
import 'package:room_v2/src/core/utils/constants.dart';
import 'package:room_v2/src/modules/order/bloc/order_bloc.dart';
import 'package:room_v2/src/modules/order/models/order.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:group_button/group_button.dart';

class OrderScreen extends HookWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final scrollController = useMemoized(() => ScrollController());
    final searchNode = useFocusNode();

    useEffect(() {
      return () => scrollController.dispose();
    }, []);

    useEffect(() {
      scrollController
          .addListener(() => _onScrollListener(context, scrollController));
      return () => scrollController
          .removeListener(() => _onScrollListener(context, scrollController));
    }, [key]);

    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Filter",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              ),
              Divider(),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Urutkan berdasar",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        GroupButton(
                            isRadio: true,
                            spacing: 10,
                            onSelected: (index, isSelected) => print(
                                "${DEFAULT_SORT_BY[index].value} button is selected"),
                            buttons:
                                DEFAULT_SORT_BY.map((e) => e.value).toList(),
                            selectedShadow: <BoxShadow>[
                              BoxShadow(color: Colors.transparent)
                            ],
                            unselectedShadow: <BoxShadow>[
                              BoxShadow(color: Colors.transparent)
                            ],
                            selectedColor: Colors.grey[400],
                            borderRadius: BorderRadius.circular(8.0),
                            unselectedColor: Colors.grey[200],
                            selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                            unselectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[600],
                            )),
                        Divider(),
                        Text("Status pesanan",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        GroupButton(
                            isRadio: false,
                            spacing: 10,
                            onSelected: (index, isSelected) =>
                                print('$index button is selected'),
                            buttons: [
                              "Diterima",
                              "Selesai",
                              "Dibatalkan",
                            ],
                            selectedShadow: <BoxShadow>[
                              BoxShadow(color: Colors.transparent)
                            ],
                            unselectedShadow: <BoxShadow>[
                              BoxShadow(color: Colors.transparent)
                            ],
                            selectedColor: Colors.grey[400],
                            unselectedColor: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                            selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                            unselectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[600],
                            )),
                      ],
                    )
                  ],
                ),
              )),
              Divider(),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    ElevatedButton(
                      child: Text('Atur Ulang',
                          style: TextStyle(color: Colors.grey[800])),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          primary: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton.icon(
                          label: Text(
                            'Pakai',
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              primary: Colors.grey),
                          icon: Icon(
                            EvaIcons.search,
                            size: 18,
                            color: Colors.grey[700],
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  focusNode: searchNode,
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Pencarian",
                    hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                    suffixIcon:
                        context.watch<OrderBloc>().state.requestParams.q == null
                            ? null
                            : IconButton(
                                onPressed: () {
                                  print(11);
                                  context.read<OrderBloc>()
                                    ..add(OrderSearchReseted());

                                  _refreshOnBloc(context);
                                },
                                icon: Icon(
                                  EvaIcons.closeCircle,
                                  color: Colors.grey,
                                ),
                              ),
                  ),
                  onFieldSubmitted: (e) {
                    context.read<OrderBloc>()
                      ..add(OrderReseted())
                      ..add(OrderCalled())
                      ..add(OrderFetched());
                  },
                  onChanged: (value) async {
                    context.read<OrderBloc>()..add(OrderSearched(value));
                  },
                ),
              ),
            )
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: Center(
              child: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                      icon: Icon(
                        EvaIcons.options2Outline,
                        color: Colors.grey,
                        size: 18.0,
                      ),
                      onPressed: () {
                        print("openEndDrawer:onPressed()");
                        Scaffold.of(context).openEndDrawer();
                      });
                },
              ),
            ),
          )
        ],
      ),
      body: _buildBody(
          scrollController: scrollController,
          context: context,
          searchController: searchController),
    );
  }

  void _refreshOnBloc(BuildContext context) {
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    final processState = orderBloc.blocProcessState;

    if (processState == BlocProcessState.idle) {
      context.read<OrderBloc>()
        ..add(OrderRefreshed())
        ..add(OrderCalled())
        ..add(OrderFetched());
    }
  }

  Widget _buildError(BuildContext context, OrderState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Tap to retry",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 10.0,
        ),
        ClipOval(
          child: Material(
            color: Colors.blue, // button color
            child: InkWell(
              splashColor: Colors.red, // inkwell color
              child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  )),
              onTap: () {
                _refreshOnBloc(context);
              },
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          state.error?.message ?? "Error occured",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  Widget _buildBody(
      {ScrollController scrollController,
      TextEditingController searchController,
      BuildContext context}) {
    return BlocConsumer<OrderBloc, OrderState>(listener: (_, state) {
      if (!state.isLoading) {
        BotToast.closeAllLoading();
      }

      if (state.requestParams?.q == null) {
        searchController.text = "";
      }
    }, builder: (_, state) {
      if (state.isLoading && state.isFirst) {
        BotToast.showLoading(
            animationDuration: Duration(milliseconds: 500), crossPage: false);
        return Container();
      }

      if (state.isError && state.data?.isEmpty) {
        return _buildError(context, state);
      } else {
        return _buildOrder(
            scrollController: scrollController, state: state, context: context);
      }
    });
  }

  Widget _buildOrderItem({Order data, BuildContext context}) {
    return Card(
      child: ListTile(
        onTap: () {
          print("ListTile::onTap");
        },
        leading: GestureDetector(
          onTap: () {
            print("ListTile->GestureDetector::onTap");
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              width: 50,
              height: 50,
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi4Ineg0XEDCA2KJ9kJ7g8juK_sszmOPPs_Q&usqp=CAU',
              placeholder: (BuildContext context, String url) => Container(
                color: Colors.black12,
              ),
            ),
          ),
        ),
        title: Text(data.no),
        subtitle: Text(data.status),
      ),
    );
  }

  Future refreshData(BuildContext context) async {
    _refreshOnBloc(context);

    return null;
  }

  Widget _buildOrder(
      {ScrollController scrollController,
      OrderState state,
      BuildContext context}) {
    return RefreshIndicator(
      onRefresh: () {
        FocusScope.of(context).unfocus();
        return refreshData(context);
      },
      child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          children: [
            if (state.data.isNotEmpty)
              ...List<Widget>.from(state.data?.map((e) => Builder(
                  builder: (context) =>
                      _buildOrderItem(data: e, context: context)))),
            if (state.data.isEmpty && !state.isLoading) ...[
              _appendTextOnList(text: "No data", context: context)
            ],
            if (!state.hasNext && state.data.isNotEmpty) ...[
              _appendTextOnList(text: "End of page", context: context)
            ],
            if (state.isLoading) ...[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: CupertinoActivityIndicator(),
              )
            ],
            if (state.isError) ...[
              _appendTextOnList(text: state.error?.message, context: context)
            ]
          ]),
    );
  }

  Widget _appendTextOnList({String text, BuildContext context}) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption,
      ),
    ));
  }

  void _onScrollListener(
      BuildContext context, ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    final processState = orderBloc.blocProcessState;

    if (currentScroll == maxScroll) {
      if (processState == BlocProcessState.idle) {
        context.read<OrderBloc>()..add(OrderCalled())..add(OrderFetched());
      } else {
        if (orderBloc.state.isLoading &&
            processState == BlocProcessState.busy) {
          // Do somestuff while app busy
        }
      }
    }
  }
}
