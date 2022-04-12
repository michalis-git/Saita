#ifndef XMLUTILITY_H
#define XMLUTILITY_H

#include <QObject>

class XmlUtility : public QObject
{
    Q_OBJECT
public:
    explicit XmlUtility(QObject *parent = 0) : QObject(parent){ }
    
    //! unlocks the next level
    Q_INVOKABLE void setLevelState(const QString&, qint32 id,qint32 state);

    //! unlocks the next level
    Q_INVOKABLE void setApplesValue(const QString&, qint32 id,qint32 val);

    //! locks all levels except the first one
    Q_INVOKABLE void resetDatabase();

    //! increase the badges collected value for the specified class file
    Q_INVOKABLE void increaseBadge(const QString& );

    Q_INVOKABLE void setGrade(const QString&, double );

    Q_INVOKABLE void unlockNextClass( );

signals:

    void levelUnlocked(qint32 id);

    void applesChanged();

    void databaseReseted();

    void dbResetFailed(const QString &error);

    void unlockFailed(const QString &error);

    void badgesChanged(const QString &classname);

    void classUnlocked();

    void classUnlockFailed(const QString &error);

    void gradeChanged(const QString &classname);

public slots:
    
};

#endif // XMLUTILITY_H
