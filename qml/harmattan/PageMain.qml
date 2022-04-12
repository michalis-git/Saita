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
import com.nokia.meego 1.0
import "stageclassroom"
import QtMultimediaKit 1.1
import GEAudio 1.0

Page {
    id: pageMain

    property alias canvas: canvas

    property bool soundEffectsMuted: true

    property bool musicMuted: false

    property alias difficultyLevel : canvas.difficultyLevel

    property alias audioController: audioController

    property bool trial: true

    TrialScreen{
        id: trialScreen
        visible: false
        opacity: 0.0
        anchors.fill: parent
        anchors.margins: 1
        z:100

        onOkClicked: pageMain.state = 'menu'
    }

    function checkTrialState(){
        if(trial){
            if(GeneralUtilities.isExpired())
                trialScreen.mode = "expired"
            else
                trialScreen.mode = "trial"

            pageMain.state = 'trial'
        }
    }

    // change this to other screen resolutions
    anchors.fill: parent

    orientationLock: PageOrientation.LockLandscape

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

    AudioController{ id: audioController }

    StartUpAnimationScreen{
        id: startupAnimationScreen
        anchors.fill: parent
        visible: true
    }

    Canvas{
        id: canvas
        anchors.fill: parent
        visible: false
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
        onDifficultyChanged: { canvas.difficultyLevel = level; canvas.restartGame(); pageMain.state = 'play' }
        onScoresClicked: pageStack.push(Qt.resolvedUrl('PageLeaderBoard.qml'));
        onAboutClicked: pageStack.push(Qt.resolvedUrl('PageAbout.qml'))
    }

    Item{
        id: item1
        width: 80
        height: 80
        anchors.bottom: parent.bottom
        visible: menu.visible

        Image{
            id: exitIcon
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            source: exitArea.pressed? "assets/images/menu/button/exit_pressed.png": "assets/images/menu/button/exit.png"

            Image {
                anchors.rightMargin: 3
                anchors.topMargin: 3
                source: "assets/images/menu/button/shadowed_buttons.png"
                anchors.fill: exitIcon
                visible: !exitArea.pressed
            }
        }

        MouseArea
        {
            id: exitArea
            anchors.fill: parent
            onClicked:  { pageMain.audioController.playTapSoundEffect(); menu.state = 'leave' }
        }
    }

    Connections{
        target: canvas
        onGameOver: {
            var component = Qt.createComponent(Qt.resolvedUrl('PageGameOver.qml'));

            if(component.status == Component.Ready){
                var page = component.createObject(pageMain);

                page.score = scVal;
                page.bonus = bVal;

                pageStack.push(page);

                page.saveScore();

            }else{
                console.log(' component.errorString() : '+component.errorString())
            }
        }
    }

    states : [
        State {
            name: "play";
            PropertyChanges { target : startupAnimationScreen; opacity:0; visible: false; timerRunning: false }
            PropertyChanges { target: canvas; visible: true; opacity: 1.0 }
            PropertyChanges { target: menu; visible: false; opacity: 0.0; y: pageMain.height / 2 - menu.height / 2 - 20 }
            PropertyChanges { target : trialScreen; opacity:0; visible: false; }
        },
        State{
            name: "menu"
            PropertyChanges { target: menu; visible: true; opacity: 1.0; }
            PropertyChanges { target: canvas; visible: false; opacity: 0.0 }
            PropertyChanges { target : startupAnimationScreen; opacity:1; visible: true; timerRunning: true }
            PropertyChanges { target : trialScreen; opacity:0; visible: false; }
        },
        State{
            name: "trial"
            PropertyChanges { target: menu; visible: false; opacity: 0.0; }
            PropertyChanges { target: canvas; visible: false; opacity: 0.0 }
            PropertyChanges { target : startupAnimationScreen; opacity:0; visible: false; timerRunning: false }
            PropertyChanges { target : trialScreen; opacity:1; visible: true; }
        }
    ]

    transitions: [
        Transition {
            from: "play"; to: "menu"; reversible: true;
            PropertyAction { target: menu; property: "visible"; }
            NumberAnimation { target: menu; properties: "y,opacity"; duration: 200; }
        },
        Transition {
            from: "menu"; to: "play"; reversible: true;
            PropertyAction { target: menu; property: "visible"; }
            NumberAnimation { target: menu; properties: "y,opacity"; duration: 200; }
        },
        Transition {
            to: "trial"; reversible: true;
            PropertyAction { target: trialScreen; properties: "visible,opacity"; }
        }
    ]

    Component.onCompleted: { soundEffectsMuted = false; checkTrialState() }
}
