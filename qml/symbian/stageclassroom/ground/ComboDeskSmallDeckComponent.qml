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
    width: 121
    height: 146
    y: worldClassroom.height - worldClassroom.groundWallHeight - height

    property string image: "../images/obstacles/desk_smalldeck.png"

    bodyType: Body.Static

    sleepingAllowed: true

    fixtures: [
        Polygon{
            vertices: [
                Qt.point(35,8),
                Qt.point(36,22),
                Qt.point(88,14),
                Qt.point(86,2)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(31,23),
                Qt.point(32,47),
                Qt.point(87,39),
                Qt.point(84,16)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(2,51),
                Qt.point(28,74),
                Qt.point(103,74),
                Qt.point(108,37)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(83,74),
                Qt.point(83,143),
                Qt.point(93,143),
                Qt.point(96,74)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(35,135),
                Qt.point(34,140),
                Qt.point(116,143),
                Qt.point(113,134)
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
