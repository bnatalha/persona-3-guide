import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RankIndexEvent extends Equatable {
  final int currentIndex;
  const RankIndexEvent(this.currentIndex);

  @override
  // TODO: implement props
  List<Object> get props => [currentIndex];
}

class RankIndexEventInitial extends RankIndexEvent {
  const RankIndexEventInitial() : super(0);
}

class RankIndexEventFoward extends RankIndexEvent {
  const RankIndexEventFoward(int currentIndex) : super(currentIndex);
}

class RankIndexEventReverse extends RankIndexEvent {
  const RankIndexEventReverse(int currentIndex) : super(currentIndex);
}

class RankView extends StatefulWidget {
  final List<String> ranks;

  const RankView({Key key, @required this.ranks}) : super(key: key);

  @override
  _RankViewState createState() => _RankViewState();
}

// class _RankViewState extends State<RankView> {
class _RankViewState extends State<RankView>
    with SingleTickerProviderStateMixin {
  bool isInit = true;
  ScrollController _textController;
  BehaviorSubject _scrollSubject;
  int _listIndex;

  final Duration _scrollDuration = Duration(milliseconds: 200);
  // final Duration _scrollDuration = Duration(seconds: 2);

  @override
  void initState() {
    _listIndex = 0;
    _textController = ScrollController();
    _scrollSubject = BehaviorSubject<RankIndexEvent>();

    _scrollSubject.listen((data) => _scrollList(data));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      // _animation = Tween<Color>(
      //   // begin: Colors.blue.shade900,
      //   begin: Colors.black,
      //   end: Colors.blue,
      //   // end: Theme.of(context).accentColor,
      // ).animate(_animationController);
      isInit = false;
    }
    isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final itemExtent = mq.size.width;

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
                    // color: Theme.of(context).primaryColor,
                    // color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // itemExtent: 18,
                      // controller: _squareController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.ranks.length,
                      itemBuilder: (context, index) => RankSquare(
                        duration: _scrollDuration,
                        scrollSubject: _scrollSubject,
                        index: index,
                        beginColor: Theme.of(context).primaryColor,
                        endColor: Theme.of(context).accentColor,
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
                  controller: _textController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.ranks.length,
                  itemBuilder: (_, index) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: Theme.of(context).primaryColor,
                    alignment: Alignment.center,
                    child: Text(
                      widget.ranks[index],
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

  _scrollList(dynamic rankEvent) async {
    double itemExtent = MediaQuery.of(context).size.width;
    if (rankEvent is RankIndexEventReverse) {
      itemExtent = -itemExtent;
    }

    if (!(rankEvent is RankIndexEventInitial)) {
      // var completer = new Completer<Null>();
      await _textController.animateTo(_textController.offset + itemExtent,
          duration: _scrollDuration, curve: Curves.ease);
      // print("controller.offset ${_textController.offset}");
    }
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
              if (isLeft && _listIndex > 0) {
                _listIndex--;
                _scrollSubject.sink.add((RankIndexEventReverse(_listIndex)));
              } else if (!isLeft && _listIndex < widget.ranks.length - 1) {
                _listIndex++;
                _scrollSubject.sink.add((RankIndexEventFoward(_listIndex)));
              }
            },
          ),
        ),
      ),
    );
  }
}

class RankSquare extends StatefulWidget {
  RankSquare({
    Key key,
    @required BehaviorSubject scrollSubject,
    @required this.index,
    @required this.duration,
    @required this.beginColor,
    @required this.endColor,
  })  : scrollSubject = scrollSubject,
        super(key: key);

  final BehaviorSubject scrollSubject;
  final int index;
  final Duration duration;
  final Color beginColor;
  final Color endColor;

  @override
  _RankSquareState createState() => _RankSquareState(beginColor, endColor);
}

class _RankSquareState extends State<RankSquare>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> animation;
  bool isInit = true;

  final Color beginColor;
  final Color endColor;

  _RankSquareState(this.beginColor, this.endColor);

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    animation = ColorTween(begin: beginColor, end: endColor)
        .animate(_animationController);

    _animationController.addStatusListener((status) {
      print("${widget.index}: $status");
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      widget.scrollSubject.listen((offsetValue) => _animate(offsetValue));
      widget.scrollSubject.sink.add(RankIndexEventInitial());
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
        child: AnimatedRankSquare(
          controller: animation,
        ));
  }

  _animate(dynamic rankEvent) {
    if (rankEvent is RankIndexEventFoward) {
      if (rankEvent.currentIndex - 1 == widget.index) {
        return outByRight();
      }
      if (rankEvent.currentIndex == widget.index) {
        return inByLeft();
      }
    } else if (rankEvent is RankIndexEventReverse) {
      if (rankEvent.currentIndex + 1 == widget.index) {
        return outByLeft();
      }
      if (rankEvent.currentIndex == widget.index) {
        return inByRight();
      }
    } else if (rankEvent is RankIndexEventInitial &&
        rankEvent.currentIndex == widget.index) {
      return inByRight();
    }
  }

  // Container inByLeft() => Container(color: Colors.amber);
  // Container outByRight() => Container(color: Colors.blue, child: Text('>'));
  // Container inByRight() => Container(color: Colors.amber);
  // Container outByLeft() => Container(color: Colors.blue, child: Text("<"));

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
