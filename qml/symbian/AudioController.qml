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
        stopMusic();
        stopAppendBonusItemSoundEffect();
        stopBulletSoundEffect();
        stopNightSoundEffect();
        stopStageTapSoundEffect();
        stopStealthSoundEffect();
        stopTapSoundEffect();
        classRoomMixer.enableAudio(false);
    }

    function startAudio(){
        classRoomMixer.enableAudio(true);
    }

    function playStealthSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            stealthSoundEffect.play()
    }

    function stopStealthSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            stealthSoundEffect.stop()
    }

    function playBulletSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            bulletSoundEffect.play();
    }

    function stopBulletSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            bulletSoundEffect.stop();
    }

    function playNightSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            nightSoundEffect.play();
    }

    function stopNightSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            nightSoundEffect.stop();
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

    function stopAppendBonusItemSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            appendBonusItem.stop();
    }

    function playLostSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            lostSoundEffect.play();
    }

    function playStageTapSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            stageTapSoundEffect.play();
    }

    function stopStageTapSoundEffect(){
        if(!pageMain.soundEffectsMuted)
            stageTapSoundEffect.stop();
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

    function stopTapSoundEffect(){
        if(!pageMain.soundEffectsMuted){
            tapSoundEffect.stop()
        }
    }

    function playGameOverMusic(){
        if(!pageMain.musicMuted)
            pageGameOverAudio.play();
    }

    function stopGameOverMusic(){
        if(!pageMain.musicMuted)
            pageGameOverAudio.stop();
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
    }
}
