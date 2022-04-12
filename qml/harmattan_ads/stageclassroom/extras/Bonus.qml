// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Extras {
    width: 47
    height: 45

    extrasType: 11

    fillMode: Image.PreserveAspectFit

    property string imagepath: "../images/extras/apple.png"
    property string imagepathsqueezed: "../images/extras/apple_squeezed.png"

    SequentialAnimation on source{
        running: true
        loops: Animation.Infinite
        PropertyAnimation{ from: imagepath; to: imagepathsqueezed }
        PropertyAnimation{ from: imagepathsqueezed; to: imagepath }
    }
}
