import QtQuick 1.1
import QtMultimediaKit 1.1
import "scoreengine.js" as ScoreEngine
import com.nokia.meego 1.0
import GEAudio 1.0

Page{
    id: pageGameOver

    property int score: 0
    property int bonus: 0
    property int bonusValue: 10

    // change this to other screen resolutions
    anchors.fill: parent

    orientationLock: PageOrientation.LockLandscape

    function saveScore(){
        pageMain.audioController.playGameOverMusic();

        oneLifeTimer.start();
    }

    Timer{
        id:spriteAnimationTimer
        interval:120
        running:pageGameOver.visible
        repeat:true
        onTriggered:{
            spriteAnimation.currentFrame++
            spriteAnimation.currentFrame%=spriteAnimation.framesCount
        }
    }

    Timer{
        id: oneLifeTimer
        running: false
        interval: 1500

        onTriggered: { gameOverTimer.start() }
    }

    Timer{
        id: gameOverTimer
        running: false
        interval: 400
        repeat: true

        onTriggered: { if(bonus){
                pageMain.audioController.playAppendBonusItemSoundEffect();

                bonusIcon.source = 'assets/images/extras/apple_bitten.png';
                bonus--;
                score += bonusValue;
            }else{
                gameOverTimer.running = false;
                ScoreEngine.saveScoreToDisk(score);
            }
        }
    }

    Rectangle {
        anchors.fill: parent

        signal nameChanged(string name);

        border.color: "black"

        radius: 5

        color: "#6e8829"

        border.width: 2

        Column{
            spacing: 10

            anchors.centerIn: parent

            Text {
                id: text1
                color: "#222222"
                text: qsTr("Congratulations!<br/>Game Over")
                horizontalAlignment: Text.AlignHCenter
                font{italic: false; bold: true; pointSize: 26; family: canvas.localFont.name }
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item{
                id:spriteAnimation
                property int framesCount:8
                property int currentFrame:0

                anchors.horizontalCenter: parent.horizontalCenter

                clip:true

                height:spriteAnimationImage.height
                width:spriteAnimationImage.width/framesCount

                Image{
                    id:spriteAnimationImage
                    source:"assets/images/animations/walking.png"
                    y:0
                    smooth: true
                    x:-spriteAnimation.width*spriteAnimation.currentFrame-6
                }
            }

            Item{
                height: 32
                width: pageGameOver.width / 2
                anchors.horizontalCenter: parent.horizontalCenter

                Row{
                    id: bonusRow
                    width: parent.width * 0.3
                    spacing: 4
                    z: 10
                    visible: bonus > 0

                    Image{
                        id: bonusIcon
                        source: "assets/images/extras/apple.png"
                        width: 24
                        height: 24
                        anchors.verticalCenter: parent.verticalCenter

                        Behavior on source{
                            PropertyAnimation { target: bonusIcon; duration: gameOverTimer.interval / 2}
                        }
                    }

                    Text{
                        id: bonusText
                        text: bonus
                        font{ pointSize: 24; bold: true; family: canvas.localFont.name }
                        color: "blue"
                        anchors.verticalCenter: parent.verticalCenter

                        Behavior on text {
                            SequentialAnimation{
                                NumberAnimation { target: bonusText; property: "font.pointSize"; to: 28; duration: gameOverTimer.interval * 0.5 }
                                PropertyAnimation { target: bonusIcon; property: "source"; to: "assets/images/extras/apple.png"; duration: gameOverTimer.interval * 0.1 }
                                NumberAnimation { target: bonusText; property: "font.pointSize"; to: 24; duration: gameOverTimer.interval * 0.4 }
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
                        font { pointSize: 24; family: canvas.localFont.name; bold: true }
                        color: "blue"
                    }

                    Text{
                        id: scoreText
                        text: pageGameOver.score
                        font{pointSize: 24;  family: canvas.localFont.name; bold: true }
                        color: "blue"

                        Behavior on text {
                             SequentialAnimation {
                                 NumberAnimation { target: scoreText; property: "font.pointSize"; to: 28; duration: gameOverTimer.interval / 2 }
                                 NumberAnimation { target: scoreText; property: "font.pointSize"; to: 24; duration: gameOverTimer.interval / 2 }
                             }
                         }
                    }

                    Text{
                        text: 'm'
                        font{pointSize: 24; family: canvas.localFont.name; bold: true }
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
                        enabled: bonus>0?false:true

                        onClicked: { pageMain.audioController.stopGameOverMusic(); pageMain.audioController.playTapSoundEffect(); pageStack.pop() }
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
                        enabled: bonus>0?false:true

                        onClicked: { pageMain.audioController.playTapSoundEffect(); pageGameOver.state = 'popup' }
                    }
                }
            }

            Text {
                id: text3
                x: 308
                color: "#222222"
                text: qsTr("Please dont'forget to rate the game in Nokia store!<br/>Also, visit the link below to check for new releases!")
                font{ family: canvas.localFont.name; pointSize: 17 }
                styleColor: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter

                onLinkActivated: Qt.openUrlExternally(link);
            }

            Row{
                spacing: 6
                anchors.horizontalCenter: parent.horizontalCenter
                height: 70
                width: nokiaStore.width + nokiaStoreText.width + 20
                Image{
                    id: nokiaStoreText
                    source: "assets/images/menu/game_over/nokia_store_title.png"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Image{
                    id: nokiaStore
                    source: "assets/images/menu/game_over/app_store.png"
                }

                MouseArea{
                    anchors.fill: parent

                    onClicked: Qt.openUrlExternally('http://store.ovi.com/publisher/ideal apps/')
                }
            }
        }
    }


    PopUp{
        id: popup
        width: pageGameOver.width/2
        height: pageGameOver.height/2
        anchors.centerIn: parent
        visible: false
        opacity: 0.0
        z: 100
        onNameChanged: popup.nameChanged(name)
        onBack: pageGameOver.state = ''
    }

    states:[
        State{
            name: "popup"

            PropertyChanges { target: popup; visible: true; opacity: 1.0 }
            PropertyChanges { target: pageGameOver; opacity: 0.7 }
        }
    ]

    transitions: [
        Transition {

            NumberAnimation{ target: popup; properties: "opacity" }
        }
    ]

    Component.onCompleted: ScoreEngine.loadDatabase();
}