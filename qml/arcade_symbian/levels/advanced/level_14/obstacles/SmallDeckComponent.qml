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
    width: 63
    height: 38
    y: worldClassroom.height - worldClassroom.floorWallHeight - height

    property string bodyMode: "static"

    property string image: "../images/obstacles/small_deck.png"
    property int bottomPartHeight: 64
    property int bottomPartWidth: 60

    property double aDensity: 0.2
    property double aFriction: 0.1
    property double restitution: 0.2

    bodyType: bodyMode === "static"?Body.Static : Body.Dynamic

    sleepingAllowed: true

    fixtures: [
        Polygon{
            vertices: [
                Qt.point(9,1),
                Qt.point(9,14),
                Qt.point(61,14),
                Qt.point(61,1)
            ]
        },
        Polygon{
            vertices: [
                Qt.point(4,14),
                Qt.point(4,37),
                Qt.point(54,37),
                Qt.point(54,14)
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
