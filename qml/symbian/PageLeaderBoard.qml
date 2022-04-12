import QtQuick 1.1
import com.nokia.symbian 1.1
import "scoreengine.js" as ScoreEngine

Page{
    id: pageLeaderBoard

    orientationLock: PageOrientation.LockLandscape

    property variant modenames: ["easy",'medium','expert'] // [easy] , [medium], [expert]

    property int currentModeIndex: 0

    property int localHighscore: 0

    property string currentName: "NOT SET"

    signal ready()

    function processScore(scoresText){
        scoreModel.clear()

        console.log(scoresText)

        var myObject = eval('(' + scoresText + ')');

        var scorearray = myObject.scores;

        console.log('number of scores fetched ' + scorearray.length);

        for(var i = 0, len = scorearray.length; i < len; ++i) {
            var score = scorearray[i];

            scoreModel.insert(scoreModel.count,score);

            console.log(scoreModel.get(i).username + ' ' + scoreModel.get(i).points);
        }

        pageLeaderBoard.localHighscore = ScoreEngine.getLocalScore(pageLeaderBoard.currentModeIndex);

        highlightName();

        busyAnimation.animationRunning = false;

        console.log('finished parsing , model size : ' + scoreModel.count)
    }

    function highlightName(){

        for(var i = 0; i < scoreModel.count; ++i) {
            var usrName = scoreModel.get(i).username;

            console.log('parsing value : ' + usrName);

            if(usrName === pageLeaderBoard.currentName)
            {
                highScoreListView.currentIndex = i;

                console.log('set current index : ' + i + ' , username : ' + usrName + ' , parameter name : ' + pageLeaderBoard.currentName);

                return;
            }
        }

        console.log('not found parameter name : ' + pageLeaderBoard.currentName);
    }

    BusyAnimation{
        id:busyAnimation
        width: 48
        height: 48
        anchors.centerIn: parent
        z:100
        animationRunning: false
        anchors.horizontalCenter: parent.horizontalCenter
        visible: animationRunning
    }

    Rectangle{
        color: "black"
//        border.color: "white"
//        radius: 10
        opacity: 1
        anchors.fill: parent
//        anchors.margins: 2
    }

    ListModel{
        id: scoreModel
    }

    Component{
        id: headerView

        Item{
            width: highScoreListView.width * 0.7
            height: 35
            Text {
                id: detailsTitle
                text: "High score ranking for " + pageLeaderBoard.modenames[pageLeaderBoard.currentModeIndex]
                font{ pointSize: 8; family: pageMain.canvas.localFont.name }
//                font{ pointSize: 8; family: "Stylus_BT" }
                color: "#FFFFFF"
                anchors.centerIn: parent
            }
        }
    }

    Component{
        id: highLightView
        Rectangle{
            width: highScoreListView.width * 0.7
            height: 35
            color: "orange"
        }
    }

    ListView{
        id: highScoreListView
        anchors.fill: parent
        anchors.margins: 30
        header: headerView
        z:1
        model: scoreModel
        highlight: highLightView
        highlightFollowsCurrentItem: true
        delegate: Item{
            width: highScoreListView.width
            height: 30
            Row{
                id: row
                spacing: 10
                Text {
                    color: "white"
                    text: username
                    font{pointSize: 8; family: pageMain.canvas.localFont.name }
                    width: 200
                }

                Text {
                    text: points
                    color: "white"
                    font{ pointSize: 8; family: pageMain.canvas.localFont.name }
                }
            }
        }
    }

    Column{
        id: backButton
        width: 90
        height: 60
        spacing: 6
        anchors{ right: parent.right; rightMargin: 15; bottom: parent.bottom; bottomMargin: 15 }
        z: 4

        Image{
            id: backIcon
            source: backArea.pressed? "assets/images/menu/button/back_pressed.png": "assets/images/menu/button/back.png"
            anchors.centerIn: parent
            fillMode: Image.Stretch

            Image {
                id: backIconShadow
                source: "assets/images/menu/button/shadowed_buttons.png"
                anchors.fill: parent
                visible: !backArea.pressed
            }
        }

        MouseArea
        {
            id: backArea
            anchors.fill: parent
            onClicked: { pageMain.audioController.playTapSoundEffect(); pageStack.pop() }
        }
    }

    Column{
        spacing: 10
        anchors.bottom: backButton.top
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 15
        z: 4

        Item{
            width: 90
            height: 60

            Image{
                source: "assets/images/menu/button/easy_invert.png"
                anchors.centerIn: parent
                fillMode: Image.Stretch
            }

            MouseArea{
                anchors.fill: parent
                onClicked: { pageMain.audioController.playTapSoundEffect(); pageLeaderBoard.currentModeIndex = 0; pageLeaderBoard.localHighscore = ScoreEngine.getLocalScore(0); busyAnimation.animationRunning = true; ScoresUtility.fetchScores(0) }
            }
        }

        Item{
            width: 90
            height: 60

            Image{
                source: "assets/images/menu/button/medium_invert.png"
                anchors.centerIn: parent
                fillMode: Image.Stretch
            }

            MouseArea{
                anchors.fill: parent
                onClicked: { pageMain.audioController.playTapSoundEffect(); pageLeaderBoard.currentModeIndex = 1; pageLeaderBoard.localHighscore = ScoreEngine.getLocalScore(1); busyAnimation.animationRunning = true;  ScoresUtility.fetchScores(1) }
            }
        }

        Item{
            width: 90
            height: 60

            Image{
                source: "assets/images/menu/button/expert_invert.png"
                anchors.centerIn: parent
                fillMode: Image.Stretch
            }

            MouseArea{
                anchors.fill: parent
                onClicked: { pageMain.audioController.playTapSoundEffect(); pageLeaderBoard.currentModeIndex = 2; pageLeaderBoard.localHighscore = ScoreEngine.getLocalScore(2); busyAnimation.animationRunning = true;  ScoresUtility.fetchScores(2) }
            }
        }
    }

    Text{
        id: localHighScoreText
        text: "Local highscore <br/>" + localHighscore
        horizontalAlignment: Text.AlignHCenter
        color: "yellow"
        font.pointSize: 8
        font.family: pageMain.canvas.localFont.name
        anchors{ right: parent.right; top: parent.top; topMargin: 15; rightMargin: 15 }
    }

     Connections{
        target: ScoresUtility
        onScoresFetched: processScore(scores);
     }

     Component.onCompleted: ScoreEngine.loadDatabase();
}


