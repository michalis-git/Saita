/****************************************************************************
**
** This file is part of Glinder adventures
**
** Copyright (c) 2011 Nikolaos Gerontidis.
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
//import com.nokia.meego 1.0

Item {
    id: window
//    showStatusBar: false

//    initialPage: pageMain
    width: screenWidth
    height: screenHeight

    PageMain {
        id: pageMain
        anchors.fill: parent
    }

    states: [
        State {
            name: "fullsize-visible"
            when: platformWindow.viewMode == WindowState.Fullsize && platformWindow.visible
            StateChangeScript {
                script: {

                    console.log("Visibility: Fullsize and visible!")
                }
            }
        },
        State {
            name: "thumbnail-or-invisible"
            when: platformWindow.viewMode == WindowState.Thumbnail || !platformWindow.visible

            StateChangeScript {
                script: {
                    if(pageMain.mode === 'arcade'){
                        if(pageMain.arcadeCanvas.state === 'running')
                        {
                            pageMain.arcadeCanvas.pauseGame();
                            pageMain.arcadeCanvas.state = 'paused';
                        }else{
                            if(pageMain.arcadeCanvas.state === 'running')
                            {
                                pageMain.arcadeCanvas.pauseGame();
                                pageMain.arcadeCanvas.state = 'paused';
                            }
                        }
                    }

                    console.log("Visibility: Not fullsize (Thumbnail and/or invisible)")
                }
            }
        }
    ]
}
