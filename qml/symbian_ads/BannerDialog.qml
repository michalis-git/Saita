import QtQuick 1.1
import "inneractive"

Rectangle {
    id: bannerDialog
    width: 400
    height: 220
    color: "#f4eef7"
    border.color: "#5b2477"
    border.width: 2
    radius: 10
    visible: wonTimer.running

    property bool exitMode: false

    property int seconds: 0

    signal errorReturned(string error)
    signal modelReady()

    function reload(){
        bannerFrame.reload()
    }

    Timer{ id: wonTimer; interval: 1000; running: bannerDialog.seconds < 0? false: true; repeat: true; onTriggered: { if(seconds == 0 && exitMode){ Qt.quit()} bannerDialog.seconds = bannerDialog.seconds - 1 } }

    Column{
        spacing: 10
        anchors.centerIn: parent

        Text{
            id: helperText
            text: "We were able to provide you a full free version of the game<br/>thanks to our sponsors,please support us by taping on the banner"
            width: bannerDialog.width
            color: "#292929"
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter

            font.pointSize: 7
        }

//        BannerFrame{ id: bannerFrame; anchors.horizontalCenter: parent.horizontalCenter }
        AdItem {
            id: adItem
            parameters: AdParameters {
            applicationId: "POLYHEDRON_SaitaSchool_OVI"
            }
            retryOnError: true
            reloadInterval: 100
            anchors.horizontalCenter: parent.horizontalCenter
            z:200
        }

        Text{ x: adItem.x + 30 ; color: "#292929"; text: "Auto skip in " + seconds  + ' seconds'; font.pointSize: 7; anchors.horizontalCenter: parent.horizontalCenter }
    }
}
