import 'package:flutter/material.dart';
import 'package:p3_guide/src/bloc/bloc.dart';

class RankView extends StatefulWidget {
  // final SLinkDetailBloc bloc = GetIt.I.get<SLinkDetailBloc>();
  final SLinkDetailBloc bloc;

  const RankView({Key key, @required this.bloc}) : super(key: key);

  @override
  _RankViewState createState() => _RankViewState(bloc);
}

class _RankViewState extends State<RankView>
    with SingleTickerProviderStateMixin {
  final SLinkDetailBloc bloc;
  final Duration _scrollDuration = Duration(milliseconds: 200);
  ScrollController _textScrollController;

  _RankViewState(this.bloc);

  @override
  void initState() {
    _textScrollController = ScrollController();
    bloc.rankCtrl
        .listen((rankEvent) => _scrollHorizontalRankTextList(rankEvent));

    super.initState();
  }

  @override
  void dispose() {
    _textScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    bloc.itemExtent = mq.size.width;
    final itemExtent = bloc.itemExtent;

    return Container(
      height: 170,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      "Ranks".toUpperCase(),
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: bloc.ranks.length,
                      itemBuilder: (context, index) => RankSquare(
                        duration: _scrollDuration,
                        index: index,
                        beginColor: Theme.of(context).primaryColor,
                        endColor: Theme.of(context).accentColor,
                        bloc: bloc,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemExtent: itemExtent,
                  controller: _textScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: bloc.ranks.length,
                  itemBuilder: (_, index) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: Theme.of(context).primaryColor,
                    alignment: Alignment.center,
                    child: Text(
                      bloc.ranks[index],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildScrollButton(isLeft: true, itemExtent: itemExtent),
                    buildScrollButton(itemExtent: itemExtent),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildScrollButton({bool isLeft, @required double itemExtent}) {
    isLeft = isLeft ?? false;
    return Container(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      width: 100,
      child: Opacity(
        opacity: 0.15,
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          height: double.infinity,
          child: IconButton(
            splashColor: Colors.transparent,
            enableFeedback: false,
            icon: Icon(
              isLeft ? Icons.arrow_back : Icons.arrow_forward,
              size: 24,
              color: Colors.white,
            ),
            onPressed: () {
              if (isLeft && bloc.currentIndex > 0) {
                bloc.currentIndex--;
                bloc.pushIndexEvent(RankIndexEventPrevious());
              } else if (!isLeft && bloc.currentIndex < bloc.ranks.length - 1) {
                bloc.currentIndex++;
                bloc.pushIndexEvent(RankIndexEventNext());
              }
            },
          ),
        ),
      ),
    );
  }

  _scrollHorizontalRankTextList(RankIndexEvent rankEvent) async {
    var offset = bloc.itemExtent * (bloc.currentIndex);

    await _textScrollController.animateTo(offset,
        duration: _scrollDuration, curve: Curves.ease);
  }
}

class RankSquare extends StatefulWidget {
  RankSquare({
    Key key,
    @required this.index,
    @required this.duration,
    @required this.beginColor,
    @required this.endColor,
    @required this.bloc,
  }) : super(key: key);

  final int index;
  final Duration duration;
  final Color beginColor;
  final Color endColor;
  final SLinkDetailBloc bloc;

  @override
  _RankSquareState createState() =>
      _RankSquareState(beginColor, endColor, bloc);
}

class _RankSquareState extends State<RankSquare>
    with SingleTickerProviderStateMixin {
  final SLinkDetailBloc bloc;
  AnimationController _animationController;
  Animation<Color> animation;
  bool isInit = true;

  final Color beginColor;
  final Color endColor;

  _RankSquareState(this.beginColor, this.endColor, this.bloc);

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    animation = ColorTween(begin: beginColor, end: endColor)
        .animate(_animationController);

    _animationController.addStatusListener((status) {
      print("${widget.index}: $status");
    });

    if (widget.index == 0) {
      inByLeft();
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      bloc.rankCtrl.listen((rankEvent) => _animate(rankEvent));
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      margin: const EdgeInsets.fromLTRB(0, 8, 8, 4),
      color: Colors.blue.shade900,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedRankSquare(
          controller: animation,
        ),
      ),
    );
  }

  _animate(RankIndexEvent rankEvent) {
    if (rankEvent is RankIndexEventNext) {
      if (bloc.currentIndex - 1 == widget.index) {
        return outByRight();
      }
      if (bloc.currentIndex == widget.index) {
        return inByLeft();
      }
    } else if (rankEvent is RankIndexEventPrevious) {
      if (bloc.currentIndex + 1 == widget.index) {
        return outByLeft();
      }
      if (bloc.currentIndex == widget.index) {
        return inByRight();
      }
    } else if (rankEvent is RankIndexEventNext &&
        bloc.currentIndex == widget.index) {
      return inByRight();
    }
  }

  inByLeft() {
    print('iLeft');
    _animationController.forward();
  }

  outByRight() {
    print('oRight');
    _animationController.reverse();
  }

  inByRight() {
    print('iRight');
    _animationController.forward();
  }

  outByLeft() {
    print('oLeft');
    _animationController.reverse();
  }
}

class AnimatedRankSquare extends AnimatedWidget {
  AnimatedRankSquare({Key key, Animation controller})
      : super(key: key, listenable: controller);

  Animation<Color> get _progress => listenable;

  @override
  Widget build(BuildContext context) => Container(
        color: _progress.value,
      );
}

// if (isLeft) {
//   final isLeft = value < 0;
//   if (widget._listIndex + 1 == widget.index) {
//     // <
//     return outByLeft();
//   }
//   if (widget._listIndex == widget.index) {
//     // d
//     return inByRight();
//   }
// } else {
//   if (widget._listIndex - 1 == widget.index) {
//     // >
//     return outByRight();
//   }
//   if (widget._listIndex == widget.index) {
//     // b
//     return inByLeft();
//   }
// }
// return Text("x");
