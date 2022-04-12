// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    id: bonusPanel
    width: 75
    height: 47

    property string bonusText: 'x0'

    Row{
        id: bonusRow
        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
        spacing: 6
        z: 10

        Image{
            source: "images/extras/apple.png"
            width: 16
            height: 16
            anchors.verticalCenter: parent.verticalCenter
        }

        Text{
            text: bonusText
            font{pointSize: 9; family: canvas.localFont.name; bold: true }
            color: "blue"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Image{
        id: finishImage
        source: "images/extras/apple.png"
        opacity: 0.0
        anchors.top: parent.bottom
        anchors.topMargin: 10
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    states:[
        State{
            name: "finish"

//            StateChangeScript{ name:  "finishScript"; script: classroom.score += (bonusCounter*10); }
            PropertyChanges { target: finishImage; opacity: 1.0; visible: false }
        }
    ]

    transitions: [
        Transition {
            SequentialAnimation{
                ParallelAnimation{
                    NumberAnimation{ target: finishImage; properties: "opacity"; duration: 200}
                    NumberAnimation{ target: finishImage; properties: "width"; to: 200; duration: 200 }
                }
                ScriptAction{ script: "finishScript" }
            }
        }
    ]
}
