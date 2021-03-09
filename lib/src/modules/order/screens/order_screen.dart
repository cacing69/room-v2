import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:room_v2/src/core/bloc/bloc_with_state.dart';
import 'package:room_v2/src/modules/order/bloc/remote_order_bloc.dart';
import 'package:room_v2/src/modules/order/models/order.dart';

class OrderScreen extends HookWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: _buildBody(scrollController: scrollController, context: context),
    );
  }

  Widget _buildBody({ScrollController scrollController, BuildContext context}) {
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
          return _buildOrder(
              scrollController: scrollController,
              state: state,
              context: context);
        }
      }

      return SizedBox();
    });
  }

  Widget _buildOrderItem({Order data, BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.no,
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            data.status,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  Future refreshData(BuildContext context) async {
    final remoteOrderBloc = BlocProvider.of<RemoteOrderBloc>(context);
    final processState = remoteOrderBloc.blocProcessState;

    if (processState == BlocProcessState.idle) {
      context.read<RemoteOrderBloc>()
        ..add(RemoteOrderRefreshed())
        ..add(RemoteOrderCalled())
        ..add(RemoteOrderFetched());
    }
    return null;
  }

  Widget _buildOrder(
      {ScrollController scrollController,
      RemoteOrderState state,
      BuildContext context}) {
    return RefreshIndicator(
      onRefresh: () {
        return refreshData(context);
      },
      child: ListView(controller: scrollController, children: [
        ...List<Widget>.from(state.data.map((e) => Builder(
            builder: (context) => Container(
                  height: 75,
                  child: _buildOrderItem(data: e, context: context),
                )))),
        if (!state.hasNext) ...[
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("End of page"),
          )),
        ],
        if (state.isLoading) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: CupertinoActivityIndicator(),
          )
        ]
      ]),
    );
  }

  void _onScrollListener(
      BuildContext context, ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final remoteOrderBloc = BlocProvider.of<RemoteOrderBloc>(context);
    final processState = remoteOrderBloc.blocProcessState;

    if (currentScroll == maxScroll) {
      if (processState == BlocProcessState.idle) {
        context.read<RemoteOrderBloc>()
          ..add(RemoteOrderCalled())
          ..add(RemoteOrderFetched());
      } else {
        if (remoteOrderBloc.state.isLoading &&
            processState == BlocProcessState.busy) {
          // Do somestuff while app busy
        }
      }
    }
  }
}
