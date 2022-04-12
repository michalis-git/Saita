// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Extras {
    id: penaltyEffectNight
    width: 27
    height: 46

    property string imagepath: "../images/extras/bulb.png"
    property string imagepathsqueezed: "../images/extras/bulb_squeezed.png"

    extrasType: 21

    fillMode: Image.PreserveAspectFit

    Image{
        id:lightImage
        source:"../images/extras/light.png"
        x:9
        y:7
        z: penaltyEffectNight.z-1

        SequentialAnimation on opacity{
            running: true
            loops: Animation.Infinite
            NumberAnimation{ from: 60; to: 20 }
            NumberAnimation{ from: 20; to: 60 }
        }
    }

    SequentialAnimation on source{
        running: true
        loops: Animation.Infinite
        PropertyAnimation{ from: imagepath; to: imagepathsqueezed }
        PropertyAnimation{ from: imagepathsqueezed; to: imagepath }
    }
}
