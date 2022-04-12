#include "audioutility.h"

#include <QCoreApplication>

#include <QUrl>

AudioUtility::AudioUtility(QObject *parent) :
    QObject(parent)
{
    initialize();
}

void AudioUtility::initialize(){
    QString applicationpath;
    applicationpath = QCoreApplication::applicationDirPath();
    m_pStealth = new QSound(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/stageclassroom/audio/effects/stealth.wav")));
//    m_pStealth->setLoops(3);

    m_pBullet = new QSound(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/stageclassroom/audio/effects/bullet.wav")));
//    m_pBullet->setLoops(3);

    m_pNight = new QSound(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/stageclassroom/audio/effects/night.wav")));

    m_pApplySpecialEffect = new QMediaPlayer();
    m_pApplySpecialEffect->setMedia(QUrl::fromLocalFile(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/stageclassroom/audio/effects/applyspecialeffect.wav"))));
    m_pApplySpecialEffect->setVolume(80);

    m_pAppendBonus = new QSound(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/assets/audio/effects/bonus.wav")));

    m_pLost = new QSound(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/stageclassroom/audio/effects/lost.wav")));

    m_pStageTap = new QSound(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/stageclassroom/audio/effects/stagetap.wav")));

    m_pButtonTap = new QSound(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/assets/audio/effects/tap.wav")));

    m_pGameMusic = new QMediaPlayer();
    m_pGameMusic->setMedia(QUrl::fromLocalFile(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/assets/audio/music/vintage.mp3"))));
    connect(m_pGameMusic,SIGNAL(stateChanged(QMediaPlayer::State)),this,SLOT(onGameMusicStateChanged(QMediaPlayer::State)));
    m_pGameMusic->setVolume(80);

    m_pLostMusic = new QMediaPlayer();
    m_pLostMusic->setMedia(QUrl::fromLocalFile(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/assets/audio/music/lost.wav"))));
    m_pLostMusic->setVolume(90);

    m_pGameOverLoop = new QSound(QString("%1%2").arg(applicationpath).arg(QLatin1String("/qml/symbian/assets/audio/music/gameover.wav")));
    m_pGameOverLoop->setLoops(-1);

    m_soundEffectsEnabled = true;
    m_musicEnabled = true;
}

void AudioUtility::onGameMusicStateChanged(QMediaPlayer::State state){
    Q_UNUSED(state)
//    if(state == QMediaPlayer::StoppedState)
//        m_pGameMusic->play();
}

void AudioUtility::playAppendBonusItemSoundEffect(){
    if(m_soundEffectsEnabled){
        m_pAppendBonus->stop();
        m_pAppendBonus->play();
    }
}

void AudioUtility::playApplySpecialEffectSoundEffect(){
    if(m_soundEffectsEnabled){
        m_pApplySpecialEffect->stop();
        m_pApplySpecialEffect->play();
    }
}

void AudioUtility::playBulletSoundEffect(){
    if(m_soundEffectsEnabled){
        m_pBullet->stop();
        m_pBullet->play();
    }
}

void AudioUtility::playLostSoundEffect(){
    if(m_soundEffectsEnabled){
        m_pLost->stop();
        m_pLost->play();
    }
}

void AudioUtility::playNightSoundEffect(){
    if(m_soundEffectsEnabled){
        m_pNight->stop();
        m_pNight->play();
    }
}

void AudioUtility::playStageTapSoundEffect(){
    if(m_soundEffectsEnabled){
//        m_pStageTap->stop();
//        m_pStageTap->play();
    }
}

void AudioUtility::playStealthSoundEffect(){
    if(m_soundEffectsEnabled){
        m_pStealth->stop();
        m_pStealth->play();
    }
}

void AudioUtility::stopApplySpecialEffectSoundEffect(){
    m_pApplySpecialEffect->stop();
}

void AudioUtility::playGameMusic(){
    if(m_musicEnabled)
        m_pGameMusic->play();
}

void AudioUtility::stopGameMusic(){
    m_pGameMusic->stop();
}

void AudioUtility::pauseGameMusic(){
    m_pGameMusic->pause();
}

void AudioUtility::playGameOverLoop(){
    if(m_musicEnabled)
        m_pGameOverLoop->play();
}

void AudioUtility::stopGameOverLoop(){
    m_pGameOverLoop->stop();
}

void AudioUtility::playButtonTapSoundEffect(){
    if(m_soundEffectsEnabled){
        m_pButtonTap->stop();
        m_pButtonTap->play();
    }
}

void AudioUtility::playLostMusic(){
    if(m_musicEnabled)
        m_pLostMusic->play();
}

void AudioUtility::stopLostMusic(){
    m_pLostMusic->stop();
}
