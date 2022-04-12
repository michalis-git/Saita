// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "obstacles"

Item {

    function inActivateVisibleObstacles(){

    }

    function activateVisibleObstacles(){

    }

    MovingCeilingLight_Big{
        id: obstacle1
        x:360
        parent: worldClassroom
    }

    BasketBallComponent{
        id: obstacle2
        x:900
        y:worldClassroom.ceilingWallHeight+112
        parent: worldClassroom
        bRestitution: 0.98
    }

    BasketBallComponent{
        id: obstacle3
        x:obstacle2.x+165
        y:worldClassroom.ceilingWallHeight+90
        parent: worldClassroom
        bRestitution: 0.97
    }

    BasketBallComponent{
        id: obstacle4
        x:obstacle3.x+165
        y:worldClassroom.ceilingWallHeight+75
        parent: worldClassroom
        bRestitution: 0.99
    }

    ResizableCeilingLight{
        id: obstacle5
        x: 1612
        parent: worldClassroom
        modeType: "dynamic"
        timerInterval: 220
    }

    ResizableCeilingLight{
        id: obstacle6
        x: 2324
        parent: worldClassroom
        modeType: "dynamic"
        timerInterval: 250
    }

    BeanComponent{
        id: obstacle7
        x:1912
        parent: worldClassroom
    }
}
