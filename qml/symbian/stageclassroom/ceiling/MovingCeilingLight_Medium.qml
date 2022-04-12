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

Item{
    id: bodyItem

    property string image: "../images/obstacles/ceiling_light_moving_medium.png"

    width: 105
    height: 143
    y: 0

    Body {
        id: rod
        fixedRotation: false
        sleepingAllowed: false
        parent: worldClassroom

        x: bodyItem.x
        y: worldClassroom.ceilingWallHeight

        width: bodyItem.width
        height: bodyItem.height

        fixtures: [
            Polygon {
                id: cord
                density: 0.1;
                friction: 1;
                restitution: 0.3;

                vertices: [
                    Qt.point(0,2),
                    Qt.point(45,79),
                    Qt.point(48,77),
                    Qt.point(2,0)
                ]
            },
            Polygon {
                id: lamp
                density: 0.3;
                friction: 1;
                restitution: 0.3;

                vertices: [
                    Qt.point(40,83),
                    Qt.point(50,140),
                    Qt.point(101,110),
                    Qt.point(54,74)
                ]
            }
        ]

        Image {
            id: rodImage
            source: bodyItem.image
            width: parent.width
            height: parent.height
            anchors.top: parent.top
            anchors.topMargin: -4
        }
    }

    Body {
        id: middle
        fixedRotation: true
        sleepingAllowed: false
        bodyType: Body.Static
        parent: worldClassroom

        width: 15
        height: 15

        x: rod.x
        y: rod.y

        fixtures: Circle {
            id: circleShape
            radius: middle.width / 2
            anchors.fill: parent
        }
    }

    RevoluteJoint {
        id: revolute
        maxMotorTorque: 10
        motorSpeed: 0
        bodyA: middle
        bodyB: rod
        world: worldClassroom
    }

    states:[
        State{
            name: "inActive"

            PropertyChanges{ target: rod; active: false }
            PropertyChanges{ target: rodImage; opacity: 0.4 }
            PropertyChanges{ target: middle; active: false }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation{ target: rodImage; properties: "opacity"; duration: 200 }
        }
    ]
}
