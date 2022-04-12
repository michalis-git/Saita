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
    width: 84
    height: 162
    y: worldClassroom.height - worldClassroom.groundWallHeight - height

    property string image: "../images/obstacles/small_deck_bean_plant.png"
    property int bottomPartHeight: 85
    property int bottomPartWidth: 80

    bodyType: Body.Static

    sleepingAllowed: true

    fixtures: [
        Polygon{
            vertices: [
                Qt.point(30,9),
                Qt.point(3,33),
                Qt.point(26,33),
                Qt.point(40,16)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(48,1),
                Qt.point(44,17),
                Qt.point(77,27)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(40,16),
                Qt.point(40,80),
                Qt.point(44,80),
                Qt.point(44,17)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(40,37),
                Qt.point(33,39),
                Qt.point(32,47),
                Qt.point(42,52)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(25,80),
                Qt.point(20,88),
                Qt.point(21,112),
                Qt.point(63,112),
                Qt.point(58,80)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(12,2),
                Qt.point(12,19),
                Qt.point(82,19),
                Qt.point(82,2)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(5,19),
                Qt.point(5,50),
                Qt.point(72,50),
                Qt.point(72,19)
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
            reversible: true;
            NumberAnimation{ target: imageItem; properties: "opacity"; duration: 200 }
        }
    ]
}