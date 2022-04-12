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
    width: 70
    height: 76
    y: worldClassroom.height - worldClassroom.groundWallHeight - height

    property string image: "../images/obstacles/big_deck.png"

    bodyType: Body.Static

    sleepingAllowed: true

    fixtures: [
        Polygon{
            vertices: [
                Qt.point(10,1),
                Qt.point(10,16),
                Qt.point(61,16),
                Qt.point(61,1)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(3,16),
                Qt.point(3,37),
                Qt.point(58,37),
                Qt.point(58,16)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(16,37),
                Qt.point(16,52),
                Qt.point(67,52),
                Qt.point(67,40)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(10,52),
                Qt.point(10,75),
                Qt.point(61,75),
                Qt.point(61,52)
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
