// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: stageTapAnimation
    width: 64
    height: 64
    color: "transparent"
    radius: 45
    border.width: 1
    border.color: "#8d8d8d"
    opacity: 0.0

    function start(){
        state = ''
        state = 'show'
    }

    states:[
        State{
            name: "show"

            PropertyChanges{ target: stageTapAnimation; scale: 2.0; opacity: 0.0 }
        }
    ]

    transitions: [
        Transition{
            to: "show"

            SequentialAnimation{
                ScriptAction{script: opacity = 1.0 }
                NumberAnimation{ duration: 200; properties: "scale"; easing.type: Easing.OutInQuad }
                NumberAnimation{ duration: 50; properties: "opacity"; easing.type: Easing.OutQuad}
                ScriptAction{script: { scale = 1} }
            }
        }

    ]
}
