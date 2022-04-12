#ifndef AUDIOUTILITY_H
#define AUDIOUTILITY_H

#include <QObject>

#include <QSound>

#include <QMediaPlayer>

#include <QAudioOutput>
#include <QFile>

class AudioUtility : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool soundEffectsEnabled READ soundEffectsEnabled WRITE setSoundEffectsEnabled NOTIFY soundEffectsEnabledChanged)
    Q_PROPERTY(bool musicEnabled READ musicEnabled WRITE setMusicEnabled NOTIFY musicEnabledChanged)
public:

    bool soundEffectsEnabled(){ return m_soundEffectsEnabled; }
    void setSoundEffectsEnabled(bool val){ m_soundEffectsEnabled = val; }

    bool musicEnabled(){ return m_musicEnabled; }
    void setMusicEnabled(bool val){ m_musicEnabled = val; }

    explicit AudioUtility(QObject *parent = 0);

    Q_INVOKABLE void playStealthSoundEffect();

    Q_INVOKABLE void playBulletSoundEffect();

    Q_INVOKABLE void playNightSoundEffect();

    Q_INVOKABLE void playApplySpecialEffectSoundEffect();

    Q_INVOKABLE void stopApplySpecialEffectSoundEffect();

    Q_INVOKABLE void playAppendBonusItemSoundEffect();

    Q_INVOKABLE void playLostSoundEffect();

    Q_INVOKABLE void playStageTapSoundEffect();

    Q_INVOKABLE void playLostMusic();

    Q_INVOKABLE void stopLostMusic();

    Q_INVOKABLE void playGameOverLoop();

    Q_INVOKABLE void stopGameOverLoop();

    Q_INVOKABLE void playGameMusic();

    Q_INVOKABLE void playButtonTapSoundEffect();

    Q_INVOKABLE void stopGameMusic();

    Q_INVOKABLE void pauseGameMusic();
    
signals:
    void soundEffectsEnabledChanged();
    void musicEnabledChanged();

public slots:
    void onGameMusicStateChanged(QMediaPlayer::State);


private:
    void initialize();

    QSound *m_pStealth;

    QSound *m_pBullet;

    QSound *m_pNight;

    QSound *m_pAppendBonus;

    QSound *m_pLost;

    QSound *m_pStageTap;

    QSound *m_pButtonTap;

    QMediaPlayer *m_pLostMusic;

    QMediaPlayer *m_pGameMusic;

    QMediaPlayer *m_pApplySpecialEffect;

    QSound *m_pGameOverLoop;

    bool m_soundEffectsEnabled;
    bool m_musicEnabled;
    
};

#endif // AUDIOUTILITY_H
