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
    width: 60
    height: 83
    y: worldClassroom.height - worldClassroom.groundWallHeight - height

    property string image: "../images/obstacles/bean_plant.png"

    bodyType: Body.Static

    sleepingAllowed: true

    fixtures: [
        Polygon{
            vertices: [
                Qt.point(22,7),
                Qt.point(2,25),
                Qt.point(19,25),
                Qt.point(30,12)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(36,1),
                Qt.point(33,13),
                Qt.point(58,20)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(30,12),
                Qt.point(30,60),
                Qt.point(33,60),
                Qt.point(33,13)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(30,28),
                Qt.point(25,29),
                Qt.point(24,35),
                Qt.point(31,39)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(19,60),
                Qt.point(15,66),
                Qt.point(15,82),
                Qt.point(47,82),
                Qt.point(43,60)
            ]
        }
    ]

    Image {
        id: imageItem
//        anchors.fill: parent;
        source: bodyItem.image
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
            NumberAnimation{ target: imageItem; properties: "opacity"; duration: 200 }
        }
    ]
}
