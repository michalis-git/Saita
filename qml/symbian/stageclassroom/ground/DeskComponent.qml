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
    width: 119
    height: 109
    y: worldClassroom.height - worldClassroom.groundWallHeight - height

    property string image: "../images/obstacles/desk.png"

    bodyType: Body.Static

    sleepingAllowed: true

    fixtures: [
        Polygon{
            vertices: [
                Qt.point(2,16),
                Qt.point(28,39),
                Qt.point(103,39),
                Qt.point(108,1)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(83,39),
                Qt.point(82,107),
                Qt.point(93,107),
                Qt.point(96,39)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(34,100),
                Qt.point(34,104),
                Qt.point(115,107),
                Qt.point(112,98)
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
