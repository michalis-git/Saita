// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    id: startText

    property string imagehelp1: "assets/images/start_help/start_text_1.png"
    property string imagehelp2: "assets/images/start_help/start_text_2.png"

    Behavior on opacity{
        NumberAnimation{ duration: 500 }
    }

    Image{
        id: startImage1
        fillMode: Image.PreserveAspectFit
        source: imagehelp1

        SequentialAnimation on source{
            running: true
            loops: Animation.Infinite
            PropertyAnimation{ from: imagehelp1; to: imagehelp2 }
            PropertyAnimation{ from: imagehelp2; to: imagehelp1 }
        }
    }
}
