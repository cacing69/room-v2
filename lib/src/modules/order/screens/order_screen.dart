import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:room_v2/src/core/bloc/bloc_with_state.dart';
import 'package:room_v2/src/core/utils/helper.dart';
import 'package:room_v2/src/modules/order/bloc/remote_order_bloc.dart';
import 'package:room_v2/src/modules/order/models/order.dart';

class OrderScreen extends HookWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useMemoized(() => ScrollController());

    // useEffect(() {
    //   scrollController
    //       .addListener(() => _onScrollListener(context, scrollController));

    //   return scrollController.dispose;
    // }, [scrollController]);
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
      body: _buildBody(scrollController),
    );
  }

  Widget _buildBody(ScrollController scrollController) {
    return BlocBuilder<RemoteOrderBloc, RemoteOrderState>(builder: (_, state) {
      if (state.isLoading && state.isFirst) {
        return Center(
          child: CupertinoActivityIndicator(),
        );
      }

      if (state.error != null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Icon(Icons.refresh), Text(state.error.message)],
        );
      } else {
        if (state.data.isNotEmpty) {
          return _buildOrder(scrollController, state);
        }
      }

      return SizedBox();
    });
  }

  Widget _buildOrder(
      ScrollController scrollController, RemoteOrderState state) {
    return ListView(controller: scrollController, children: [
      ...List<Widget>.from(state.data.map((e) => Builder(
          builder: (context) => Container(
                height: 68,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.no,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        e.status,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              )))),
      if (state.noMoredata) ...[
        Text("No Data"),
      ] else ...[
        if (state.isLoading) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: CupertinoActivityIndicator(),
          )
        ]
      ]
    ]);
  }

  void _onScrollListener(
      BuildContext context, ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final remoteOrderBloc = BlocProvider.of<RemoteOrderBloc>(context);
    // final remoteOrderBloc = context.watch<RemoteOrderBloc>();
    final state = remoteOrderBloc.blocProcessState;

    if (currentScroll == maxScroll) {
      // remote
      if (state == BlocProcessState.idle) {
        context.read<RemoteOrderBloc>()
          ..add(RemoteOrderLoading())
          ..add(RemoteOrderFetched());
      } else {
        if (remoteOrderBloc.state.isLoading && state == BlocProcessState.busy) {
          // showSnackBar(context, message: "Fetching Data");
          // Show info load data
        }
      }
    }
  }
}
