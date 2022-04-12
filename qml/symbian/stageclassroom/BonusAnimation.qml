// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    id: bonusAnimation
    width: 35
    height: 34
    source: bonusEaten
    opacity: 0.0;

    property string bonusEaten: "images/extras/apple_bitten.png"

    property int animationDuration: 600

    function show(){
        pageMain.audioController.playAppendBonusItemSoundEffect();

        bonusAnimation.state = 'show'

        timer.restart();
    }

    Timer{
        id: timer
        interval: animationDuration
        running: false
        onTriggered: {
            // append a list element to the bonus model
            bonusCounter++;
            bonusAnimation.state = ''
        }
    }

    states:[
        State{
            name: "show"

            PropertyChanges{ target: bonusAnimation; opacity: 1.0; width:16; height:16; x: bonusPanel.x+bonusPanel.width/2; y: bonusPanel.y+bonusPanel.height }
        }
    ]

    transitions: [
        Transition {
            SequentialAnimation{
                NumberAnimation{ target: bonusAnimation; properties: "x,y,width,height"; duration: animationDuration }
            }
        }
    ]
}
