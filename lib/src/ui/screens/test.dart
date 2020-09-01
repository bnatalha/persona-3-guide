// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:p3_guide/src/ui/screens/social_link_detail/social_link_rank_view.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context);

//     final testWidget = RankView(
//       ranks: List<String>.generate(8, (i) => "$i"),
//     );

//     // final testWidget = Spinner();

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             height: mq.size.height - mq.padding.top,
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.all(0),
//               child: testWidget,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// TEST CLASS

// class Spinner extends StatefulWidget {
//   @override
//   _SpinnerState createState() => _SpinnerState();
// }

// class _SpinnerState extends State<Spinner> with TickerProviderStateMixin {
//   AnimationController _controller;
//   Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 20.0, end: 200.0).animate(_controller);
//     _controller.addListener(() => print('${_animation.value}'));
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SpinningContainer(animation: _animation);
//   }
// }

// class SpinningContainer extends AnimatedWidget {
//   const SpinningContainer({Key key, Animation animation})
//       : super(key: key, listenable: animation);

//   Animation<double> get _progress => listenable;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: _progress.value,
//       color: Colors.green,
//       // child: Text('${_progress.value.toStringAsFixed(2)}'),
//     );
//   }
// }
