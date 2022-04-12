// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Extras {
    id: specialEffectSrink
    width: 33
    height: 38

    extrasType: 8

    source: "../images/extras/srink.png"

    property int indexTarget: -1

    Image{
        id: stickImage
        source: specialEffectSrink.source
        anchors.fill: specialEffectSrink

        SequentialAnimation on scale{
            running: true
            loops: Animation.Infinite
            NumberAnimation{ from: 1.0; to: 1.1}
            NumberAnimation{ from: 1.1; to: 1.1 }
        }
    }
}
