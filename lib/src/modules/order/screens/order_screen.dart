import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:room_v2/src/core/bloc/bloc_with_state.dart';
import 'package:room_v2/src/modules/order/bloc/order_bloc.dart';
import 'package:room_v2/src/modules/order/models/order.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderScreen extends HookWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final scrollController = useMemoized(() => ScrollController());
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  maxLines: 1,
                  decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.all(8),
                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Pencarian",
                      suffixIcon:
                          context.watch<OrderBloc>().state.requestParams.q ==
                                  null
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    print(11);
                                    context.read<OrderBloc>()
                                      ..add(OrderSearchReseted());
                                  },
                                  icon: Icon(
                                    EvaIcons.closeCircle,
                                    color: Colors.grey,
                                  ),
                                ),
                      hintStyle: Theme.of(context).textTheme.subtitle1),
                  onFieldSubmitted: (e) {
                    context.read<OrderBloc>()
                      ..add(OrderReseted())
                      ..add(OrderCalled())
                      ..add(OrderFetched());
                  },
                  onChanged: (value) async {
                    context.read<OrderBloc>()..add(OrderSearched(value));

                    // Future.delayed(duration)
                  },
                  // readOnly: true,
                  // onTap: () {
                  //   print("Tapped");
                  //   // Navigator.push(context,
                  //   //     MaterialPageRoute(builder: (_) => Search()));
                  // },
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.code), onPressed: () {}),
          IconButton(icon: Icon(Icons.favorite), onPressed: () {})
        ],
      )
      //     SliverAppBar(
      //       automaticallyImplyLeading: false,
      //       pinned: true,
      //       title: Row(
      //         children: [
      //           Expanded(
      //             child: SizedBox(
      //               child: TextFormField(
      //                 maxLines: 1,
      //                 decoration: InputDecoration(
      //                     prefixIcon: Icon(Icons.search),
      //                     contentPadding: EdgeInsets.all(8),
      //                     border: new OutlineInputBorder(
      //                         borderRadius: const BorderRadius.all(
      //                           const Radius.circular(8.0),
      //                         ),
      //                         borderSide: BorderSide.none),
      //                     filled: true,
      //                     fillColor: Colors.white,
      //                     hintText: "Search here",
      //                     hintStyle: Theme.of(context).textTheme.subtitle1),
      //                 onChanged: (value) {
      //                   context.read<OrderBloc>().add(OrderSearched(value));
      //                 },
      //                 // readOnly: true,
      //                 // onTap: () {
      //                 //   print("Tapped");
      //                 //   // Navigator.push(context,
      //                 //   //     MaterialPageRoute(builder: (_) => Search()));
      //                 // },
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //       actions: [
      //         IconButton(icon: Icon(Icons.code), onPressed: () {}),
      //         IconButton(icon: Icon(Icons.favorite), onPressed: () {})
      //       ],
      //     )
      ,
      body: _buildBody(
          scrollController: scrollController,
          context: context,
          searchController: searchController),
      // NestedScrollView(
      //   headerSliverBuilder: (context, innerBoxScrolled) => [
      //     SliverAppBar(
      //       automaticallyImplyLeading: false,
      //       pinned: true,
      //       title: Row(
      //         children: [
      //           Expanded(
      //             child: SizedBox(
      //               child: TextFormField(
      //                 maxLines: 1,
      //                 decoration: InputDecoration(
      //                     prefixIcon: Icon(Icons.search),
      //                     contentPadding: EdgeInsets.all(8),
      //                     border: new OutlineInputBorder(
      //                         borderRadius: const BorderRadius.all(
      //                           const Radius.circular(8.0),
      //                         ),
      //                         borderSide: BorderSide.none),
      //                     filled: true,
      //                     fillColor: Colors.white,
      //                     hintText: "Search here",
      //                     hintStyle: Theme.of(context).textTheme.subtitle1),
      //                 onChanged: (value) {
      //                   context.read<OrderBloc>().add(OrderSearched(value));
      //                 },
      //                 // readOnly: true,
      //                 // onTap: () {
      //                 //   print("Tapped");
      //                 //   // Navigator.push(context,
      //                 //   //     MaterialPageRoute(builder: (_) => Search()));
      //                 // },
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //       actions: [
      //         IconButton(icon: Icon(Icons.code), onPressed: () {}),
      //         IconButton(icon: Icon(Icons.favorite), onPressed: () {})
      //       ],
      //     )
      //   ],
      // ),
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
