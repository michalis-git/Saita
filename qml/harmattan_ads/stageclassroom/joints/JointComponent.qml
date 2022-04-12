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

    property string image: "NOT SET"

    width: 250
    height: 40
    y: 150 - circleShape.radius

    Body {
        id: rod
        fixedRotation: false
        sleepingAllowed: false
        parent: worldClassroom

        x: bodyItem.x
        y: 150 - circleShape.radius

        width: 250
        height: 40

        fixtures: Box {
            anchors.fill: parent
            density: 1;
            friction: 1;
            restitution: 0.3;
        }

        Rectangle {
            color: "green"
            radius: 6
            anchors.fill: parent
        }
    }

    Body {
        id: middle
        fixedRotation: true
        sleepingAllowed: false
        bodyType: Body.Static
        parent: worldClassroom

        width: 40
        height: width

        x: bodyItem.x + 50
        y: 150

        fixtures: Circle {
            id: circleShape
            radius: middle.width / 2
            anchors.fill: parent
        }

        Rectangle {
            id: itemShape
            radius: 180
            width: parent.width
            height: parent.height
            color: "black"
            x: circleShape.x - circleShape.radius
            y: circleShape.y - circleShape.radius
        }
    }


    RevoluteJoint {
        id: revolute
        maxMotorTorque: 300
        motorSpeed: 0
        bodyA: middle
        bodyB: rod
        worldClassroom: worldClassroom
    }
}