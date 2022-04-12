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

var EXTRAS_TYPE_STEALTH = 1;
var EXTRAS_TYPE_BULLET = 2;
var EXTRAS_TYPE_BONUS = 11;
var EXTRAS_TYPE_NIGHT = 21;
var SPRITEINACTIVESTATE = 'inActive'

var sprites = new Array(); // an array holding all worldClassroom body item - foreground elements
var backgroundItems = new Array(); // an array holding all background items - elements
var extrasArray  = new Array(); // an array holding all bonus items

// gameplay parameters
var speedValues = new Array(200,270,340); // easy [200] , medium[270] , expert[340]
var gravityValues = new Array(-5,-7,-9) // easy [-5] , medium [-7] , expert[-9]
var forceValues = new Array(43,54,62); // easy [53] , medium [63] , expert[73]
var spriteOffsetValues = new Array(1.2,1.45,1.7);
var scoreAnimationDurations = new Array(800,800,800);
var backgroundLevel3OffsetValues = new Array(2,3,4); // this is the translation values for each corresponding difficulty level of the level 3 background
var backgroundLevel2OffsetValues = new Array(1,2,3); // this is the translation values for each corresponding difficulty level of the level 2 background
var backgroundLevel1OffsetValues = new Array(0,0,0); // this is the translation values for each corresponding difficulty level of the level 1 background
var helperArray1 = new Array(850,850,850); // used to fine tune the 1st background level element when worldClassroom advances
var helperArray2 = new Array(350,350,350); // used to fine tune the 2nd background level element when worldClassroom advances
var collisionTimerValues = new Array(225,180,135); // used to calculate collission detection
var specialEffectDurationValues = new Array(11,9,7);

var spritestate = ''
var force = 60;
var specialeffecttype = ''
var spriteoffset = 1.7;
var bonusChanceValue = 4;
var penaltyChanceValue = 4;
var specialEffectChanceValue = 9;

// get current gravity value depending on the selected difficulty level
function getGravityValue(){
    return gravityValues[canvas.difficultyLevel]
}

function setGravityValue(val){
    worldClassroom.gravity = Qt.point(0,val);
}

function setSaitaSpeed(val){
    saitaSpeed = val;
    classRoomSaita.linearVelocity = Qt.point(val,classRoomSaita.linearVelocity.y);
}

function setCurrentForce(val){
    force = val;
}

function getCurrentForce(){
    return force;
}

function getForegroundRightBorderX(){
    var object = sprites[sprites.length-1];
    if(object!= null)
        return object.x+object.width;

    return -1;
}

function getBackgroundRightBorderX(){
    var object = backgroundItems[backgroundItems.length-1];
    if(object != null){
        return object.x+object.width;
    }

    return -1;
}

// apply a force towards the possitive y-axes in order to lift the saita
function applyForce(){

    // get the velocity towards the y-axes
    var linearYVelocity = classRoomSaita.linearVelocity.y;

    if(linearYVelocity > 50) {// check whether the glinder has a velocity greater than 50..
        classRoomSaita.applyLinearImpulse(Qt.point(0,-force),Qt.point(classRoomSaita.x + classRoomSaita.width/2,classRoomSaita.y+classRoomSaita.height/2));
    }
    else if(linearYVelocity <= 50 && linearYVelocity > - 50){ // if the linear velocity towards the y axes is less than zero, then apply only one third of the original impulse
        // apply less linear than normal impulse
        classRoomSaita.applyLinearImpulse(Qt.point(0,-force/1.5),Qt.point(classRoomSaita.x + classRoomSaita.width/2,classRoomSaita.y+classRoomSaita.height/2));
    }
    else{
        // apply less linear than normal impulse
        classRoomSaita.applyLinearImpulse(Qt.point(0,-force/3),Qt.point(classRoomSaita.x + classRoomSaita.width/2,classRoomSaita.y+classRoomSaita.height/2));
    }
}

function applyStealthEffect(){
    // set the timer to false
    specialEffectTimerRunning  = false;

    spritestate = SPRITEINACTIVESTATE;

    // inactivate visible objects
    inActivateVisibleObstacles();

    classRoomSaita.state = 'stealth'

    pageMain.audioController.playStealthSoundEffect();

    // reset the progressbar value
    pb.reset();
    // start the simple timer
    specialEffectTimerRunning  = true;
}

function applyBulletEffect(){
    // set the timer to false
    specialEffectTimerRunning  = false;

    // inactivate visible objects
    inActivateVisibleObstacles();

    classRoomSaita.state = 'bullet'

    // sprite creation process offset
    spriteoffset = 2.5*spriteoffset;

    pageMain.audioController.playBulletSoundEffect();

    // reset the progressbar value
    pb.reset();
    // start the simple timer
    specialEffectTimerRunning  = true;
}

function applyNightEffect(){
    // set the timer to false
    specialEffectTimerRunning  = false;

    pageMain.audioController.playNightSoundEffect();

    // reset the progressbar value
    pb.reset();
    // start the simple timer
    specialEffectTimerRunning  = true;

    activateNightElement();
}

function activateNightElement(){
    nightImage.opacity = 1;
}

function inActivateNightElement(){
    nightImage.opacity = 0;
}

// set all visible objects in-active
function inActivateVisibleObstacles(){
    var bottomLimit = flickable.contentX;
    var topLimit = forwardOffset;

    var object;

    for(var i = 0; i < sprites.length; i++){
        object = sprites[i];

        if(object != null)
        {
            // just make it inactive
            object.state = 'inActive';
        }
    }
}

// set all visible objects in-active
function activateVisibleObstacles(){
    var bottomLimit = flickable.contentX;
    var topLimit = forwardOffset;

    var object;

    for(var i = 0; i < sprites.length; i++){
        object = sprites[i];

        if(object != null)
        {
            // just make it inactive
            object.state = 'active';
        }
    }
}

// apply special effect
function applySpecialEffect(){

    if(specialeffecttype == EXTRAS_TYPE_STEALTH)
        applyStealthEffect();
    else if(specialeffecttype == EXTRAS_TYPE_BULLET)
        applyBulletEffect();
    else if(specialeffecttype == EXTRAS_TYPE_NIGHT)
        applyNightEffect();

    // start the sound effect
    pageMain.audioController.playApplySpecialEffectSoundEffect();
}

// apply special effect
function stopSpecialEffect(){
    pb.stop();
    pageMain.audioController.stopApplySpecialEffectSoundEffect();

    if(specialeffecttype == EXTRAS_TYPE_STEALTH){
        classRoomSaita.state = 'running'
        activateVisibleObstacles();
        spritestate = ''
    }else if(specialeffecttype == EXTRAS_TYPE_BULLET){
        classRoomSaita.state = 'running'
        spriteoffset = spriteOffsetValues[canvas.difficultyLevel];
        setSaitaSpeed(speedValues[canvas.difficultyLevel]);
    }else if(specialeffecttype == EXTRAS_TYPE_NIGHT){
        inActivateNightElement();
    }

    specialEffectTimerRunning = false
}

function setupCurrentForce(){
    // sepup current force value by difficulty level
    force = forceValues[canvas.difficultyLevel];
}

// clear extras items
function clearExtrasElements(max){
    var obj = 0;

    // a helper variable
    var indexX = 0;

    // delete and destroy bonuns elements
    for(var i = 0; i < extrasArray.length; i++){
        obj = extrasArray[i];
        if(obj != null){
            indexX = obj.x + obj.width;
            if(indexX <= max){
                // remove the element from the extras array
                // splice the array.
                extrasArray.splice(i,1);
                i--;

                // destroy the extras object from canvas
                obj.visible = false;
                obj.source = "";
                obj.destroy();
            }
        }
    }
}

// clear sprite elements
function clearSpriteElements(max){
    var obj = 0;

    var indexX = 0;

    // delete and destroy sprite elements
    for (var i = 0; i < sprites.length; i++) {
        obj = sprites[i];
        if (obj != null) // check whether the sprite object has a position with a x coordinate less than a max value
        {
            indexX = obj.x + obj.width;
            if(indexX <= max){
                // remove the item from the array
                // splice the array, namely remove 1 item at index i
                sprites.splice(i,1);
                i--;

                obj.visible                         = false;
                obj.image                           = ""; // workaround to avoid leak
                obj.destroy();
            }
        }
    }
}

//clear background items
function clearBackgroundElements(max){
    var obj = 0;

    // a helper variable
    var indexX = 0;

    // delete and destroy background elements
    for (var i = 0; i < backgroundItems.length; i++) {
        obj = backgroundItems[i];
        if (obj != null)
        {
            indexX = obj.x + obj.width;

            if(indexX <= max) // check whether the background object has a position with a x coordinate less than a max value
            {
                // remove the item from the array
                // splice the array, namely remove 1 item at index i
                backgroundItems.splice(i,1);
                i--;

                // destroy backgroun item
                obj.visible                         = false;
                obj.source                          = ""; // work around to avoid leak
                obj.destroy();
            }
        }
    }
}

/*
  Delete all scene sprites and reset scene parameters.
*/
function reset(){

    // setup force values
    setupCurrentForce();

    // reset speed value
    saitaSpeed = speedValues[canvas.difficultyLevel];

    spriteoffset = spriteOffsetValues[canvas.difficultyLevel];

    // close hand
    hand.state = ''

    // reset saita values
    classRoomSaita.rotation = 0;
    classRoomSaita.linearVelocity.x = 0;
    classRoomSaita.linearVelocity.y = 0;
    classRoomSaita.x = hand.width-55
    classRoomSaita.y = classroom.height / 2 - saita.height
    classRoomSaita.z = 200;
    classRoomSaita.state = ''
    classRoomSaita.active = false;

    startupTimer.restart()

    // reset score and bonus items
    score = 0;
    bonusCounter = 0;

    //reset background x
    backgroundLevel1.x = 0;
    backgroundLevel2.x = 0;
    backgroundLevel3.x = 0;
    background3TranslateValue = 0;
    background2TranslateValue = 0;
    background1TranslateValue = 0;
    backgroundLevel1OffsetValue = backgroundLevel1OffsetValues[canvas.difficultyLevel];
    backgroundLevel2OffsetValue = backgroundLevel2OffsetValues[canvas.difficultyLevel];
    backgroundLevel3OffsetValue = backgroundLevel3OffsetValues[canvas.difficultyLevel];
    backgroundRightBorderX = 0;

    // reset score animation durations
    bonusAnimation.animationDuration = scoreAnimationDurations[canvas.difficultyLevel];

    // clear all background and sprite elements
    clearBackgroundElements(flickable.contentWidth);
    clearSpriteElements(flickable.contentWidth);
    clearExtrasElements(flickable.contentWidth);
}

function appendBonus(bonus){

    var path                = bonus.source;
    var bonusType           = bonus.extrasType;

    // grab the bonus coordinates
    bonusAnimation.x = canvas.mapFromItem(worldClassroom,bonus.x,bonus.y).x;
    bonusAnimation.y = canvas.mapFromItem(worldClassroom,bonus.x,bonus.y).y;

    // reset bonus properties and destroy object
    bonus.visible           = false;
    bonus.source            = ""
    bonus.destroy();

    // start bonus score animation
    bonusAnimation.show();
}

// create background items
function createBackgroundElements(){
    if(level >= levelModel.count)
        return;

    var object = 0;
    var width = 0;
    var height = 0;

    // get the max number
    var maxNo                               = levelModel.get(level).background.count;

    var parentObject = null;
    var level1Object = null;
    var level2Object = null;
    var level3Object = null;
    var bX = 0;

    var saitaOffsetX1 = 0;
    var saitaOffsetX2 = 0;

    if(classroom.running)
    {
        saitaOffsetX1 = helperArray1[canvas.difficultyLevel];
        saitaOffsetX2 = helperArray2[canvas.difficultyLevel];
    }


    // iterate through background model data

    for(var j = 0; j < maxNo; j++){ // iterate through the children items
        parentObject                            = levelModel.get(level).background.get(j);

        // level1Object
        if(parentObject.level1 !== '')
        {
            level1Object                        = parentObject.level1.get(0);

            width                               = Math.round(level1Object.width);
            height                              = Math.round(level1Object.height);

            bX                                  = backgroundLevel3.mapToItem(backgroundLevel1,backgroundRightBorderX-saitaOffsetX1,0).x;

            // create background element
            object                              = backgroundLevel1.createItem(level1Object.path, bX, 0,width,height);

            // add it to the backgroundItems array
            backgroundItems.push(object);
        }

        // level2Object

        if(parentObject.level2 !== '')
        {
            level2Object                        = parentObject.level2.get(0);

            width                               = Math.round(level2Object.width);
            height                              = Math.round(level2Object.height);

            bX                                  = backgroundLevel3.mapToItem(backgroundLevel2,backgroundRightBorderX-saitaOffsetX2,0).x;

            // create background element
            object                              = backgroundLevel2.createItem(level2Object.path, bX, 0,width,height);

            // add it to the backgroundItems array
            backgroundItems.push(object);
        }

        // level3Object
        if(parentObject.level3 !== '')
        {
            level3Object                        = parentObject.level3.get(0);

            width                               = Math.round(level3Object.width);
            height                              = Math.round(level3Object.height);

            // create background element
            object                              = backgroundLevel3.createItem(level3Object.path, backgroundRightBorderX, 0,width,height);

            // add it to the backgroundItems array
            backgroundItems.push(object);
        }

        // advance the backgroundRightBorderX with the width value
        backgroundRightBorderX += width;
    }
}

function createSpriteItem(componentpath,x){
    var component       = Qt.createComponent(Qt.resolvedUrl(componentpath));
    if(component.status == Component.Ready){
        var object      = component.createObject(worldClassroom);

        // set properties
        object.state    = spritestate;
        object.x        = x;
        object.z        = 200;

        return object;
    }else{
        console.log(component.errorString())

        return null;
    }
}

// create worldClassroom items
function createSpriteAndExtrasElements(){
    if(level >= levelModel.count)
        return;

    var object                              = 0;
    var componentpath                       = "NOT SET";
    var parentitem                          = 0;
    var maxNo                               = 0;
    var randomIndex                         = 0;
    var topLimit                            = 0;
    var bottomLimit                         = 0;
    var spritesitem                         = 0;
    var topLimitOffsetParameter             = 200;
    var lastObject                          = 0;
    var randomX                             = -1;
    var randomY                             = -1;

    lastObject                              = sprites[sprites.length-1];
    if(lastObject == null){

        bottomLimit                         = canvas.width/ 1.5;

        topLimit                            = bottomLimit + topLimitOffsetParameter;

        randomX                             = Math.round(Math.random() * (topLimit - bottomLimit)) + bottomLimit;

        spritesitem                         = levelModel.get(level).sprites;

        // get a random index between 0 - foregroundModel.count values
        randomIndex                         = Math.floor(Math.random()*(spritesitem.count));

        // get the parent ListElement
        parentitem                          = spritesitem.get(randomIndex);

        // get the number of child items of the parentitem
        maxNo                               = parentitem.items.count;

        // iterate through the children of the parentitem
        for(var i = 0; i < maxNo; i++){
            // get the path and the path to the component QML file
            componentpath                   = parentitem.items.get(i).componentpath;

            // create the foreground object
            object                          = createSpriteItem(componentpath,randomX);

            // add it the array
            sprites.push(object);
        }
    }
    else{
        // set the bottom limit equal to the lastObject x coordinate plus a parameter
        bottomLimit                         = lastObject.x + lastObject.width + (lastObject.height * spriteoffset);

        // set the top limit equal to the bottomLimit plus an offset of 200
        topLimit                            = bottomLimit + topLimitOffsetParameter;

        randomX                             = Math.round(Math.random() * (topLimit - bottomLimit)) + bottomLimit;

        spritesitem                         = levelModel.get(level).sprites;

        // get a random index between 0 - foregroundModel.count values
        randomIndex                         = Math.floor(Math.random()*(spritesitem.count));

        // get the parent ListElement
        parentitem                          = spritesitem.get(randomIndex);

        // get the number of child items of the parentitem
        maxNo                               = parentitem.items.count;

        // iterate through the children of the parentitem
        for(var j = 0; j < maxNo; j++){
            // get the path and the path to the component QML file
            componentpath                   = parentitem.items.get(j).componentpath;

            // create the foreground object
            object                          = createSpriteItem(componentpath,randomX);

            // add it the array
            sprites.push(object);
        }

        // check randomly if there should be created a special effect item
        randomIndex = Math.floor(Math.random()*specialEffectChanceValue);
        if(!randomIndex) // if it is zero then create , the chance of creating an extras item equals to 1 / specialEffectChanceValue
        {
            // create extras item
            randomX                         = lastObject.x + lastObject.width + ((object.x - lastObject.x - lastObject.width)/2);
            randomY                         = Math.round(Math.random()*150)+canvas.height/2-50;

            randomIndex                     = Math.floor(Math.random()*2) + 1;

            object                          = createSpecialEffectItem(randomX,randomY,randomIndex);

            // add the item
            extrasArray.push(object);
        }else{
            randomIndex = Math.floor(Math.random()*bonusChanceValue);
            if(!randomIndex) // if it is zero then create , the chance of creating an extras item equals to 1 / bonusChanceValue
            {
                // create extras item
                randomX                     = lastObject.x + ((object.x - lastObject.x - lastObject.width)/2);
                randomY                     = Math.round(Math.random()*150)+canvas.height/2-70;

                // create a extras item if distance is greater than extras slice
                object                      = createBonusItem(randomX,randomY);

                // add the item
                extrasArray.push(object);
            }else{
                randomIndex = Math.floor(Math.random()*penaltyChanceValue);
                if(!randomIndex){
                    // create extras item
                    randomX                     = lastObject.x + ((object.x - lastObject.x - lastObject.width)/2);
                    randomY                     = Math.round(Math.random()*150)+canvas.height/2-70;

                    // create a extras item if distance is greater than extras slice
                    object                      = createPenaltyItem(randomX,randomY);

                    // add the item
                    extrasArray.push(object);
                }
            }
        }
    }

    classroom.foregroundRightBorderX = object.x+object.width;
}

function createSpecialEffectItem(x,y,setype){
    var component = 0;

    if(setype == EXTRAS_TYPE_STEALTH){
        component           = Qt.createComponent(Qt.resolvedUrl("extras/SpecialEffectStealth.qml"));
    }else{
        component           = Qt.createComponent(Qt.resolvedUrl("extras/SpecialEffectBullet.qml"))
    }

    if(component.status == Component.Ready){
        var object          = component.createObject(worldClassroom);

        object.x            = x;
        object.y            = y;
        object.z            = 150;

        return object;
    }else{
        console.log(component.errorString())

        return null;
    }
}

function createPenaltyItem(x,y,ptype){
    var component = 0;

    component               = Qt.createComponent(Qt.resolvedUrl("extras/PenaltyEffectNight.qml"));

    if(component.status == Component.Ready){
        var object          = component.createObject(worldClassroom);

        object.x            = x;
        object.y            = y;
        object.z            = 150;

        return object;
    }else{
        console.log(component.errorString())

        return null;
    }
}

function createBonusItem(x,y){
    var component           = Qt.createComponent(Qt.resolvedUrl("extras/Bonus.qml"));

    if(component.status == Component.Ready){
        var object          = component.createObject(worldClassroom);

        object.x            = x;
        object.y            = y;
        object.z            = 150;

        return object;
    }else{
        console.log(component.errorString())

        return null;
    }
}

function advanceBackgroundElements(){
    // firstly clear any passed background elements
    clearBackgroundElements(canvas.mapToItem(backgroundLevel3,0,0).x);

    if(level < levelModel.count)
        // then create the background elements
        createBackgroundElements();
}

// advance classroom components
function advanceForegroundElements(){
    clearSpriteElements(flickable.contentX);
    clearExtrasElements(flickable.contentX);

    // check whether this the game end..
    if(level < levelModel.count)
    // create foreground and extras elements
        createSpriteAndExtrasElements();
}

/*
  Start the game..
*/
function start(){
    // create background and sprite elements
    createBackgroundElements();
    createSpriteAndExtrasElements();
}

// Restart the game
function restartGame(){
    // firstly reset game parameters
    reset()

    // start the game
    start()
}

/*
  Handle saita collisions with extras items.
*/
function checkCollisions()
{
    var obj, collides = 0;

    var saitaRightX = classRoomSaita.x + classRoomSaita.width;
    var saitaBottomY = classRoomSaita.y + classRoomSaita.height;

    var extrasType = -1;

    // check collision with all scene sprites
    for (var i = 0; i < extrasArray.length; i++) {
        obj = extrasArray[i];

        // check for simple bounding rect collision
        collides = (classRoomSaita.x < obj.x + obj.width) && (classRoomSaita.y < obj.y + obj.height)
                && (saitaRightX > obj.x) && (saitaBottomY > obj.y);

        if (collides) {

            // remove the extras from the array
            extrasArray.splice(i,1);
            // decrease the counter value
            i--;

            // get the extras type
            extrasType = obj.extrasType;

            if(extrasType == EXTRAS_TYPE_BONUS) // bonus type extras
            {
                appendBonus(obj);
            }
            else // special effect type extras
            {
                stopSpecialEffect();

                specialeffecttype = extrasType;

                applySpecialEffect();

                // reset specialEffect properties and destroy object
                obj.visible           = false;
                obj.source            = ""
                obj.destroy();
            }

            return;
        }
    }
}

// tick called by a timer trigger
function tick(){

    if(isLost())
        return;

    var forwardLayerOffsetX = classRoomSaita.x + ((4*canvas.width)/5)

    if(forwardLayerOffsetX >= classroom.foregroundRightBorderX) // check if it is time for an update
        advanceForegroundElements();

    var offsetX = canvas.mapToItem(backgroundLevel3,canvas.width,0).x;

    if(offsetX >= backgroundRightBorderX)
        advanceBackgroundElements();

    // check for collissions
    checkCollisions();

}

function isLost(){
    if(classRoomSaita.linearVelocity.x < saitaSpeed){
        // change container state to lost
        classroom.state = 'lost';

        // change canvas state to lost
        canvas.state = 'lost'

        return true;
    }

    return false;
}

// advance level
function advanceLevel(){

    console.log('stage changed level : ' + level)

    // check if there is the end of the game
    if(classroom.level >= levelModel.count && classroom.level > 0){
        // set main state
        classroom.state = 'preGameOver'
    }
}
