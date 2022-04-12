#ifndef SCORESUTILITY_H
#define SCORESUTILITY_H

#include <QObject>

QT_BEGIN_NAMESPACE
    class QNetworkAccessManager;
    class QNetworkReply;
QT_END_NAMESPACE

class ScoresUtility : public QObject
{
    Q_OBJECT
public:
    explicit ScoresUtility(QObject *parent = 0);

    Q_INVOKABLE void fetchScores(qint32 );

    Q_INVOKABLE void saveScore(const QString &userkey, const QString &username, qint32 score, qint32 mode);

signals:

    void scoresFetched(const QString &scores);

    void scoreSaved(const QString &score);

public slots:

    void onNetworkReply(QNetworkReply* );

    void onPostScoreFinished(QNetworkReply* );

private:

    class QNetworkAccessManager *m_pQNetworkAccessManager;

    static const QString m_secret;

    static const QString m_key;

    static const QString m_LEasyId;
    static const QString m_LMediumId;
    static const QString m_LExpertId;

//    SHA1 m_SHA1;
};

#endif // SCORESUTILITY_H
