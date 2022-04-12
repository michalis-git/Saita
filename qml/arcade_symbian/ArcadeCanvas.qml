// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: arcadeCanvas

    orientationLock: PageOrientation.LockLandscape

    property int message: 2

    property alias localFont: localFont

    signal backClicked()

    property string levelNo: '0'

    function getMainPage(){
        return pageStack.find(function(page){
                           return page.message == "1";
                       });
    }

    function playTapSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playTapSoundEffect();
    }

    width: 640
    height: 360

    ArcadeMenu{
        id: arcadeMenu
        anchors.fill: parent
    }

    FontLoader { id: localFont; source: "assets/fonts/Stylus_BT.ttf" }
}
