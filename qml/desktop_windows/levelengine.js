var currentLevel = null;

function createLevel(path) {
    deleteCurrentLevel()

    var component = Qt.createComponent(path);

    if(component.status == Component.Ready){
        currentLevel = component.createObject(levelView);

        currentLevel.lost.connect(onLost);
        currentLevel.win.connect(onWin);
        console.log('created level , path : ' + path);

    }else
        console.log('component.errorString() : ' + component.errorString())
}

function deleteCurrentLevel(){
    if(currentLevel != null){
        console.log('destroying currentLevel ..')
        currentLevel.destroy();
    }
}

function restartGame(){
    if(currentLevel != null)
        currentLevel.restartGame()
}

function pauseGame(){
    if(currentLevel != null)
        currentLevel.state = 'paused'
}

function resumeGame(){
    if(currentLevel != null){
        currentLevel.state = 'running'
        currentLevel.saita.state = 'running'
    }
}

function currentLevel(){
    return currentLevel;
}

function onWin(lId,bVal){
    winMenu.bonusItems = bVal;
    winMenu.currentLevel = lId;
}

function onLost(lId,bVal){
    lostMenu.levelId = lId;
    lostMenu.bonusItems = bVal;
}
