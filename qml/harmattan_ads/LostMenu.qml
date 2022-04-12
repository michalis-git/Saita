// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "scoreengine.js" as ScoreEngine
import QtMultimediaKit 1.1
import GEAudio 1.0

Item {
    id: lostMenu
    width: 366
    height: 218

    property int bonusValue: 10

    property int bonusItems: 0

    property int score: 0

    signal restart()
    signal backToMenu()
    signal nameChanged(string name);

    function checkError(scoreReplyText)
    {
        popup.animationRunning = false

        var myObject = eval('(' + scoreReplyText + ')');

        var key = 'error'

        if(!myObject.hasOwnProperty(key))
        {
            lostMenu.nameChanged(popup.name);

            ScoresUtility.fetchScores(pageMain.difficultyLevel)
        }

        lostMenu.state = ''
    }

    function saveScore(){
        pageMain.audioController.playLostMusic();

//        musicTimer.start();
        oneLifeTimer.start();
    }

    Timer{
        id: oneLifeTimer
        running: false
        interval: 1500

        onTriggered: { lostMenuTimer.start() }
    }

//    Timer{
//        id:musicTimer
//        running: false
//        interval: 4313

//        onTriggered: { console.log('trying to stop lost audio..'); pageMain.audioController.stopLostMusic() }
//    }

    Timer{
        id: lostMenuTimer
        running: false
        interval: 400
        repeat: true

        onTriggered: { if(bonusItems){
                pageMain.audioController.playAppendBonusItemSoundEffect();

                bonusIcon.source = 'assets/images/extras/apple_bitten.png';
                bonusItems--;
                score += bonusValue;
            }else{
                lostMenuTimer.running = false;
                ScoreEngine.saveScoreToDisk(score);
            }
        }
    }

    Image{
        id:backgroundLostMenu
        source: "assets/images/menu/lost_menu/lost_menu_wall.png"
        anchors.fill: parent
        opacity: 0.90
    }

    Item{
        id: mainRect
        anchors.centerIn: parent
        opacity: 0.8
        anchors.fill: backgroundLostMenu


        Column{
            anchors.centerIn: parent
            spacing: 20

            Item{
                height: 32
                width: lostMenu.width * 0.9
                anchors.horizontalCenter: parent.horizontalCenter

                Row{
                    id: bonusRow
                    width: parent.width * 0.3
                    spacing: 4
                    z: 10
                    visible: bonusItems > 0

                    Image{
                        id: bonusIcon
                        source: "assets/images/extras/apple.png"
                        width: 24
                        height: 24
                        anchors.verticalCenter: parent.verticalCenter

                        Behavior on source{
                            PropertyAnimation { target: bonusIcon; duration: lostMenuTimer.interval / 2}
                        }
                    }

                    Text{
                        id: bonusText
                        text: bonusItems
                        font{ pointSize: 21; bold: true; family: canvas.localFont.name }
                        color: "blue"
                        anchors.verticalCenter: parent.verticalCenter

                        Behavior on text {
                            SequentialAnimation{
                                NumberAnimation { target: bonusText; property: "font.pointSize"; to: 25; duration: lostMenuTimer.interval * 0.5 }
                                PropertyAnimation { target: bonusIcon; property: "source"; to: "assets/images/extras/apple.png"; duration: lostMenuTimer.interval * 0.1 }
                                NumberAnimation { target: bonusText; property: "font.pointSize"; to: 21; duration: lostMenuTimer.interval * 0.4 }
                            }
                        }
                    }
                }

                Row{
                    spacing: 2
                    width: parent.width * 0.7
                    height: 32
                    anchors.left: bonusRow.right
                    anchors.leftMargin: 15
                    z: 10

                    Text{
                        text: 'Score '
                        font { pointSize: 21; family: canvas.localFont.name; bold: true }
                        color: "blue"
                    }

                    Text{
                        id: scoreText
                        text: score
                        font{pointSize: 21;  family: canvas.localFont.name; bold: true }
                        color: "blue"

                        Behavior on text {
                             SequentialAnimation {
                                 NumberAnimation { target: scoreText; property: "font.pointSize"; to: 25; duration: lostMenuTimer.interval / 2 }
                                 NumberAnimation { target: scoreText; property: "font.pointSize"; to: 21; duration: lostMenuTimer.interval / 2 }
                             }
                         }
                    }

                    Text{
                        text: 'm'
                        font{pointSize: 21; family: canvas.localFont.name; bold: true }
                        color: "blue"
                    }
                }
            }

            Row{
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Item{
                    width: 80
                    height: 80

                    Image{
                        source: replayArea.pressed? "assets/images/menu/lost_menu/replay_pressed.png": "assets/images/menu/lost_menu/replay.png"
                        anchors.centerIn: parent

                        Image {
                            id: replayIconShadow
                            anchors.rightMargin: 3
                            anchors.topMargin: 3
                            source: "assets/images/menu/button/shadowed_buttons.png"
                            anchors.fill: parent
                            visible: !replayArea.pressed
                        }
                    }

                    MouseArea{
                        id: replayArea
                        anchors.fill: parent
                        enabled: bonusItems == 0

                        onClicked: { pageMain.audioController.stopLostMusic(); pageMain.audioController.playTapSoundEffect(); lostMenu.restart() }
                    }
                }

                Item{
                    width: 80
                    height: 80

                    Image{
                        source: backToMenuArea.pressed? "assets/images/buttons/main_menu_pressed.png": "assets/images/buttons/main_menu_shaded.png"
                        anchors.centerIn: parent

                        Image {
                            id: backToMenuIconShadow
                            anchors.rightMargin: 3
                            anchors.topMargin: 3
                            source: "assets/images/menu/button/shadowed_buttons.png"
                            anchors.fill: parent
                            visible: !backToMenuArea.pressed
                        }
                    }

                    MouseArea{
                        id: backToMenuArea
                        anchors.rightMargin: 0
                        anchors.topMargin: 0
                        anchors.fill: parent
                        enabled: bonusItems == 0

                        onClicked: { pageMain.audioController.stopLostMusic(); pageMain.audioController.playTapSoundEffect(); lostMenu.backToMenu() }
                    }
                }

                Item{
                    width: 80
                    height: 80

                    Image{
                        source: scoresArea.pressed? "assets/images/menu/button/scores_pressed.png": "assets/images/menu/button/scores.png"
                        anchors.centerIn: parent

                        Image {
                            id: scoresIconShadow
                            anchors.rightMargin: 3
                            anchors.topMargin: 3
                            source: "assets/images/menu/button/shadowed_buttons.png"
                            anchors.fill: parent
                            visible: !scoresArea.pressed
                        }
                    }

                    MouseArea{
                        id: scoresArea
                        anchors.fill: parent
                        enabled: bonusItems == 0

                        onClicked: { pageMain.audioController.playTapSoundEffect(); lostMenu.state = 'popup' }
                    }
                }
            }

            Image{
                source: "assets/images/menu/lost_menu/you_lost.png"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    PopUp{
        id: popup
        anchors.fill: parent
        anchors.margins: 4
        visible: false
        opacity: 0.0
        z: 100
        onNameChanged: popup.nameChanged(name)
        onBack: lostMenu.state = ''
    }

    Connections{
        target: ScoresUtility
        onScoreSaved: { checkError(score) }
    }

    states:[
        State{
            name: "popup"

            StateChangeScript{ name: "popupScript"; script: popup.score = lostMenu.score }
            PropertyChanges { target: popup; visible: true; opacity: 1.0 }
            PropertyChanges { target: mainRect; visible: false; opacity: 0.0 }
        }
    ]

    transitions: [
        Transition {

            NumberAnimation{ target: popup; properties: "opacity" }
        }
    ]

    Component.onCompleted: ScoreEngine.loadDatabase();
}
