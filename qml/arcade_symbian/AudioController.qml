// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtMultimediaKit 1.1
import GEAudio 1.0

Item{
    id: audioController

    property string specialeffectsource: "audio/effects/applyspecialeffect.wav"
    property int specialeffectloops: 1

    function stopAudio(){
        stopApplySpecialEffectSoundEffect();
        stopGameOverMusic();
        stopLostMusic();
        stopWinMusic();
        classRoomMixer.enableAudio(false);
    }

    function startAudio(){
        classRoomMixer.enableAudio(true);
    }

    function playStealthSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            stealthSoundEffect.play()
    }

    function playBulletSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            bulletSoundEffect.play();
    }

    function playNightSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            nightSoundEffect.play();
    }

    function playApplySpecialEffectSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            applySpecialEffectSoundEffect.play();
    }

    function stopApplySpecialEffectSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            applySpecialEffectSoundEffect.stop();
    }

    function playAppendBonusItemSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            appendBonusItem.play();
    }

    function playLostSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            lostSoundEffect.play();
    }

    function playStageTapSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            stageTapSoundEffect.play();
    }

    function playMusic(){
        if(!pageMain.musicMuted){
            music.play();
        }
    }

    function playLostMusic(){
        if(!pageMain.musicMuted)
            lostMusicAudio.play();
    }

    function stopLostMusic(){
        lostMusicAudio.stop();
    }

    function stopMusic(){
        music.stop();
    }

    function playTapSoundEffect(){
        if(!pageMain.soundEffectsMuted){
            tapSoundEffect.play()
        }
    }

    function playGameOverMusic(){
        if(!pageMain.musicMuted)
            pageGameOverAudio.play();
    }

    function stopGameOverMusic(){
//        if(!pageMain.musicMuted)
            pageGameOverAudio.stop();
    }

    function playWinMusic(){
        if(!pageMain.musicMuted){
            winAudio.play()
        }
    }

    function stopWinMusic(){
//        if(!pageMain.musicMuted){
            winAudio.stop()
//        }
    }

    function playSrinkSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            bulletSoundEffect.play()
    }

    function playScissorsSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            scissorsEffect.play()
    }

    function playLampSqueekSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            lampSqueekEffect.play()
    }

    function playLampCrashSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            lampCrashEffect.play()
    }

    function playBounceSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            bounceEffect.play();
    }

    function playSlowSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            slowDownEffect.play()
    }

    AudioMixer {
        id: classRoomMixer
        absoluteVolume: 1.0
        enabled: true

        AudioBuffer {
            id: stealthSoundEffect
            source: ":/audio/effects/stealth.wav"
            loopCount: 2
        }

        AudioBuffer {
            id: bulletSoundEffect
            source: ":/audio/effects/bullet.wav"
            loopCount: 2
        }

        AudioBuffer {
            id: nightSoundEffect
            source: ":/audio/effects/night.wav"
        }

        AudioBuffer {
            id: applySpecialEffectSoundEffect
            source: ":/audio/effects/applyspecialeffect.wav"
            loopCount: 2
        }

        AudioBuffer {
            id: appendBonusItem
            source: ":/audio/effects/bonus.wav"
        }

        AudioBuffer {
            id: stageTapSoundEffect
            source: ":/audio/effects/stagetap.wav"
        }

        AudioBuffer {
            id: lostSoundEffect
            source: ":/audio/effects/lost.wav"
        }

        AudioBuffer {
            id: tapSoundEffect
            source: ":/audio/effects/tap.wav"
        }

        AudioBuffer{
            id: scissorsEffect
            source: ":/audio/effects/scissors.wav"
        }

        AudioBuffer{
            id: bounceEffect
            source: BounceSource
        }

        AudioBuffer{
            id: lampSqueekEffect
            source: LampSqueekSource
        }

        AudioBuffer{
            id: lampCrashEffect
            source: LampCrashSource
        }

        AudioBuffer{
            id: slowDownEffect
            source: SlowDownSource
        }

        AudioBuffer {
            id: music
            source: GamePlayMusicSource
            loopCount: 10
        }

        AudioBuffer {
            id: lostMusicAudio
            source: LostMusicSource
        }

        AudioBuffer {
            id: pageGameOverAudio
            source: GameOverMusicSource
            loopCount: 100
        }

        AudioBuffer{
            id: winAudio
            source: WinMusicSource
        }
    }
}