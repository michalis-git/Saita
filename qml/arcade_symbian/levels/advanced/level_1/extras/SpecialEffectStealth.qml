// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Extras {
    id: specialEffectStealth
    width: 36
    height: 42

    extrasType: 1

    source: "../images/extras/bell.png"

    seconds: 3.0

    Image{
        id: image
        source: specialEffectStealth.source
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit

        SequentialAnimation on rotation {
            loops: Animation.Infinite
            RotationAnimation{ duration: 250; from: 0; to: 25; }
            RotationAnimation{ duration: 500; from: 25; to: -25 }
            RotationAnimation{ duration: 250; from: -25; to: 0 }
        }
    }
}
