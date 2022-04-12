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
    id: saita

    fixedRotation: true
    width: 48
    height: 45
    z:200

    property string imagepath: "images/saita/saita.png"
    property string imagelost: "images/saita/saita_damaged.png"
    property string imagebullet: "images/saita/bullet.png"
    property string imagestealth: "images/saita/stealth_effect.png"
    property string imagestealthlight: "images/saita/stealth_effect_extra_light.png"
    property string imagebullet1: "images/saita/bullet1.png"
    property string imagebullet2: "images/saita/bullet2.png"

    property double proportion: 1.4

    property bool player: true

    property double aDensity: 0.2 // this is the default density which causes the saita to stay on air
    property double aFriction: 0.7
    property double aRestitution: 0.1

    property int offset: classroom.width / 5

    property int currentCenterX: x - offset

    signal contactWithObstacles()

    function rotateSaita(){
        saita.rotation = -10

        rotateTimer.restart()
    }

    function srink(){

        firstPolygon.vertices = [
                    Qt.point(2,1),
                    Qt.point(10,22),
                    Qt.point(24,13)
                ]

        secondPolygon.vertices = [
                    Qt.point(6,10),
                    Qt.point(1,21),
                    Qt.point(9,19)
                ]

        console.log('srinking saita .. first polygon density : ' + firstPolygon.density)

        saita.resetItem();
    }

    function resetSrink(){

        firstPolygon.vertices = [
                    Qt.point(5,2),
                    Qt.point(20,44),
                    Qt.point(47,26)
                ]

        secondPolygon.vertices= [
                    Qt.point(11,19),
                    Qt.point(2,41),
                    Qt.point(17,38)
                ]

        console.log('reseting srank of saita density : ' + firstPolygon.density)


        saita.resetItem();
    }

    Behavior on rotation{
        NumberAnimation{ duration: 400 }
    }

    Timer{
        id: rotateTimer
        interval: 600
        running: false
        onTriggered: saita.rotation = 0
    }

    fixtures: [
        Polygon {
            id: firstPolygon
            density: aDensity
            friction: aFriction
            restitution: aRestitution
            vertices: [
                Qt.point(5,2),
                Qt.point(20,44),
                Qt.point(47,26)
            ]

            onBeginContact: contactWithObstacles()
        },
        Polygon {
            id: secondPolygon
            density: aDensity
            friction: aFriction
            restitution: aRestitution
            vertices: [
                Qt.point(11,19),
                Qt.point(2,41),
                Qt.point(17,38)
            ]

            onBeginContact: contactWithObstacles()
        }
    ]

    Image {
        id:saitaImage
        source: imagepath
        smooth: true
        fillMode: Image.PreserveAspectFit
        width: 48
        height: 45
//        rotation: saita.linearVelocity.y > 0? 0:-10

        z:200
    }

    Image{
        id: slowDownImage
        width: 30
        height: 30
        anchors.verticalCenter: saita.verticalCenter
        anchors.right: saita.left
        source: "images/extras/parachute-icon.png"
        visible: false
        rotation: -90
        z:201
    }

    Image{
        id: fingerImage
        anchors.horizontalCenterOffset: 5
        anchors{ bottom: parent.bottom; bottomMargin: -3; horizontalCenter: parent.horizontalCenter }
        source: "images/hand/back_finger.png"
        z:199
        visible: false
    }

    Image{
        id: lighterImage
        source: imagestealthlight
        visible: false

        SequentialAnimation {
            running: lighterImage.visible
            loops: Animation.Infinite
            PropertyAnimation{ target: lighterImage; property: "visible"; from: false; to: true }
            PropertyAnimation{ target: lighterImage; property: "visible"; from: true; to: false }
        }
    }

    states: [
        State{
            name: "onHand"
            PropertyChanges{ target: fingerImage; visible: true }
        },
        State{
            name: "running"

            PropertyChanges{ target: saitaImage; source: imagepath; width:48; height:45 }
            PropertyChanges{ target: fingerImage; visible: false }
            PropertyChanges{ target: lighterImage; visible: false }
            PropertyChanges{ target: slowDownImage; visible: false }
        },
        State{
            name: "lost"

            PropertyChanges { target: saitaImage; source: imagelost }
            PropertyChanges{ target: fingerImage; visible: false }
            PropertyChanges{ target: lighterImage; visible: false }
        },State{
            name: "bullet"

            StateChangeScript{ name: "bulletScript1"; script: { console.log('bullet script 1 ..'); saita.linearVelocity = Qt.point(saita.linearVelocity.x*proportion,saita.linearVelocity.y); } }
            StateChangeScript{ name: "bulletScript2"; script: { console.log('bullet script 2 ..'); saita.linearVelocity = Qt.point(saita.linearVelocity.x*proportion,saita.linearVelocity.y); } }
            StateChangeScript{ name: "bulletScript3"; script: { console.log('bullet script 3 ..'); saitaImage.source = imagebullet } }
            PropertyChanges { target: saitaImage; source: imagebullet }
            PropertyChanges{ target: fingerImage; visible: false }
            PropertyChanges{ target: lighterImage; visible: false }
        },State{
            name: "stealth"

            PropertyChanges{ target: saitaImage; source: imagestealth }
            PropertyChanges{ target: fingerImage; visible: false }
            PropertyChanges{ target: lighterImage; visible: true }
        },
        State{
            name: "slowDown"

            StateChangeScript{ name: "slowDownnScript1"; script: { console.log('slow down script 1 ..'); saita.linearVelocity = Qt.point(saita.linearVelocity.x*proportion,saita.linearVelocity.y); } }
            StateChangeScript{ name: "slowDownnScript2"; script: { console.log('slow down script 2 ..'); saita.linearVelocity = Qt.point(saita.linearVelocity.x*proportion,saita.linearVelocity.y); } }
            PropertyChanges{ target: fingerImage; visible: false }
            PropertyChanges{ target: lighterImage; visible: false }
            PropertyChanges{ target: slowDownImage; visible: true }
        },State{
            name: "srink"

            StateChangeScript{ name: "srinkScript"; script: { srink() } }

            PropertyChanges{ target: saitaImage; width: 24; height:23 }
        }
    ]

    transitions: [
        Transition{

            from: "running"
            to: "bullet"

            SequentialAnimation{
                PropertyAnimation { target:saitaImage; property:"source"; to: imagebullet2; duration:150 }
                ScriptAction{ scriptName: "bulletScript1" }
                PropertyAnimation { target:saitaImage; property:"source"; from:imagebullet2; to: imagebullet1; duration:150 }
                ScriptAction{ scriptName: "bulletScript2" }
                PropertyAnimation { target:saitaImage; property:"source"; from:imagebullet1; to: imagebullet; duration:150 }
                ScriptAction{ scriptName: "bulletScript3" }
            }
        },Transition{

            from: "running"
            to: "stealth"

            SequentialAnimation{
                PropertyAnimation { target:saitaImage; property:"source"; from:imagepath; to: imagestealth; duration:300 }
                PropertyAnimation { target:saitaImage; property:"source"; from:imagestealth; to: imagestealthlight; duration:400 }
            }
        },Transition{

            from: "bullet"
            to: "running"

            PropertyAnimation{ target:saitaImage; property:"source"; duration:300 }
        },Transition{
            from: "running"
            to: "slowDown"
            reversible: true

            PropertyAnimation{ target:saitaImage; property:"source"; duration:300 }
        },Transition{
            from: "running"
            to:"srink"

            reversible: true

            NumberAnimation{ target: saitaImage; properties:"width,height"; duration: 400 }
        }

    ]
}
