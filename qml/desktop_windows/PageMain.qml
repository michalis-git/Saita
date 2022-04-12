/****************************************************************************
**
** This file is part of Saita @ School
**
** Copyright (c) 2011 Nikolaos Gerontidis.*
** All rights reserved.
** Contact:  Nikolaos Gerontidis (n.gerontidis@idealapps.gr)
**
** You may use this file under the terms of the license as follows:
**
** Redistribution in source and binary forms, with or without
** modification, are prohibitted without prior written permission by
** Nikolaos Gerontidis.
** Editing this file is prohibitted without prior written permission by
** Nikolaos Gerontidis.
**
****************************************************************************/

import QtQuick 1.1
import Box2D 1.0

//import QtMultimediaKit 1.1
//import GEAudio 1.0

Item {
    id: pageMain

    property bool soundEffectsMuted: false

    property bool musicMuted: false

    property bool trial: true

    property alias arcadeCanvas: arcadeCanvas

    property bool showTipsOnStart: true

    property alias audioController: audioController

    // change this to other screen resolutions
    anchors.fill: parent

    function playTapSoundEffect(){
        tapSoundEffect.stop();
        tapSoundEffect.play()
    }

    function playLostSoundEffect(){
        lostSoundEffect.stop()
        lostSoundEffect.play()
    }

    function resetAudio(){
        soundEffectsMuted = !soundEffectsMuted;
        musicMuted = !musicMuted

        soundEffectsMuted = !soundEffectsMuted;
        musicMuted = !musicMuted

        tapSoundEffect.source = ''
        tapSoundEffect.source = 'assets/audio/effects/tap.wav'
    }

    AudioController{
        id: audioController
    }

    StartUpAnimationScreen{
        id: startupAnimationScreen
        anchors.fill: parent
        visible: true
    }

    ArcadeCanvas{
        id: arcadeCanvas
        visible: false
        anchors.fill: parent

        onBackClicked: { pageMain.state = 'menu'; console.log('changed to menu state') }
    }

    CustomMenu {
        id: menu
        x: 0
        anchors.horizontalCenterOffset: 0
        visible: true
        anchors.horizontalCenter: parent.horizontalCenter
        z:1
        anchors.verticalCenter: parent.verticalCenter

        onHelpClicked: pageStack.push(Qt.resolvedUrl('HelpScreen.qml'));
        onAboutClicked: pageStack.push(Qt.resolvedUrl('PageAbout.qml'))
        onArcadeClicked: { pageMain.state = 'arcade' }
    }

    states : [
        State{
            name: "menu"
            PropertyChanges { target: menu; visible: true; opacity: 1.0; }
            PropertyChanges { target: arcadeCanvas; visible: false; opacity: 0.0 }
            PropertyChanges { target : startupAnimationScreen; opacity:1; visible: true; timerRunning: true }
        },
        State {
            name: "arcade"
            PropertyChanges { target : startupAnimationScreen; opacity:0; visible: false; timerRunning: false }
            PropertyChanges { target: arcadeCanvas; visible: true; opacity: 1.0 }
            PropertyChanges { target: menu; visible: false; opacity: 0.0; y: pageMain.height / 2 - menu.height / 2 - 20 }
        }
    ]

    transitions: [
        Transition {
            from: "arcade"; to: "menu"; reversible: true;
            PropertyAction { target: menu; property: "visible"; }
            NumberAnimation { target: menu; properties: "y,opacity"; duration: 200; }
        },
        Transition {
            from: "menu"; to: "race"; reversible: true;
            PropertyAction { target: menu; property: "visible"; }
            NumberAnimation { target: menu; properties: "y,opacity"; duration: 200; }
        }
    ]
}
