#include "scoresutility.h"

#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>

#include <QtCore/QUrl>
#include <QtCore/QStringList>
#include <QtCore/QDebug>
#include <QtCore/QCryptographicHash>

const QString ScoresUtility::m_secret = QString::fromLatin1("cuD@mTVTpC_^A^9;Bv[]=CYvb1LkilPK7E");

const QString ScoresUtility::m_key = QString::fromLatin1("4eec6628563d8a7e2300006e");

const QString ScoresUtility::m_LEasyId      = QString::fromLatin1("4f169724563d8a240f00000b");
const QString ScoresUtility::m_LMediumId    = QString::fromLatin1("4f169734563d8a240f00000c");
const QString ScoresUtility::m_LExpertId    = QString::fromLatin1("4f16973b563d8a1cd10000b8");

ScoresUtility::ScoresUtility(QObject *parent) :
    QObject(parent)
{
    m_pQNetworkAccessManager = new QNetworkAccessManager(this);
}

void ScoresUtility::fetchScores(qint32 mode)
{
    QString urlpath;

    if(!mode) // easy
        urlpath = QString::fromLatin1("http://api2.mogade.com/api/gamma/scores?lid=%1&scope=3&page=1&records=50").arg(m_LEasyId);
    else if(mode == 1) // medium
        urlpath = QString::fromLatin1("http://api2.mogade.com/api/gamma/scores?lid=%1&scope=3&page=1&records=50").arg(m_LMediumId);
    else
        urlpath = QString::fromLatin1("http://api2.mogade.com/api/gamma/scores?lid=%1&scope=3&page=1&records=50").arg(m_LExpertId);

    disconnect(m_pQNetworkAccessManager,SIGNAL(finished(QNetworkReply*)),this,SLOT(onPostScoreFinished(QNetworkReply*)));
    connect(m_pQNetworkAccessManager,SIGNAL(finished(QNetworkReply*)),this,SLOT(onNetworkReply(QNetworkReply*)));

    m_pQNetworkAccessManager->get(QNetworkRequest(QUrl(urlpath)));
}

void ScoresUtility::saveScore(const QString &userkey, const QString &username, qint32 score, qint32 mode)
{
    QStringList list;
    list << QString("key") << m_key << QString("lid");
    if(!mode)
        list << m_LEasyId;
    else if(mode == 1)
        list << m_LMediumId;
    else
        list << m_LExpertId;
    list << QString("points") << QString::number(score) << QString("userkey") << userkey << QString("username") << username << m_secret;
    QString text = list.join(QString("|"));

    QByteArray hash = QCryptographicHash::hash(text.toUtf8(), QCryptographicHash::Sha1);

    disconnect(m_pQNetworkAccessManager,SIGNAL(finished(QNetworkReply*)),this,SLOT(onNetworkReply(QNetworkReply*)));
    connect(m_pQNetworkAccessManager,SIGNAL(finished(QNetworkReply*)),this,SLOT(onPostScoreFinished(QNetworkReply*)));

    QString content     = QString("lid=%1&key=%2&userkey=%3&username=%4&points=%5&sig=%6").arg(list.at(3)).arg(m_key).arg(userkey).arg(username).arg(QString::number(score)).arg(QString::fromUtf8(hash.toHex()));

    qDebug() << content;

    QString url         = QString("http://api2.mogade.com/api/gamma/scores");

    m_pQNetworkAccessManager->post(QNetworkRequest(QUrl(url)),content.toUtf8());
}

void ScoresUtility::onNetworkReply(QNetworkReply *reply)
{
    QString scoresText = reply->readAll();

    qDebug() << "Network reply text: " << scoresText;

    if(!scoresText.isEmpty())
        emit scoresFetched(scoresText);
}

void ScoresUtility::onPostScoreFinished(QNetworkReply *reply)
{
    QString scoresText = reply->readAll();

    qDebug() << "Network reply text: " << scoresText;

    if(!scoresText.isEmpty())
        emit scoreSaved(scoresText);
}
