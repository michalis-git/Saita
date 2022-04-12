/****************************************************************************
**
** This file is part of Glinder adventures
**
** Copyright (c) 2011 Nikolaos Gerontidis.*
** All rights reserved.
** Contact:  Nikolaos Gerontidis (n.gerontidis@idealapps.gr)
**
** You may use this file under the terms of the license as follows:
**
** "Redistribution in source and binary forms, with or without
** modification, are prohibitted without prior written permission by
** Nikolaos Gerontidis.
**
****************************************************************************/

import QtQuick 1.1
import Box2D 1.0

Body {
    id: bodyItem
    width: 65
    height: cableHeight + 75
    y: worldClassroom.ceilingWallHeight

    property string image: "../images/obstacles/ceiling_light_medium.png"
    property int cableHeight: 90
    property int cableWidth: 4

    property string modeType: "not set"

    property int timerInterval: 200

    property bool timerRunning: false

    bodyType: modeType === "static"? Body.Static: Body.Dynamic

    sleepingAllowed: true

    function updateFixtures(){

        bodyItem.resetItem();
    }

    fixtures: [

        Box{
            id: cableFixture
            width: cableWidth
            height: cableHeight
            anchors.top: bodyItem.top
            anchors.horizontalCenter: bodyItem.horizontalCenter
        },
        Polygon {
            id: lampFixture
            vertices: [
                Qt.point(24,cableHeight),
                Qt.point(3,cableHeight+69),
                Qt.point(62,cableHeight+70),
                Qt.point(40,cableHeight)
            ];
        }
    ]

    Image{
        id: rodImage
        width: cableWidth
        height: cableHeight + 15
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: parent.top
        anchors.topMargin: -4
        source: "../images/obstacles/stick.png"
        z:1
    }

    Image {
        id: lampImageItem
        y:cableHeight
        width: bodyItem.width
        height: 75
        source: "../images/obstacles/lamb.png"
    }

    Timer{
        id: resizeTimer
        running: worldClassroom.running && timerRunning
        interval: timerInterval
        repeat: true

        onTriggered: { if(bodyItem.height < (worldClassroom.height - (2*worldClassroom.ceilingWallHeight))){ cableHeight += 1; updateFixtures() } }
    }

    RevoluteJoint {
        id: revolute
        maxMotorTorque: 10
        motorSpeed: 0
        bodyA: ceiling
        bodyB: bodyItem
        world: worldClassroom
        collideConnected: false
    }

    states:[
        State{
            name: "inActive"

            PropertyChanges{ target: bodyItem; active: false }
            PropertyChanges{ target: imageItem; opacity: 0.4 }
        }
    ]

    transitions: [
        Transition {
            reversible: true;
            NumberAnimation{ target: imageItem; properties: "opacity"; duration: 200 }
        }
    ]
}
