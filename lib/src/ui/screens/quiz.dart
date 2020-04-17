import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:p3_guide/src/bloc/bloc.dart';
import 'package:p3_guide/src/models/quiz_answer_model.dart';
import 'package:p3_guide/src/service_locator.dart';
import 'package:p3_guide/src/ui/main_drawer.dart';
import 'package:p3_guide/src/utils/text_theme_utils.dart';

class QuizAnswersScreen extends StatefulWidget {
  static const String namedRoute = "/questionary-answers";

  @override
  _QuizAnswersScreenState createState() => _QuizAnswersScreenState();
}

class _QuizAnswersScreenState extends State<QuizAnswersScreen> {
  final bloc = serviceLocator.get<QuizAnswerBloc>();

  @override
  void initState() {
    bloc.add(QuizAnswerEventFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      endDrawer: MainDrawer(),
      drawerEdgeDragWidth: 40,
      body: Container(
        height: mq.size.height,
        padding: EdgeInsets.all(16),
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is QuizAnswerStateError) {
              return Center(
                child: Text(
                  "There was an error trying to retrieve the quize's answers!",
                ),
              );
            } else if (state is QuizAnswerStateUnitialized) {
              return Center(child: CircularProgressIndicator());
            } else if (state is QuizAnswerStateLoaded) {
              return Center(
                child: ListView.separated(
                  separatorBuilder: (_, i) => SizedBox(
                    height: 8,
                  ),
                  itemCount: state.quizBlocks.length,
                  itemBuilder: (_, index) => Container(
                    width: double.infinity,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    // color: Theme.of(context).primaryColor,
                    child: Container(
                      child: ExpansionTile(
                        title: Text(
                          DateFormat("MMMM")
                              .format(DateTime(
                                  2009, state.quizBlocks[index].monthNumber))
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).accentColor,
                          child: Text(
                            state.quizBlocks[index].monthNumber.toString(),
                            style: TextThemeUtils.DARK_MENU_TEXT,
                          ),
                        ),

                        children: <Widget>[
                          ...state.quizBlocks[index].quizList
                              .map((q) => _buildQuizBlock(q))
                              .toList()
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildQuizBlock(QuizAnswerModel qab) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(-4, 4),
            blurRadius: 5.0,
          ),
        ],
        color: Colors.black38,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(35),
        ),
      ),
      width: double.infinity,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 4),
            alignment: Alignment.topLeft,
            height: 40,
            child: Text(
              qab.occursOn,
              style: TextThemeUtils.DARK_MENU_TEXT.copyWith(
                color: Theme.of(context).accentColor.withOpacity(0.9),
                fontSize: 36,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...qab.answers
                    .map((a) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            a,
                            textAlign: TextAlign.right,
                            style: TextThemeUtils.LIGHT_MENU_TEXT.copyWith(
                                fontSize: 20,
                                color: Colors.blueGrey.shade300,
                                fontStyle: FontStyle.italic,
                                shadows: []),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
