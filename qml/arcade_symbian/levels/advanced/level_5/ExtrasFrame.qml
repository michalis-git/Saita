// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "extras"

Item {

    Bonus{
        id: bonus1
        x: specialEffect1.x+75
        y: specialEffect1.y + 75
        parent: worldClassroom
        indexNo: 1
    }

    Bonus{
        id: bonus2
        x: 1248
        y: worldClassroom.height-worldClassroom.floorWallHeight-bonus2.height
        parent: worldClassroom
        indexNo: 2
    }

    Bonus{
        id: bonus3
        x: 1912
        y:45
        parent: worldClassroom
        indexNo: 3
    }

    PenaltyEffectNight{
        id: specialEffect1
        x: 457
        anchors.verticalCenter: worldClassroom.verticalCenter
        anchors.verticalCenterOffset: 30
        parent: worldClassroom
        indexNo: 4
    }

    Component.onCompleted: {
        appendToExtrasArray(bonus1);
        appendToExtrasArray(bonus2);
        appendToExtrasArray(bonus3);
        appendToExtrasArray(specialEffect1);
    }
}
