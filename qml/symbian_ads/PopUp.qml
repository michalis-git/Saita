import QtQuick 1.1
import QtMobility.systeminfo 1.2

Item {
    id: popup

    property int posX: 0
    property int posY: 0

    property int score: 0

    property string fontName: "Helvetica"
    property int fontSize: 10
    property color fontColor: "black"
    property bool animationRunning: false
    property string name: textinput.text

    signal back()

    anchors.fill: parent

    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    DeviceInfo{
        id: deviceInfo
    }

    Column{
        id: column
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6
        z: 100

        Text{
            font.pointSize: 6
            font.family: canvas.localFont.name
            text: qsTr("Please enter your name below")
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
        }

        Rectangle{
            color: "white"
            width: 150
            height: 60
            radius: 5
            anchors.horizontalCenter: parent.horizontalCenter

            TextInput{
                id: textinput
                anchors.fill: parent
                anchors.topMargin: parent.height/2 - 12
                font.pointSize: 9

                Keys.onReturnPressed: {
                    textinput.closeSoftwareInputPanel();
                }
                Keys.onEnterPressed: {
                    textinput.closeSoftwareInputPanel();
                }

                Keys.onYesPressed: {
                    textinput.closeSoftwareInputPanel();
                }
            }
        }

        Row{
            spacing: 10

            anchors.horizontalCenter: parent.horizontalCenter

            Item{
                width: 65
                height: 65

                Image{
                    anchors.centerIn: parent
                    source: "assets/images/menu/button/back.png"

                    Image{
                        anchors.rightMargin: 3
                        anchors.topMargin: 3
                        anchors.fill: parent
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        visible: !backArea.pressed
                    }
                }

                MouseArea{
                    id: backArea
                    anchors.fill: parent
                    onClicked: {
                        pageMain.audioController.playTapSoundEffect();
                        textinput.closeSoftwareInputPanel();
                        textinput.text = '';
                        popup.animationRunning = false;
                        popup.back()
                    }
                }
            }

            Item{
                width: 65
                height: 65

                Image{
                    anchors.centerIn: parent
                    source: saveArea.pressed? "assets/images/buttons/save_buuton_pressed.png" : "assets/images/buttons/save_button.png"

                    Image{
                        anchors.rightMargin: 3
                        anchors.topMargin: 3
                        anchors.fill: parent
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        visible: !saveArea.pressed
                    }
                }

                MouseArea{
                    id: saveArea
                    anchors.fill: parent
                    onClicked: {
                        pageMain.audioController.playTapSoundEffect();
                        textinput.closeSoftwareInputPanel()
                        ScoresUtility.saveScore(deviceInfo.uniqueDeviceID,textinput.text,popup.score,pageMain.difficultyLevel);
                        popup.animationRunning = true;
                    }
                }
            }
        }
    }

    BusyAnimation{
        width: 48
        height: 48
        z:100
        animationRunning: popup.animationRunning
        anchors.centerIn: parent
        visible: popup.animationRunning
    }

    Rectangle{
        id: mainRect
        color: "black"
        border.color: "white"
        radius: 4
        anchors.fill: parent
        z:4
    }
}
