import 'package:destini_challenge_starting/story_brain.dart';
import 'package:flutter/material.dart';

void main() => runApp(Destini());

class Destini extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: StoryPage(),
    );
  }
}

StoryBrain storyBrain = new StoryBrain();

class StoryPage extends StatefulWidget {
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.png"), fit: BoxFit.cover),
        ),
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyBrain.getStory(),
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("images/button_background.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                          child: Text(
                        storyBrain.getChoice1(),
                        style: TextStyle(fontSize: 17),
                      )),
                    ),
                    onTap: () {
                      //Choice 1 made by user.
                      setState(() {
                        storyBrain.nextStory(1);
                      });
                    }),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: storyBrain.buttonShouldBeVisible(),
                  child: GestureDetector(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                          image: DecorationImage(
                              image: AssetImage("images/button_background.png"),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                            child: Text(storyBrain.getChoice2(),
                                style: TextStyle(fontSize: 17))),
                      ),
                      onTap: () {
                        //Choice 2 made by user.
                        setState(() {
                          storyBrain.nextStory(2);
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
