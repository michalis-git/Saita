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

Item {
    id: backgroundLevel2

    Component {
        id: itemComponent

        Image {
            id: item
        }
    }

    function createItem(image, x, y,w,h) {
        var object = itemComponent.createObject(backgroundLevel2);
        object.source = Qt.resolvedUrl(image);
        object.x = x;
        object.y = y;
//        object.width = w;
//        object.height = h;
        return object;
    }
}
