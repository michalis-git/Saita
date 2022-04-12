import QtQuick 1.1
import Box2D 1.0

Body {
    id: enemySaita

    property int bottomBorder: worldClassroom.height - worldClassroom.floorWallHeight - height - 1

    property int force: -16

    fixedRotation: true
    width: 48
    height: 45
    z:4
    parent: worldClassroom

    onYChanged: { if(y > bottomBorder && linearVelocity.y > 0) { applyImpulse(); enemySaita.rotateSaita() } }

    function rotateSaita(){
        enemySaita.rotation = 10

        rotateTimer.restart()
    }

    function applyImpulse(){
        enemySaita.applyLinearImpulse(Qt.point(0,force),Qt.point(enemySaita.x + enemySaita.width/2,enemySaita.y+enemySaita.height/2)); enemySaita.rotateSaita()
    }

    Timer{
        id: destroyTimer
        repeat: true
        running: false
        interval: 800

        onTriggered: { enemySaita.destroy() }
    }

    Timer{
        id: rotateTimer
        interval: 600
        running: false
        onTriggered: enemySaita.rotation = 0

    }

    fixtures: [
        Polygon {
            density: 0.2
            friction: 0.8
            restitution: 0.1
            vertices: [
                Qt.point(5,2),
                Qt.point(20,44),
                Qt.point(47,26)
            ]

            onBeginContact: { /*forceTimer.stop(); */enemySaita.state = 'inActive' }
        },
        Polygon {
            density: 0.2
            friction: 0.8
            restitution: 0.1
            vertices: [
                Qt.point(11,19),
                Qt.point(2,41),
                Qt.point(17,38)
            ]

            onBeginContact: { /*forceTimer.stop(); */enemySaita.state = 'inActive' }
        }
    ]

    Image {
        id:saitaImage
        source: "../images/saita/saita_fliped.png"
        smooth: true
        anchors.fill: parent
        z:200
    }

    states:[
        State{
            name: 'inActive'

            StateChangeScript{ name: "destroyScript"; script: destroyTimer.start() }
            PropertyChanges{ target: enemySaita; active: false; opacity: 0.0 }
        }
    ]

    transitions: [
        Transition {
            to: "inActive"

            NumberAnimation{ duration: 800; property: "opacity" }
        }
    ]
}
