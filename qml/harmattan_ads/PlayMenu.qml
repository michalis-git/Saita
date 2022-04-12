// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    id: optionsMenu

    signal difficultyChanged(int level)
    signal backClicked()

    Column{
        spacing: 6
        anchors.centerIn: parent

        Row{
            spacing: 20

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: easytitle
                    source: "assets/images/menu/button/easy.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: easyIcon
                    source: easyArea.pressed? "assets/images/menu/button/icon_easy_pressed.png": "assets/images/menu/button/icon_easy.png"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: easyIconShadow
                        anchors.rightMargin: 2
                        anchors.leftMargin: 0
                        anchors.topMargin: 2
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: parent
                        visible: !easyArea.pressed
                    }
                }

                MouseArea
                {
                    id: easyArea
                    anchors.fill: parent
                    onClicked: difficultyChanged(0)
                }
            }

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: mediumtitle
                    source: "assets/images/menu/button/medium.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: mediumIcon
                    source: mediumArea.pressed? "assets/images/menu/button/icon_medium_pressed.png": "assets/images/menu/button/icon_medium.png"
                    anchors.horizontalCenter: parent.horizontalCenter


                    Image {
                        id: mediumIconShadow
                        anchors.rightMargin: 2
                        anchors.topMargin: 2
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: parent
                        visible: !mediumArea.pressed
                    }
                }

                MouseArea
                {
                    id: mediumArea
                    anchors.fill: parent
                    onClicked: difficultyChanged(1)
                }
            }
        }

        Row{
            spacing: 20

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: experttitle
                    source: "assets/images/menu/button/expert.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: expertIcon
                    source: expertArea.pressed? "assets/images/menu/button/icon_expert_pressed.png": "assets/images/menu/button/icon_expert.png"
                    anchors.horizontalCenter: parent.horizontalCenter


                    Image {
                        id: expertIconShadow
                        anchors.rightMargin: 2
                        anchors.topMargin: 2
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: parent
                        visible: !expertArea.pressed
                    }
                }

                MouseArea
                {
                    id: expertArea
                    anchors.fill: parent
                    onClicked: difficultyChanged(2)
                }
            }

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: backtitle
                    source: "assets/images/menu/button/back_title.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: backIcon
                    source: backArea.pressed? "assets/images/menu/button/back_pressed.png": "assets/images/menu/button/back.png"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: backIconShadow
                        anchors.rightMargin: 3
                        anchors.topMargin: 3
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: parent
                        visible: !backArea.pressed
                    }
                }

                MouseArea
                {
                    id: backArea
                    anchors.fill: parent
                    onClicked: backClicked()
                }
            }
        }
    }
}
