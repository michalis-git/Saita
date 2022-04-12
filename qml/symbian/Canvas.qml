// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

// this is the main element where all classroom sprites Background items and classroom elements are drawn
Item {
    id: canvas

    property int difficultyLevel: 0 // easy [0] , medium [1] , expert[2]

    property alias localFont: myFont

    signal gameOver(int scVal, int bVal);

    Loader{id: loader; source: "stageclassroom/ClassRoom.qml";

        onStatusChanged:  status == Loader.Ready? item.parent = canvas: console.log('loader  status : ' + status)
    }

    function restartGame(){

        loader.item.restartGame();

        canvas.state = 'running'
    }

    function pauseGame(){
        loader.item.state = 'paused'
    }

    FontLoader { id: myFont; source: "assets/fonts/Stylus_BT.ttf" }

    // This is the menu shown when the user taps on the pause CustomButton
    PauseMenu {
        id: pauseMenu
        width: 150
        anchors { top: parent.top; topMargin: 1; bottom: parent.bottom; bottomMargin: 1 }
        z:30
        x: -width

        // resume the saita
        onResumeClicked: { canvas.state = 'running'; loader.item.state = 'running'; loader.item.saita.state = 'running' }
        // go back to the menu
        onMainMenuClicked: { loader.item.stopSpecialEffect(); pageMain.state = 'menu'; canvas.state = ''; }
    }

    LostMenu{
        id: lostMenu
        width: 275
        height: 164
        anchors.centerIn: canvas
        opacity: 0.0
        visible: false
        z:30

        // check whether the saita has a minimum allowed speed before restarting
        onRestart: {if(Math.abs(loader.item.saita.linearVelocity.y + loader.item.saita.linearVelocity.x) < 1){ loader.item.saita.state = ''; canvas.state = 'running'; loader.item.restartGame() } }
        // check whether the saita has a minimum allowed speed before back to menu
        onBackToMenu: { if(Math.abs(loader.item.saita.linearVelocity.y + loader.item.saita.linearVelocity.x) < 1){ canvas.state = ''; pageMain.state = 'menu' } }
        // emit a signal containing the name on the leaderboard the user used to save the score
        onNameChanged: {
            var component = Qt.createComponent(Qt.resolvedUrl('PageLeaderBoard.qml'));

            if(component.status == Component.Ready){
                var page = component.createObject(canvas);

                page.currentName = name;
                page.currentModeIndex = difficultyLevel;

                pageStack.push(page);
            }else
                console.log(component.errorString());
        }
    }

    Image{
        id: pauseButton
        width: 40
        height: 45
        anchors{ bottom: parent.bottom; bottomMargin: 0; left: parent.left; leftMargin: 0 }
        visible: false
        source: pauseArea.pressed? "assets/images/buttons/pause_pressed.png": "assets/images/buttons/pause.png"
        z:5

        Image{
            anchors.rightMargin: 2
            anchors.topMargin: 2
            anchors.fill: parent
            source: "assets/images/menu/button/shadowed_buttons.png"
            visible: !pauseArea.pressed
        }

        MouseArea{
            id: pauseArea
            anchors.fill: parent
            anchors.topMargin: -25
            anchors.rightMargin: -27

            onClicked: { pageMain.audioController.playTapSoundEffect(); loader.item.state = 'paused'; canvas.state = 'paused' }
        }
    }

    Connections{
        target: loader.item
        onLost: { lostMenu.score = scVal; lostMenu.bonusItems = bVal; lostMenu.saveScore(); }
        onGameOver: { console.log('game over : scVal : '+scVal+' bVal : '+bVal); canvas.gameOver(scVal,bVal) }
    }

    states:[
        State{
            name: "paused"

            StateChangeScript{ name: "pausedScript"; script: if(loader.item != null){ loader.item.mArea.enabled = true; } }
            PropertyChanges { target: pauseMenu; visible: true; x:0 }
            PropertyChanges { target: pauseButton; visible: false; }
        },State{
            name: "lost"
            StateChangeScript{
                name: "lostScript";
                script: {
//                    lostMenu.saveScore();
                }
            }

            PropertyChanges { target: pauseButton; visible: false; }
            PropertyChanges { target: lostMenu; visible: true; opacity: 1 }
        },State{
            name: "running"

            StateChangeScript{ name: "runningScript"; script: if(loader.item != null){ loader.item.mArea.enabled = true } }
            PropertyChanges { target: pauseMenu; visible: false; x:-pauseMenu.width}
            PropertyChanges { target: lostMenu; visible: false; opacity: 0.0 }
            PropertyChanges { target: pauseButton; visible: true; }
        },State{
            name: "gameOver"

            StateChangeScript{ name: 'gameOverScript'; script: { loader.source = ''; console.log('set loader source to null'); loader.source = 'stageclassroom/ClassRoom.qml'; console.log('set loader source to stageclassroom/ClassRoom.qml')} }
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
        }
    ]
}
