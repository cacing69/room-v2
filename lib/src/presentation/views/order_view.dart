import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:room_v2/src/core/bloc/bloc_with_state.dart';
import 'package:room_v2/src/domain/entities/order.dart';
import 'package:room_v2/src/presentation/blocs/remote_order/remote_order_bloc.dart';

class OrderView extends HookWidget {
  const OrderView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController
          .addListener(() => _onScrollListener(context, scrollController));

      return scrollController.dispose;
    }, [scrollController]);

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

      // if (state is RemoteOrderError) {
      //   return Center(
      //     child: Icon(Icons.refresh),
      //   );
      // }

      if (state.data.isNotEmpty) {
        return _buildOrder(scrollController, state.data, state.noMoredata);
      }
      return SizedBox();
    });
  }

  Widget _buildOrder(
      ScrollController scrollController, List<Order> data, bool noMoreData) {
    return ListView(controller: scrollController, children: [
      ...List<Widget>.from(data.map((e) => Builder(
          builder: (context) => Text(
                e.no,
                style: Theme.of(context).textTheme.headline4,
              )))),
      if (noMoreData) ...[
        Text("No Data"),
      ] else ...[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: CupertinoActivityIndicator(),
        )
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

    if (currentScroll == maxScroll && state == BlocProcessState.idle) {
      // remote
      context.read<RemoteOrderBloc>()
        ..add(RemoteOrderLoading())
        ..add(RemoteOrderFetched());
    }
  }
}
