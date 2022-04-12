// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    width: 100
    height: 62

    signal backClicked()

    XmlListModel{
        id: classesModel
        source: "assets/levels/classes.xml"

        query: "/classes/class"

        XmlRole{ name: "name"; query: "@name/string()" }
        XmlRole{ name: "description"; query: "@description/string()" }
        XmlRole{ name: "lockedstate"; query: "@lockedstate/string()" }
        XmlRole{ name: "levelcount"; query: "@levelcount/string()" }
        XmlRole{ name: "badges"; query: "@badges/string()" }
        XmlRole{ name: "filename"; query: "@filename/string()" }
    }

    Connections{
        target: XmlUtility
        onBadgesChanged: { console.log('badges changed ..'); classesModel.reload() }
    }

    Component{
        id: delegateComponent

        Rectangle{
            radius: 160
            color: "transparent"
            border.color: "lightgrey"

            width: ListView.view.width - (ListView.view.width/20)
            height: width * 0.66667

            opacity: ListView.isCurrentItem? 1.0: 0.3
            anchors.verticalCenter: parent.verticalCenter

            Column{
                anchors.centerIn: parent
                spacing: 10

                Text {
                    text: name
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 18
                    font.family: arcadeCanvas.localFont.name
                    font.bold: true
                    color: "white"
                }

                Text {
                    text: description
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 22
                    font.bold: true
                    font.family: arcadeCanvas.localFont.name
                    color: "white"
                }

                Row{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Image {
                        source: "assets/images/menu/button/scores.png"
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 32
                    }

                    Text{
                        anchors.verticalCenter: parent.verticalCenter
                        text: badges + ' / ' + levelcount
                        font { pointSize: 18; family: arcadeCanvas.localFont.name }
                        color: "lightgrey"
                    }
                }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: { if(classesView.currentIndex == index) { setupPath(filename); } else { classesView.currentIndex = index; } }
            }
        }
    }

    ListView{
        id: classesView
        width: parent.height * 0.8
        height: width
        anchors.centerIn: parent
        z: 200
        model: classesModel
        delegate: delegateComponent
        orientation: ListView.Horizontal
        spacing: 6

        Component.onCompleted: currentIndex = 0
    }
}
