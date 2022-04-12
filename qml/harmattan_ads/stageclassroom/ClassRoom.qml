// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Box2D 1.0
import "engine.js" as Engine
import "../"
import com.nokia.meego 1.0

Item{
    id: classroom

    // this is a property used to advancing the classroom , namely clear and refresh canvas elements
    property int forwardOffset: classRoomSaita.x + width

    property alias levelModel: levelModel

    property int backgroundRightBorderX: 0

    // this is the speed of saita
    property int saitaSpeed: 0

    property alias saita: classRoomSaita

    property alias mArea: mArea

    // the score depends on the saita position
    property int score : classRoomSaita.x / 160

    // the level property ( this will help any achievements functionality
    property int level: Math.floor(score / ChangeLevelHelperValue);

    property int bonusCounter: 0

    property bool specialEffectTimerRunning: false
    property bool collisionTimerRunning: false
    property bool gameFinish: false
    property bool running: false
    property bool paused: false

    property int backgroundLevel1OffsetValue: -1
    property int backgroundLevel2OffsetValue: -1
    property int backgroundLevel3OffsetValue: -1

    property int foregroundRightBorderX: 0;

    property int background1TranslateValue: 0
    property int background2TranslateValue: 0
    property int background3TranslateValue: 0

    property int totalStageLength: 160 * ChangeLevelHelperValue * levelModel.count

    property real proportionValue: classRoomSaita.x / totalStageLength

    signal lost(int scVal,int bVal)

    signal gameOver(int scVal,int bVal)

    anchors.fill: canvas

    parent: canvas

    // when a level change occur update classroom values
    onLevelChanged: {
        Engine.advanceLevel();
    }

    function restartGame(){
        // firstly reset the state
        classroom.state = ''

        // restart the game engine
        Engine.restartGame();
    }

    function stopSpecialEffect(){
        Engine.stopSpecialEffect();
    }

    Image{
        id: nightImage
        source: "images/extras/night.png"
        opacity: 0
        anchors.fill: parent
        z: 300

        Behavior on opacity{
            NumberAnimation{ duration: 300 }
        }
    }

    Image{
        id: shadowImage
        anchors.fill: parent
        visible: false
        source: "images/background/shadow_background.png"
        z: 300
    }

    // this is the bottom background level,its the level contains sky and cloud elements
    BackgroundLevel1 {
        id: backgroundLevel1
        width: flickable.contentWidth
        height: flickable.contentHeight
        transform: Translate{ x: background1TranslateValue }
        z:1
    }

    // this is the intermediate background level,its the level containing trees etc..
    BackgroundLevel2 {
        id: backgroundLevel2
        width: flickable.contentWidth
        height: flickable.contentHeight
        transform: Translate{ x: background2TranslateValue }
        z:2
    }

    // this is the top background level , actually its the layer containing the walls
    BackgroundLevel3 {
        id: backgroundLevel3
        width: flickable.contentWidth
        height: flickable.contentHeight
        transform: Translate{ x: background3TranslateValue }
        z:3
    }

    Flickable{
        id: flickable

        contentWidth: 8540000
        contentHeight: 480
        anchors.fill: parent
        interactive: false
        z:4

        // focus on the saita , the saita should be always on certain x position , in terms of the device screen positioning..
        contentX: classRoomSaita.x > classroom.width / 5? classRoomSaita.currentCenterX : 0

        Hand{
            id: hand
            x:0
            y:flickable.contentHeight/2+19
            width: 80
            height: 70
            z:200
        }

        // this is the classroom model
        ClassRoomModel{ id: levelModel }

        World {
            id: worldClassroom

            // this is the y of the ground elements
            property int groundY: height - groundWallHeight

            //this is the y coordinate of the roof elements
            property int ceilingY: ceilingWallHeight;

            property int groundWallHeight: 31
            property int ceilingWallHeight: 31

            width: flickable.contentWidth
            height: flickable.contentHeight

            // a timer to check collissions with bonus items
            Timer{
                id: collisionTimer
                interval: Engine.collisionTimerValues[canvas.difficultyLevel];
                running: collisionTimerRunning
                repeat: true
                // check for collissions with bonus elements
                onTriggered: Engine.tick();
            }

            Saita{
                id: classRoomSaita
                z: 200

                // check if the x coordinate has changed, of yes update as necessary
                onXChanged: {
                    // check if the game is running
                    if(classroom.running)
                    {
                        // advance the score
                        classroom.score = classRoomSaita.x / 160;

                        backgroundLevel1.x -= classroom.backgroundLevel1OffsetValue;
                        backgroundLevel2.x -= classroom.backgroundLevel2OffsetValue;
                        backgroundLevel3.x -= classroom.backgroundLevel3OffsetValue;
                    }else if(gameFinish){

                        var offsetX1 = canvas.mapToItem(backgroundLevel3,canvas.width,0).x;

                        if(offsetX1 < backgroundRightBorderX)
                        {
                            background1TranslateValue -= classroom.backgroundLevel1OffsetValue;
                            background2TranslateValue -= classroom.backgroundLevel2OffsetValue;
                            background3TranslateValue -= classroom.backgroundLevel3OffsetValue;
                        }
                        else
                        {
                            var val = flickable.contentX;
                            flickable.contentX = val;
                        }

                        var saitaOffsetX = worldClassroom.mapToItem(classroom,classRoomSaita.x,0).x;

                        if(saitaOffsetX > classroom.width)
                        {
                            console.log('game over set..');

                            classroom.state = 'gameOver'

                            canvas.state = 'gameOver'

                            pageMain.state = 'menu'
                        }
                    }
                }

                MyProgressBar{
                    id: pb
                    mPBRunning: specialEffectTimerRunning
                    seconds: Engine.specialEffectDurationValues[canvas.difficultyLevel];
                    visible: specialEffectTimerRunning
                    width: saita.width/1.5
                    height: 10
                    anchors.bottom: saita.top
                    anchors.bottomMargin: 4
                    z:201

                    onFinished: Engine.stopSpecialEffect();
                }
            }

            Wall{
                id: ground
                height: worldClassroom.groundWallHeight
                width: parent.width
                anchors.bottom: parent.bottom
            }

            Wall{
                id: ceiling
                height: worldClassroom.ceilingWallHeight
                width: parent.width
                anchors.top: parent.top
            }

            MouseArea{
                id: mArea
                z: 5
                enabled: false
                anchors.fill: parent
                onClicked: {
                    if(paused) {// check if it is not already running , if not start running

                        // change state of canvas item to running
                        canvas.state = 'running';

                        // change container state to running
                        classroom.state = 'running'

                        classRoomSaita.state = 'running'

                        // open hand
                        hand.state = 'open'

                        if(!classroom.running)
                            Engine.applyForce();

                    }else if(classroom.running || gameFinish){

                        // apply a force to the saita
                        Engine.applyForce();
                    }
                    else if(!classroom.running && !paused && !collisionTimerRunning
                            && classroom.state !== 'preGameOver'){ // check if it is not already running , if not start running

                        // change canvas to state running
                        canvas.state = 'running';

                        // change container state to running
                        classroom.state = 'running'

                        //
                        classRoomSaita.state = 'running'

                        // open hand
                        hand.state = 'open'

                        // apply a force to the saita
                        Engine.applyForce();
                    }

                    // play stage tap sound
                    pageMain.audioController.playStageTapSoundEffect();
                }
            }
        }
    }

    Timer{
        id: startupTimer
        running: true
        interval: 10000

        onTriggered: stop()
    }

    StartText{
        id: startupText
        imagehelp1: "assets/images/start_help/start_text_1.png"
        imagehelp2: "assets/images/start_help/start_text_2.png"
        opacity: 1.0
        z: 20
        anchors.centerIn: parent
    }

    StartText{
        id: startupTextDrag
        imagehelp1: "assets/images/start_help/warning_drag_1.png"
        imagehelp2: "assets/images/start_help/warning_drag_2.png"
        opacity: startupTimer.running?1.0:0.0
        z: 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 80
    }

    StartText{
        id: startupTextInstantly
        imagehelp1: "assets/images/start_help/warning_instantly_1.png"
        imagehelp2: "assets/images/start_help/warning_instantly_2.png"
        opacity: startupTimer.running?1.0:0.0
        z: 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.bottomMargin: 140
        anchors.bottom: parent.bottom
    }

    StartText{
        id: startupTextCrashTop
        imagehelp1: "assets/images/start_help/warning.png"
        imagehelp2: "assets/images/start_help/warning_2.png"
        opacity: startupTimer.running?1.0:0.0
        z: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: worldClassroom.ceilingWallHeight + 36 - 5
        anchors.top: parent.top
    }

    Image{
        id: arrow1
        source: "../assets/images/start_help/arrowtop.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 35
        anchors.topMargin: worldClassroom.ceilingWallHeight
        anchors.top: parent.top
        z:21
        opacity: startupTextCrashTop.opacity
    }

    StartText{
        id: startupTextCrashBottom
        imagehelp1: "assets/images/start_help/warning.png"
        imagehelp2: "assets/images/start_help/warning_2.png"
        opacity: startupTimer.running?1.0:0.0
        z: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: worldClassroom.groundWallHeight + 36 + 71 - 5
        anchors.bottom: parent.bottom
    }

    StageProgressBar{
        id: stageProgressBar
        width: 200
        height: 8
        z:202
        anchors{ top: parent.top; topMargin: 45; horizontalCenter: parent.horizontalCenter }
        value: proportionValue * stageProgressBar.width
    }

    Image{
        id: arrow2
        source: "../assets/images/start_help/arrowbottom.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 35
        y:startupTextCrashBottom.y + 66
        opacity: startupTextCrashBottom.opacity
        z:21
    }

    BonusAnimation{
        id: bonusAnimation
        opacity: 0.0;
        z: 10;
    }

    // text showing the score
    Text{
        id: scoreText
        text: 'Score ' + classroom.score + 'm'
        font{ bold: true; family: canvas.localFont.name; pointSize: 18 }
        anchors { top: parent.top; topMargin: 31; right: parent.right; rightMargin: 6 }
        color: "#0036fb"
        z: 10
    }

    BonusPanel{
        id: bonusPanel
        width: 100
        height: 20
        z:10
        bonusText: 'x' + bonusCounter
        visible: bonusCounter > 0? true : false
        anchors{ top: parent.top; topMargin: 35; left: parent.left; leftMargin: 6 }
    }

    states:[
        State{
            name: "paused"
            StateChangeScript{ name: "pauseScript";
                script: {
                    classroom.paused =true;

                    classRoomSaita.active = false;
                    specialEffectTimerRunning = false;
                    pageMain.audioController.stopApplySpecialEffectSoundEffect();
                    pageMain.audioController.stopMusic();
                }
            }
            PropertyChanges { target: worldClassroom; running: false }
            PropertyChanges { target: mArea; enabled: true }
            PropertyChanges { target: startupText; opacity: 0.0 }
            PropertyChanges { target: classroom; running: false; collisionTimerRunning: false }
            PropertyChanges { target: shadowImage; visible: true }
        },State{
            name: "lost"
            StateChangeScript{ name: "lostScript";
                script: {
                    // firstly disable collision timer
                    collisionTimerRunning = false
                    // disable special effect running
                    // activate visible obstacles
                    Engine.stopSpecialEffect();
                    // set saita to lost state
                    classRoomSaita.state = 'lost'
                    // stop special effect sound effect
                    pageMain.audioController.playLostSoundEffect();
                    pageMain.audioController.stopMusic();
                    // disable mouse area
                    mArea.enabled = false
                    // enable rotatio for saita element
                    classRoomSaita.fixedRotation = false;

                    classroom.lost(score,bonusCounter)

                    console.log('finished lost state change script..')

                }
            }
            PropertyChanges { target: startupText; opacity: 0.0 }
            PropertyChanges { target: classroom; running: false; paused: false; gameFinish:gameFinish?true:false }
            PropertyChanges { target: shadowImage; visible: true }
        },State{
            name: "running"
            StateChangeScript{ name: "myScript";
                script: {
                    classroom.paused = false;

                    classRoomSaita.fixedRotation = true;
                    classRoomSaita.rotation = 0;
                    classRoomSaita.linearVelocity.x = saitaSpeed;

                    Engine.setGravityValue(Engine.gravityValues[canvas.difficultyLevel]);
                    collisionTimer.interval = Engine.collisionTimerValues[canvas.difficultyLevel]

                    classRoomSaita.active = true;

                    // activate the special effect timer if it was running before the pause button pushed
                    if(pb.active)
                    {
                        specialEffectTimerRunning = true;
                    }
                    else
                    {
                        specialEffectTimerRunning = false;
                    }

                    pageMain.audioController.playMusic();
                }
            }
            PropertyChanges { target: startupText; opacity: 0.0 }
            PropertyChanges { target: bonusPanel; state: 'finish' }
            PropertyChanges { target: worldClassroom; running: true }
            PropertyChanges { target: classroom; collisionTimerRunning:true; gameFinish: false; running: true }
            PropertyChanges { target: shadowImage; visible: false }
        },State{
            name: "preGameOver"

            PropertyChanges { target: classroom; collisionTimerRunning: true; gameFinish: true; paused: false }
            PropertyChanges { target: startupText; opacity: 0.0 }
            PropertyChanges { target: shadowImage; visible: false }
        },
        State{
            name: "gameOver"

            StateChangeScript{ name: "gameOverScript"; script: { pageMain.audioController.stopMusic(); classroom.gameOver(score,bonusCounter) } }

            PropertyChanges { target: classRoomSaita; active: false }
            PropertyChanges { target: worldClassroom; running: false }
            PropertyChanges { target: mArea; enabled: false }
            PropertyChanges { target: startupText; opacity: 0.0 }
            PropertyChanges { target: classroom; running: false; collisionTimerRunning: false; paused: true }
            PropertyChanges { target: shadowImage; visible: false }
        }
    ]
}
