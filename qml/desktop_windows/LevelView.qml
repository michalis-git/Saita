// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
//import com.nokia.meego 1.0
import "levelengine.js" as LevelEngine

Item {
    id: levelView

    anchors.fill: parent
//    orientationLock: PageOrientation.LockLandscape

    property alias levelModel: levelModel
    property alias levelGridView: levelGridView

    property bool levelMouseAreaEnabled: true

    property string path: "NOT SET"

    property int message: 3

    property int cIndex: -1

    function getCurrentPath(){
        return levelModel.source;
    }

    function getMainPage(){
//        return pageStack.find(function(page){
//                           return page.message == "1";
//                       });
        return arcadeCanvas.parent;
    }

    function playStageTapSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playStageTapSoundEffect();
    }

    function playTapSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playTapSoundEffect();
    }

    function playLostMusic(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playLostMusic();
    }

    function stopLostMusic(){
        var page = getMainPage();

        if(page != null)
            page.audioController.stopLostMusic();
    }

    function playWinMusic(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playWinMusic();
    }

    function stopWinMusic(){
        var page = getMainPage();

        if(page != null)
            page.audioController.stopWinMusic();
    }

    function playAppendBonusItemSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playAppendBonusItemSoundEffect();
    }

    function playMusic(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playMusic();
    }

    function stopMusic(){
        var page = getMainPage();

        if(page != null)
            page.audioController.stopMusic();
    }

    function playLostSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playLostSoundEffect();
    }

    function playStealthSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playStealthSoundEffect();
    }

    function playBulletSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playBulletSoundEffect();
    }

    function playNightSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playNightSoundEffect();
    }

    function playApplySpecialEffectSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playApplySpecialEffectSoundEffect();
    }

    function stopApplySpecialEffectSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.stopApplySpecialEffectSoundEffect();
    }

    function playSrinkSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playSrinkSoundEffect();
    }

    function playScissorsSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playScissorsSoundEffect();
    }

    function playLampSqueekSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playLampSqueekSoundEffect();
    }

    function playSlowDownSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playSlowDownSoundEffect()
    }

    function playBounceSoundEffect(){
        var page = getMainPage();

        if(page != null)
            page.audioController.playBounceSoundEffect();
    }

    function playLampCrashSoundEffect(){
        var page = getMainPage();

        if(page!= null)
            page.audioController.playLampCrashSoundEffect();
    }

    Connections{
        target: XmlUtility
        onApplesChanged: { console.log('apples changed ..'); levelModel.reload() }
        onLevelUnlocked: {  console.log('level unlocked ..'); levelModel.reload() }
    }

//    Connections{
//        target: levelLoader.item
//        onLost: { console.log('lId : ' + lId + ' , bVal : ' + bVal); lostMenu.levelId = lId; lostMenu.bonusItems = bVal }
//        onWin: { winMenu.bonusItems = bVal; winMenu.currentLevel = lId }
//    }

    // This is the menu shown when the user taps on the pause CustomButton
    PauseMenu {
        id: pauseMenu
        width: 150
        anchors { top: parent.top; topMargin: 1; bottom: parent.bottom; bottomMargin: 1 }
        z:30
        x: -width
        visible: false

        // resume the saita
        onResumeClicked: { playTapSoundEffect(); levelView.state = 'running'; LevelEngine.resumeGame() }
        // go back to the menu
        onMainMenuClicked: { playTapSoundEffect(); levelView.state = ''; LevelEngine.deleteCurrentLevel() }
    }

    WinMenu{
        id: winMenu
        width: 366
        height: 218
        anchors.centerIn: levelView
        opacity: 0.0
        visible: false
        z:300

        // restart the current level
        onRestart: {
            console.log('[RESTART] cIndex : ' + cIndex);

            playTapSoundEffect();
            LevelEngine.createLevel(levelModel.get(cIndex).path);
            levelView.state = 'running';
            LevelEngine.restartGame()
        }
        // check whether the saita has a minimum allowed speed before back to menu
        onBackToMenu: { playTapSoundEffect(); LevelEngine.deleteCurrentLevel(); levelView.state = '' }

        onNextLevel: {

            playTapSoundEffect();

            if(cIndex<levelModel.count)
            {
                cIndex++;

                var path = levelModel.get(cIndex).path

                LevelEngine.createLevel(path);

                levelView.state = 'running';

                LevelEngine.restartGame()

                console.log('[NEXT LEVEL] cIndex : ' + cIndex);

            }else
            {
                levelView.state = '';
                LevelEngine.deleteCurrentLevel();
            }
        }
    }

    LostMenu{
        id: lostMenu
        width: 366
        height: 218
        anchors.centerIn: levelView
        opacity: 0.0
        visible: false
        z:30

        // restart the current level
        onRestart: {
            console.log('[RESTART] cIndex : ' + cIndex);

            playTapSoundEffect();
            LevelEngine.createLevel(levelModel.get(cIndex).path);
            levelView.state = 'running';
            LevelEngine.restartGame()
        }
        // check whether the saita has a minimum allowed speed before back to menu
        onBackToMenu: { playTapSoundEffect(); levelView.state = ''; LevelEngine.deleteCurrentLevel() }
    }

    Image{
        id: pauseButton
        width: 53
        height: 59
        anchors{ bottom: parent.bottom; bottomMargin: 0; left: parent.left; leftMargin: 0 }
        visible: false
        source: pauseArea.pressed? "assets/images/buttons/pause_pressed.png": "assets/images/buttons/pause.png"
        z:5

        Image{
            anchors.rightMargin: 3
            anchors.topMargin: 4
            anchors.fill: parent
            source: "assets/images/menu/button/shadowed_buttons.png"
            visible: !pauseArea.pressed
        }

        MouseArea{
            id: pauseArea
            anchors.fill: parent
            anchors.topMargin: -21
            anchors.rightMargin: -27

            onClicked: { playTapSoundEffect(); LevelEngine.pauseGame(); levelView.state = 'paused' }
        }
    }

//    Loader{
//        id: levelLoader

//        onStatusChanged:  status == Loader.Ready? item.parent = levelView: console.log('loader  status : ' + status)
//    }

    Image{
        anchors.fill: parent

        source:"assets/images/background/level_background_Harmattan.png"
    }

    XmlListModel{
        id: levelModel
        source: "assets/levels/" + path

        query: "/levels/level"

        XmlRole{ name: "id"; query: "@id/string()" }
        XmlRole{ name: "path"; query: "@path/string()" }
        XmlRole{ name: "lockedstate"; query: "@lockedstate/string()" }
        XmlRole{ name: "apples"; query: "@apples/string()" }
    }

    Component{
        id: headerComponent

            Text{
                text: path === "advanced.xml"? "Advanced Levels": "Basic Levels"
                font{ pointSize: 17; bold: true; family: arcadeCanvas.localFont.name }
                width: GridView.view.width - 9
                horizontalAlignment: Text.AlignHCenter
                color: "white"
            }
    }

    Component{
        id: levelComponent

        Item{
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            property alias appleModel: appleModel

            ListModel{
                id: appleModel
                ListElement{ no: "0"; fill: false; path: "assets/images/extras/apple_bitten.png" }
                ListElement{ no: "1"; fill: false; path: "assets/images/extras/apple_bitten.png" }
                ListElement{ no: "2"; fill: false; path: "assets/images/extras/apple_bitten.png" }
            }

            function setupModel(){
                for(var i = 0; i < apples; i++){
                    appleModel.get(i).path = "assets/images/extras/apple.png"
                }
            }

            Column{
                anchors.centerIn: parent
                spacing: 3
                z:1

                Text {
                    text: id
                    font{ pointSize: 16; bold: true; family: arcadeCanvas.localFont.name }
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Image{
                    width: 32
                    height: 32
                    source: lockedstate === '1'? 'assets/images/locked.png' : 'assets/images/shopping.png'
                    visible: lockedstate === '0'? false: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                ListView{
                    id: appleView
                    width: 72
                    height: 24
                    model:appleModel
                    spacing: 4
                    visible: lockedstate === '0'? true: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: - 5
                    interactive: false
                    orientation: ListView.Horizontal
                    delegate: Image {
                        source: path
                        width: 24
                        height: appleView.height
                    }
                    z:100
                }
            }

            Image{
                id: excelBadge
                source: "assets/images/menu/button/scores.png"
                width: 28
                height: 28
                visible: apples === '3'? true: false
                anchors.leftMargin: 2
                anchors.topMargin: 2
            }

            MouseArea{
                enabled: levelMouseAreaEnabled
                anchors.fill: parent
                onClicked: { cIndex = index; LevelEngine.createLevel(path); levelView.state = 'running'; LevelEngine.restartGame()}
            }

            Component.onCompleted: setupModel()
        }
    }

    GridView{
        id: levelGridView
        model: levelModel
        anchors.fill: parent
        anchors.margins: 45
        cellHeight: levelView.height / 4
        cellWidth: levelView.width / 7.021
        delegate: levelComponent
        header: headerComponent
        interactive: false
    }

    Column{
        width: 100
        height: 97
        spacing: 6
        anchors.right: parent.right
        anchors.rightMargin: 6
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3

        Image {
            id: backtitle
            source: "assets/images/menu/button/back_title.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image{
            id: backIcon
            source: backArea.pressed? "assets/images/menu/button/back_pressed.png": "assets/images/menu/button/back.png"
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: backIconShadow
                anchors.rightMargin: 3
                anchors.topMargin: 3
                source: "assets/images/menu/button/shadowed_buttons.png"
                anchors.fill: parent
                visible: !backArea.pressed
            }
        }

        MouseArea
        {
            id: backArea
            enabled: levelMouseAreaEnabled
            anchors.fill: parent
            onClicked: { playTapSoundEffect(); pageStack.pop() }
        }
    }

    states:[
        State{
            name: "paused"

//            StateChangeScript{ name: "pausedScript"; script: if(levelLoader.item != null){ levelLoader.item.mArea.enabled = true; } }
            PropertyChanges { target: pauseMenu; visible: true; x:0 }
            PropertyChanges { target: pauseButton; visible: false; }
            PropertyChanges { target: levelView; levelMouseAreaEnabled: false }
        },State{
            name: "lost"

            StateChangeScript{ name: "lost"; script: playLostMusic() }

            PropertyChanges { target: pauseButton; visible: false; }
            PropertyChanges { target: winMenu; visible: false; opacity: 0.0 }
            PropertyChanges { target: lostMenu; visible: true; opacity: 1 }
            PropertyChanges { target: levelView; levelMouseAreaEnabled: false }
        },State{
            name: "running"

            PropertyChanges { target: pauseMenu; visible: false; x:-pauseMenu.width}
            PropertyChanges { target: lostMenu; visible: false; opacity: 0.0 }
            PropertyChanges { target: winMenu; visible: false; opacity: 0.0 }
            PropertyChanges { target: pauseButton; visible: true; }
            PropertyChanges { target: levelView; levelMouseAreaEnabled: false }
        },State{
            name: "win"

            StateChangeScript{ name: "winScript"; script: { winMenu.start() } }

            PropertyChanges { target: pauseButton; visible: false; }
            PropertyChanges { target: lostMenu; visible: false; opacity: 0 }
            PropertyChanges { target: winMenu; visible: true; opacity: 1 }
            PropertyChanges { target: levelView; levelMouseAreaEnabled: false }
        }
    ]

    transitions: [
        Transition {
            from: "running"; to: "paused"; reversible: true;
            PropertyAction { target: pauseMenu; property: "visible"; }
            NumberAnimation { target: pauseMenu; properties: "y,opacity,x"; duration: 300; }
        },
        Transition {
            from: "running"; to: "lost"; reversible: true;
            PropertyAction { target: lostMenu; property: "visible"; }
            NumberAnimation { target: lostMenu; properties: "y,opacity"; duration: 200; }
            ScriptAction{ scriptName: "lostScript" }
        },
        Transition {
            from: "running"; to: "win"; reversible: true;
            PropertyAction { target: winMenu; property: "visible"; }
            NumberAnimation { target: winMenu; properties: "y,opacity"; duration: 200; }
        }
    ]
}
