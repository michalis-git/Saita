// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "extras"

Item {

    Bonus{
        id: bonus1
        x: 787
        y: 277
        parent: worldClassroom
        indexNo: 1
    }

    Bonus{
        id: bonus2
        x: 1274
        y: 277
        parent: worldClassroom
        indexNo: 2
    }

    Bonus{
        id: bonus3
        x: 2024
        y:foreground.worldClassroom.ceilingWallHeight + 30
        parent: worldClassroom
        indexNo: 3
    }

    SpecialEffectStealth{
        id: specialEffect1
        x: 472
        y:285
        parent: worldClassroom
        indexNo: 4
        seconds: 2.5
    }

    SpecialEffectStealth{
        id: specialEffect2
        x: 1536
        y:foreground.worldClassroom.ceilingWallHeight + 7.5
        parent: worldClassroom
        indexNo: 5
    }

    Component.onCompleted: {
        appendToExtrasArray(bonus1);
        appendToExtrasArray(bonus2);
        appendToExtrasArray(bonus3);
        appendToExtrasArray(specialEffect1);
        appendToExtrasArray(specialEffect2);
    }
}
