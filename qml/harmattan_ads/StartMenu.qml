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
    signal playClicked();
    signal helpClicked();
    signal scoresClicked();
    signal optionsClicked();
    signal shareClicked();
    signal aboutClicked();

    width: 480
    height: 240

    Column{
        spacing: 6
        anchors.centerIn: parent

        Row{
            spacing: 10

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: playtitle
                    source: "assets/images/menu/button/play_title.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: playIcon
                    source: playArea.pressed? "assets/images/menu/button/play_pressed.png": "assets/images/menu/button/play.png"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: playIconShadow
                        anchors.rightMargin: 2
                        anchors.topMargin: 3
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: parent
                        visible: !playArea.pressed
                    }
                }

                MouseArea
                {
                    id: playArea
                    anchors.fill: parent
                    onClicked: playClicked()
                }
            }

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: optionsitle
                    source: "assets/images/menu/button/options_title.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: optionsIcon
                    source: optionsArea.pressed? "assets/images/menu/button/options_pressed.png": "assets/images/menu/button/options.png"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: optionsIconShadow
                        anchors.rightMargin: 2
                        anchors.topMargin: 3
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: optionsIcon
                        visible: !optionsArea.pressed
                    }
                }

                MouseArea
                {
                    id: optionsArea
                    anchors.fill: parent
                    onClicked:  optionsClicked()
                }
            }

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: scorestitle
                    source: "assets/images/menu/button/scores_title.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: scoresIcon
                    source: scoresArea.pressed? "assets/images/menu/button/scores_pressed.png": "assets/images/menu/button/scores.png"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: scoresIconShadow
                        anchors.rightMargin: 3
                        anchors.topMargin: 3
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: parent
                        visible: !scoresArea.pressed
                    }
                }

                MouseArea
                {
                    id: scoresArea
                    anchors.fill: parent
                    onClicked: scoresClicked()
                }
            }
        }

        Row{
            spacing: 10

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: sharetitle
                    source: "assets/images/menu/button/share_title.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: shareIcon
                    source: shareArea.pressed? "assets/images/menu/button/share_pressed.png": "assets/images/menu/button/share.png"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: shareIconShadow
                        anchors.rightMargin: 3
                        anchors.topMargin: 3
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: shareIcon
                        visible: !shareArea.pressed
                    }
                }

                MouseArea
                {
                    id: shareArea
                    anchors.fill: parent
                    onClicked: shareClicked()
                }
            }

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: helptitle
                    source: "assets/images/menu/button/help_title.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: helpIcon
                    source: helpArea.pressed? "assets/images/menu/button/help_pressed.png": "assets/images/menu/button/help.png"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: helpIconShadow
                        anchors.rightMargin: 3
                        anchors.topMargin: 3
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: parent
                        visible: !helpArea.pressed
                    }
                }

                MouseArea
                {
                    id: helpArea
                    anchors.fill: parent
                    onClicked: helpClicked()
                }
            }

            Column{
                width: 130
                height: 100
                spacing: 6

                Image {
                    id: abouttitle
                    source: "assets/images/menu/button/about_title.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    id: aboutIcon
                    source: aboutArea.pressed? "assets/images/menu/button/about_pressed.png": "assets/images/menu/button/about.png"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: aboutIconShadow
                        anchors.rightMargin: 3
                        anchors.topMargin: 3
                        source: "assets/images/menu/button/shadowed_buttons.png"
                        anchors.fill: aboutIcon
                        visible: !aboutArea.pressed
                    }

                }

                MouseArea
                {
                    id: aboutArea
                    anchors.fill: parent
                    onClicked: aboutClicked()
                }
            }
        }
    }
}
