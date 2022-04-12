// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
//import QtMultimediaKit 1.1
//import GEAudio 1.0

Item {
    id: winMenu
    width: 275
    height: 164

    property int currentLevel: 0

    property int bonusItems: 0

    signal restart()
    signal backToMenu()
    signal nameChanged(string name);
    signal nextLevel();

    function start(){
        playWinMusic();

        for(var j = 0; j < appleModel.count; j++)
            appleModel.get(j).path = "assets/images/extras/apple_bitten.png"

        for(var i = 0; i < bonusItems; i++){
            appleModel.get(i).path = "assets/images/extras/apple.png"
        }

        XmlUtility.setApplesValue(levelView.getCurrentPath(),currentLevel,bonusItems);

        XmlUtility.setLevelState(levelView.getCurrentPath(),currentLevel,0);

        console.log('finished win menu setup')
    }

    ListModel{
        id: appleModel
        ListElement{ no: "0"; fill: false; path: "assets/images/extras/apple_bitten.png" }
        ListElement{ no: "1"; fill: false; path: "assets/images/extras/apple_bitten.png" }
        ListElement{ no: "2"; fill: false; path: "assets/images/extras/apple_bitten.png" }
    }

    Image{
        id:backgroundWinMenu
        source: "assets/images/menu/lost_menu/lost_menu_wall.png"
        anchors.fill: parent
        opacity: 0.90
    }


    Column{
        anchors.centerIn: parent
        spacing: 20

        ListView{
            id: listView
            width: 80
            height: 24
            model:appleModel
            spacing: 4
            anchors.horizontalCenter: parent.horizontalCenter
            interactive: false
            orientation: ListView.Horizontal
            delegate: Image {
                source: path
                width: 24
                height: 24
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

                    onClicked: { stopWinMusic(); playTapSoundEffect(); winMenu.restart() }
                }
            }

            Item{
                width: 80
                height: 80
                z:300

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

                    onClicked: { stopWinMusic(); playTapSoundEffect(); winMenu.backToMenu() }
                }
            }

            Item{
                width: 80
                height: 80
                z:300

                Image{
                    source: nextLevelArea.pressed? "assets/images/buttons/next_level.png": "assets/images/buttons/next_level.png"
                    anchors.centerIn: parent

                    Image {
                        id: nextLevelIconShadow
                        anchors.rightMargin: 3
                        anchors.topMargin: 3
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: parent
                        visible: !backToMenuArea.pressed
                    }
                }

                MouseArea{
                    id: nextLevelArea
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    anchors.fill: parent

                    onClicked: { stopWinMusic(); playTapSoundEffect(); nextLevel() }
                }
            }
        }

        Image{
            source: "assets/images/menu/lost_menu/you_lost.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
