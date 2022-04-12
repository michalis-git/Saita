#ifndef TRIALVERSIONUTILITY_H
#define TRIALVERSIONUTILITY_H

#include <QObject>
#include <QSettings>

class QmlApplicationViewer;

class TrialVersionUtility : public QObject
{
    Q_OBJECT
public:
    explicit TrialVersionUtility(QObject *parent = 0);
    ~TrialVersionUtility();

    Q_INVOKABLE bool isExpired(){ return expired; }

    Q_INVOKABLE int daysLeft() { return m_daysLeft; }

    Q_INVOKABLE void useTrial();

    void initialize();
    
signals:
    void appExpired();
    
public slots:

private:
    QSettings *m_pQSettings;

    int m_daysLeft;

    bool expired;

    QmlApplicationViewer *m_pQmlApplicationViewer;
    
};

#endif // TRIALVERSIONUTILITY_H
