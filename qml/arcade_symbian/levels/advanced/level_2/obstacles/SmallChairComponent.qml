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
    width: 88
    height: 140
    y: worldClassroom.height - worldClassroom.floorWallHeight - height

    property string image: "../images/obstacles/chair.png"
    property int bottomPartHeight: 65
    property int bottomPartWidth: 82

    property string bodyMode: "not set"

    bodyType: bodyMode === "static" ? Body.Static : Body.Dynamic

    sleepingAllowed: true

    fixtures: [
        Box{
            x:4
            y:bodyItem.height - bottomPartHeight
            width: bottomPartHeight
            height: bottomPartWidth
        },
        Polygon {
            vertices: [
                Qt.point(15,4),
                Qt.point(9,9),
                Qt.point(9,72),
                Qt.point(76,75),
                Qt.point(76,8),
                Qt.point(66,4)
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
