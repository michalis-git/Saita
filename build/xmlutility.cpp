#include "xmlutility.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QDir>
#include <QDomDocument>

#include <QUrl>

#include <QCoreApplication>

void XmlUtility::setLevelState(const QString& filename, qint32 id, qint32 state)
{
//    QString path;

//    path.append(QCoreApplication::applicationDirPath()).append(QDir::separator());

//#ifdef Q_OS_WIN
//    path.append("../");
//    path.append(QLatin1String("qml/desktop_windows/"));
//#elif defined(HARMATTAN)
//    path.append(QLatin1String("qml/harmattan/"));
//#elif defined(SYMBIAN)
//    path.append(QLatin1String("qml/symbian/"));
//#elif defined(ARCADE_SYMBIAN)
//    path.append(QLatin1String("qml/arcade_symbian/"));
//#elif defined(ARCADE_HARMATTAN)
//    path = QLatin1String("/opt/saita2/qml/arcade_harmattan/"));
//#endif

//    path.append(filename);

    QUrl url(filename);

    QFile file(url.toLocalFile());
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "could not open the file : \n" << url.toLocalFile();

        emit unlockFailed(QString("Unlock failed <br/>Could not open the file : %1").arg(url.toLocalFile()));

        return;
    }

    QDomDocument doc;
    if(!doc.setContent(&file))
    {
        qDebug() << "Could not set content";

        emit unlockFailed(QString("Unlock failed <br/>Could not set content"));

        return;
    }

    file.close();

    //! get the tag
    QDomNodeList list = doc.elementsByTagName(QString("levels"));
    if(list.isEmpty())
    {
        qDebug() << "could not find level tag";

        emit unlockFailed(QString("Unlock failed <br/>Could not find game tag"));

        return;
    }
    //! iterate through the categories tag
    QDomNode node = list.at(0);
    QDomNode child = node.firstChild();

    while(!child.isNull())
    {
        QDomElement cElement = child.toElement();

        // the id of the next level will be the id parameter added 1, as the id is actually an increment value
        if( cElement.attribute("id").toInt() == id+1 /*&& !cElement.attribute("lockedstate").toInt()*/)
        {
            // set locked state to 1, namely this level is now unlocked
            cElement.setAttribute("lockedstate",state);

            //! saving start here

            if (file.open(QIODevice::WriteOnly))
            {
                QTextStream out(&file);
                out << doc.toString(4);
                file.close();

                if(state == 0)
                    emit levelUnlocked(id+1);

                break;
            }
        }

        child = child.nextSibling();
    }
}

void XmlUtility::unlockNextClass(){
    QString path;

    path.append(QCoreApplication::applicationDirPath()).append(QDir::separator());

#ifdef Q_OS_WIN
    path.append("../");
    path.append(QLatin1String("qml/desktop_windows/"));
#elif defined(HARMATTAN)
    path.append(QLatin1String("qml/harmattan/"));
#elif defined(SYMBIAN)
    path.append(QLatin1String("qml/symbian/"));
#elif defined(ARCADE_SYMBIAN)
    path.append(QLatin1String("qml/arcade_symbian/"));
#elif defined(ARCADE_HARMATTAN)
    path = QLatin1String("/opt/saita2/qml/arcade_harmattan/");
#elif defined(ARCADE_HARMATTAN_ADFREE)
    path = QLatin1String("/opt/saita2adfree/qml/arcade_harmattan_adfree/");
#endif

    path.append(QLatin1String("assets/levels/classes.xml"));

    QFile file(path);
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "could not open the file : \n" << path;

        emit classUnlockFailed(QString("Unlock failed \nCould not open the file : \n%1").arg(path));

        return;
    }

    QDomDocument doc;
    if(!doc.setContent(&file))
    {
        qDebug() << "Could not set content";

        emit classUnlockFailed(QString("Unlock failed \nCould not set content"));

        return;
    }

    file.close();

    //! get the tag
    QDomNodeList list = doc.elementsByTagName(QString("classes"));
    if(list.isEmpty())
    {
        qDebug() << "could not find level tag";

        emit classUnlockFailed(QString("Unlock failed \nCould not find game tag"));

        return;
    }
    //! iterate through the categories tag
    QDomNode node = list.at(0);
    QDomNode child = node.firstChild();

    while(!child.isNull())
    {
        QDomElement cElement = child.toElement();

        // the id of the next level will be the id parameter added 1, as the id is actually an increment value
        if( cElement.attribute("name").contains(QLatin1String("Advanced"),Qt::CaseInsensitive) /*&& !cElement.attribute("lockedstate").toInt()*/)
        {
            // set locked state to 1, namely this level is now unlocked
            cElement.setAttribute("lockedstate",1);

            qDebug() << "lockedstate : " << 1;

            //! saving start here

            if (file.open(QIODevice::WriteOnly))
            {
                QTextStream out(&file);
                out << doc.toString(4);
                file.close();

                emit classUnlocked();

                break;
            }
        }

        child = child.nextSibling();
    }
}

void XmlUtility::setApplesValue(const QString &filename, qint32 id, qint32 val)
{
    QUrl url(filename);

    QFile file(url.toLocalFile());
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "could not open the file : \n" << url.toLocalFile();

        emit unlockFailed(QString("Unlock failed <br/>Could not open the file : %1").arg(url.toLocalFile()));

        return;
    }

    QDomDocument doc;
    if(!doc.setContent(&file))
    {
        qDebug() << "Could not set content";

        emit unlockFailed(QString("Unlock failed <br/>Could not set content"));

        return;
    }

    file.close();

    //! get the tag
    QDomNodeList list = doc.elementsByTagName(QString("levels"));
    if(list.isEmpty())
    {
        qDebug() << "could not find level tag";

        emit unlockFailed(QString("Unlock failed <br/>Could not find game tag"));

        return;
    }
    //! iterate through the categories tag
    QDomNode node = list.at(0);
    QDomNode child = node.firstChild();

    double grade = 0.0;
    int counter = 0;
    bool changed = false;

    if(child.isNull())
        qDebug() << "child is null ..";

    while(!child.isNull())
    {
        QDomElement cElement = child.toElement();

        // the id of the next level will be the id parameter added 1, as the id is actually an increment value
        if( cElement.attribute("id").toInt() == id /*&& !cElement.attribute("lockedstate").toInt()*/)
        {
            int cVal = cElement.attribute("apples").toInt();

            qDebug() << "val : " << val << " cVal : " << cVal;

            if(val > cVal)
            {
                // set apples value
                cElement.setAttribute("apples",val);

                //! saving start here
                QFile _file(url.toLocalFile());
                if (_file.open(QIODevice::WriteOnly))
                {
                    QTextStream out(&_file);
                    out << doc.toString(4);
                    _file.close();

                    if(val != 0)
                        emit applesChanged();

                    if(val == 3)
                        increaseBadge(filename);

//                    break;
                }
                else
                    qDebug() << "could not open the file for writing changes..";

                changed = true;
            }
        }

        if(cElement.attribute("lockedstate").toInt()){
            grade += cElement.attribute("apples").toDouble();
            counter++;
        }

        child = child.nextSibling();
    }

    if(changed)
    {
        //    if(grade>0)
        qDebug() << "setting grade : " << (double)grade/counter;

        setGrade(filename,(double)(grade/counter)+1.0);
    }
}
void XmlUtility::resetDatabase()
{
    QString path;

    path.append(QCoreApplication::applicationDirPath()).append(QDir::separator());

#ifdef Q_OS_WIN
    path.append("../");
    path.append(QLatin1String("qml/desktop_windows/"));
#elif defined(HARMATTAN)
    path.append(QLatin1String("qml/harmattan/"));
#elif defined(SYMBIAN)
    path.append(QLatin1String("qml/symbian/"));
#elif defined(ARCADE_SYMBIAN)
    path.append(QLatin1String("qml/arcade_symbian/"));
#elif defined(ARCADE_HARMATTAN)
    path = QLatin1String("/opt/saita2/qml/arcade_harmattan/");
#elif defined(ARCADE_HARMATTAN_ADFREE)
    path = QLatin1String("/opt/saita2adfree/qml/arcade_harmattan_adfree/");
#endif

    QFile file(path);
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "could not open the file : \n" << path;

        emit dbResetFailed(QString("Reset failed <br/>Could not open the file : %1").arg(path));

        return;
    }

    QDomDocument doc;
    if(!doc.setContent(&file))
    {
        qDebug() << "Could not set content";

        emit dbResetFailed(QString("Reset failed <br/>Could not set content"));

        return;
    }

    file.close();

    //! get the tag
    QDomNodeList list = doc.elementsByTagName(QString("levels"));
    if(list.isEmpty())
    {
        qDebug() << "could not find level tag";

        emit unlockFailed(QString("Unlock failed <br/>Could not find level tag"));

        return;
    }
    //! iterate through the categories tag
    QDomNode node = list.at(0);
    QDomNode child = node.firstChild();

    while(!child.isNull())
    {
        QDomElement cElement = child.toElement();

        // the id of the next level will be the id parameter added 1, as the id is actually an increment value
        if( cElement.attribute("id").toInt() != 1)
        {
            // set locked state to 0, namely this level is now locked
            cElement.setAttribute("lockedstate",1);
        }
        else{ // set locked state to 1, namely this level is now unlocked
            cElement.setAttribute("lockedstate",0);
        }

        cElement.setAttribute("apples",1);

        child = child.nextSibling();
    }

    if (file.open(QIODevice::WriteOnly))
    {
        QTextStream out(&file);
        out << doc.toString(4);
        file.close();

        emit databaseReseted();
    }
}

void XmlUtility::increaseBadge(const QString &filename)
{
    QString path;

    path.append(QCoreApplication::applicationDirPath()).append(QDir::separator());

#ifdef Q_OS_WIN
    path.append("../");
    path.append(QLatin1String("qml/desktop_windows/"));
#elif defined(HARMATTAN)
    path.append(QLatin1String("qml/harmattan/"));
#elif defined(SYMBIAN)
    path.append(QLatin1String("qml/symbian/"));
#elif defined(ARCADE_SYMBIAN)
    path.append(QLatin1String("qml/arcade_symbian/"));
#elif defined(ARCADE_HARMATTAN)
    path = QLatin1String("/opt/saita2/qml/arcade_harmattan/");
#elif defined(ARCADE_HARMATTAN_ADFREE)
    path = QLatin1String("/opt/saita2adfree/qml/arcade_harmattan_adfree/");
#endif

    path.append(QLatin1String("assets/levels/classes.xml"));

    QFile file(path);
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "could not open the file : \n" << path;

        emit unlockFailed(QString("Unlock failed <br/>Could not open the file : %1").arg(filename));

        return;
    }

    QDomDocument doc;
    if(!doc.setContent(&file))
    {
        qDebug() << "Could not set content";

        emit unlockFailed(QString("Unlock failed <br/>Could not set content"));

        return;
    }

    file.close();

    //! get the tag
    QDomNodeList list = doc.elementsByTagName(QString("classes"));
    if(list.isEmpty())
    {
        qDebug() << "could not find level tag";

        emit unlockFailed(QString("Unlock failed <br/>Could not find game tag"));

        return;
    }
    //! iterate through the categories tag
    QDomNode node = list.at(0);
    QDomNode child = node.firstChild();

    while(!child.isNull())
    {
        QDomElement cElement = child.toElement();

        // the id of the next level will be the id parameter added 1, as the id is actually an increment value
        if( filename.contains(cElement.attribute("filename"),Qt::CaseInsensitive) /*&& !cElement.attribute("lockedstate").toInt()*/)
        {
            qint32 badges = cElement.attribute("badges").toInt();
            // set locked state to 1, namely this level is now unlocked
            cElement.setAttribute("badges",badges+1);

            qDebug() << "badges set : " << badges+1;

            //! saving start here

            if (file.open(QIODevice::WriteOnly))
            {
                QTextStream out(&file);
                out << doc.toString(4);
                file.close();

                emit badgesChanged(filename);

                break;
            }
        }

        child = child.nextSibling();
    }
}

void XmlUtility::setGrade(const QString &filename, double grade)
{
    QString path;

    path.append(QCoreApplication::applicationDirPath()).append(QDir::separator());

#ifdef Q_OS_WIN
    path.append("../");
    path.append(QLatin1String("qml/desktop_windows/"));
#elif defined(HARMATTAN)
    path.append(QLatin1String("qml/harmattan/"));
#elif defined(SYMBIAN)
    path.append(QLatin1String("qml/symbian/"));
#elif defined(ARCADE_SYMBIAN)
    path.append(QLatin1String("qml/arcade_symbian/"));
#elif defined(ARCADE_HARMATTAN)
    path = QLatin1String("/opt/saita2/qml/arcade_harmattan/");
#elif defined(ARCADE_HARMATTAN_ADFREE)
    path = QLatin1String("/opt/saita2adfree/qml/arcade_harmattan_adfree/");
#endif

    path.append(QLatin1String("assets/levels/classes.xml"));

    QFile file(path);
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "could not open the file : \n" << path;

        emit unlockFailed(QString("Unlock failed <br/>Could not open the file : %1").arg(filename));

        return;
    }

    QDomDocument doc;
    if(!doc.setContent(&file))
    {
        qDebug() << "Could not set content";

        emit unlockFailed(QString("Unlock failed <br/>Could not set content"));

        return;
    }

    file.close();

    //! get the tag
    QDomNodeList list = doc.elementsByTagName(QString("classes"));
    if(list.isEmpty())
    {
        qDebug() << "could not find level tag";

        emit unlockFailed(QString("Unlock failed <br/>Could not find game tag"));

        return;
    }
    //! iterate through the categories tag
    QDomNode node = list.at(0);
    QDomNode child = node.firstChild();

    while(!child.isNull())
    {
        QDomElement cElement = child.toElement();

        // the id of the next level will be the id parameter added 1, as the id is actually an increment value
        if( filename.contains(cElement.attribute("filename"),Qt::CaseInsensitive) /*&& !cElement.attribute("lockedstate").toInt()*/)
        {
            // set locked state to 1, namely this level is now unlocked
            cElement.setAttribute("grade",QString::number(grade,'f',1));

            qDebug() << "grade set : " << grade;

            //! saving start here

            if (file.open(QIODevice::WriteOnly))
            {
                QTextStream out(&file);
                out << doc.toString(4);
                file.close();

                emit gradeChanged(filename);

                break;
            }
        }

        child = child.nextSibling();
    }
}
