import QtQuick 1.1
import com.nokia.symbian 1.1

Item {

    id: scoreBoard

    property int score: 0
    property int level: 1

    height: levelText.height + 12 + scoreText.height + progress.height + foundText.height

    property string fontFamily:  "Courier"
    property real fontPointSize: parent.height*0.025

    Behavior on score { NumberAnimation { duration: 500 } }

    property int foundIndex: 0

    property int wordSize: 1

    Column {
        anchors.centerIn: parent
        spacing: 4

        Text {
                id: levelText
                text: "Level: " + scoreBoard.level
                color: "white"
                font.family: scoreBoard.fontFamily
                font.pointSize: 8
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
        }

        Text {
                id: scoreText
                text: "Score: " + scoreBoard.score
                color: "white"
                font.family: scoreBoard.fontFamily
                font.pointSize: 8
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
        }

        Text{
            id: foundText
            text: "Found " + foundIndex + "/" + wordSize
            color: "white"
            font.family: scoreBoard.fontFamily
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 8
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }

        ProgressBar {
                 id: progress
                 width: scoreBoard.width - 8
                 height: 12
                 value: wordSearchGame.maxSeconds - wordSearchGame.seconds;
                 maximumValue: wordSearchGame.maxSeconds
        }
    }
}
