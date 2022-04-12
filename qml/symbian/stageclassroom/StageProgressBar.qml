// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: stageProgressBar
    property real value: 0

    property bool active: false

    width: 100
    height: 6

    color: "transparent"
    border.color: "grey"
    border.width: 2
    radius: 6

    function reset(){
        value = Math.floor(stageProgressBar.width);
    }

    function stop(){
        active = false;
    }

    Text{
        id: pointerText
        font{ pointSize: 5; bold: true; family: canvas.localFont.name }
        text: Math.round((value/stageProgressBar.width)*100).toString() + "%"
        anchors.left: pointerImage.right
        anchors.leftMargin: 2
        anchors.verticalCenter: pointerImage.verticalCenter
        anchors.verticalCenterOffset: 1
    }

    Image{
        id: pointerImage
        anchors.top: parent.bottom
        anchors.topMargin: 3
        x: value - width/2
        source: "images/other/downarrow.png"
    }

    Rectangle{
        id: resizableFrame
        width: Math.floor(value)
        height: stageProgressBar.height
        anchors.left: parent.left
        color: value < stageProgressBar.width*0.666667? "green": "orange"
        radius: 6
    }
}
