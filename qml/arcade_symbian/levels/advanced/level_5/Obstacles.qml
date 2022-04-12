// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "obstacles"

Item {

    function inActivateVisibleObstacles(){

    }

    function activateVisibleObstacles(){

    }

    CustomCeilingLight{
        id: obstacle1
        x:360
        cableHeight: 15
        parent: worldClassroom
    }

    SmallChairComponent{
        id: obstacle2
        anchors.horizontalCenter: obstacle1.horizontalCenter
        parent: worldClassroom
    }

    BasketBallComponent{
        id: obstacle3
        x:1012
        y:worldClassroom.ceilingWallHeight+75
        parent: worldClassroom
        bRestitution: 0.98
        initialLinearVelocity: Qt.point(-67,-30)
    }

    BasketBallComponent{
        id: obstacle4
        x:obstacle3.x+187
        y:worldClassroom.ceilingWallHeight+37
        parent: worldClassroom
        bRestitution: 0.97
        initialLinearVelocity: Qt.point(-60,-15)
    }

    BasketBallComponent{
        id: obstacle5
        x:obstacle4.x+450
        y:worldClassroom.height/2
        parent: worldClassroom
        bRestitution: 0.99
        initialLinearVelocity: Qt.point(-60,-150)
    }

    BasketBallComponent{
        id: obstacle6
        x:obstacle5.x+112
        y:worldClassroom.height/2
        parent: worldClassroom
        bRestitution: 0.99
        initialLinearVelocity: Qt.point(-60,-150)
    }

    BasketBallComponent{
        id: obstacle7
        x:obstacle6.x+112
        y:worldClassroom.height/2
        parent: worldClassroom
        bRestitution: 0.99
        initialLinearVelocity: Qt.point(-60,-150)
    }

    BasketBallComponent{
        id: obstacle8
        x:obstacle7.x+112
        y:worldClassroom.height/2
        parent: worldClassroom
        bRestitution: 0.99
        initialLinearVelocity: Qt.point(-60,-150)
    }

    BasketBallComponent{
        id: obstacle9
        x:obstacle8.x+225
        y:worldClassroom.height/4
        parent: worldClassroom
        bRestitution: 0.99
        initialLinearVelocity: Qt.point(-67,-22)
    }

    BasketBallComponent{
        id: obstacle10
        x:obstacle9.x+75
        y:worldClassroom.height/3
        parent: worldClassroom
        bRestitution: 0.99
        initialLinearVelocity: Qt.point(-37,-22)
    }

    ResizableCeilingLight{
        id: obstacle12
        x: worldClassroom.width - 640 / 2.5
        parent: worldClassroom
        timerInterval: 270
    }
}
