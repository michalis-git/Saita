// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Box2D 1.0

Body{
    id: bodyItem
    width: 35
    height: 34

    bodyType: Body.Kinematic
    sleepingAllowed: true

    property bool active: true
    property int indexNo: 1

    property int extrasType: 2

    property string source: "NOT SET"

    property double seconds: 3.0
}
