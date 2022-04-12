// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {

    property string text: "NOT SET"

    width: 100
    height: 62

    border.color: "grey"
    radius: 5

    Text{
        text: text
        font.pointSize: 11
        anchors.centerIn: parent
    }
}
