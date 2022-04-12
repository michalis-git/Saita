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
    height: 123
    y: worldClassroom.height - worldClassroom.groundWallHeight - height

    property string image: "../images/obstacles/verybig_deck.png"

    bodyType: Body.Static

    sleepingAllowed: true

    fixtures: [
        Polygon{
            vertices: [
                Qt.point(13,2),
                Qt.point(46,25),
                Qt.point(68,25),
                Qt.point(68,2)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(5,25),
                Qt.point(5,50),
                Qt.point(59,50),
                Qt.point(59,25)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(11,50),
                Qt.point(11,64),
                Qt.point(62,64),
                Qt.point(62,50)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(3,64),
                Qt.point(3,86),
                Qt.point(58,86),
                Qt.point(58,64)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(16,86),
                Qt.point(16,100),
                Qt.point(68,100),
                Qt.point(68,88)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(11,100),
                Qt.point(11,123),
                Qt.point(62,123),
                Qt.point(62,100)
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
