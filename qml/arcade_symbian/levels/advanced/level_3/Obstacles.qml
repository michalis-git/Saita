// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "obstacles"

Item {

    function cutFirstCeilingLight(){
        scissorAnimation.x = obstacle2.x + obstacle2.width/2 - obstacle2.cableWidth
        scissorAnimation.y = worldClassroom.ceilingWallHeight+ 4

        scissorAnimation.show()
    }

    function cutSecondCeilingLight(){
        scissorAnimation2.x = obstacle5.x + obstacle5.width/2 - obstacle5.cableWidth
        scissorAnimation2.y = worldClassroom.ceilingWallHeight+ 4

        scissorAnimation2.show()
    }

    //
    // this is the scissors animation
    //
    ScissorAnimation{
        id: scissorAnimation
        parent: worldClassroom
    }

    //
    // this is the scissors animation
    //
    ScissorAnimation{
        id: scissorAnimation2
        parent: worldClassroom
    }

    Connections{
        target: scissorAnimation
        onFinished: obstacle2.state = 'fall'
    }

    Connections{
        target: scissorAnimation2
        onFinished: obstacle5.state = 'fall'
    }

    CustomCeilingLight{
        id: obstacle1
        x: 375
        cableHeight: 112
        parent: worldClassroom
    }

    FallingCeilingLight{
        id: obstacle2
        x:937
        parent: worldClassroom
    }

    BigDeckComponent{
        id: obstacle3
        x: 1349
        parent: worldClassroom
    }

    CustomCeilingLight{
        id: obstacle4
        x: 1499
        parent: worldClassroom
        cableHeight: 150
    }

    FallingCeilingLight{
        id: obstacle5
        x:2099
        parent: worldClassroom
        cableHeight: 150
    }
}
