#ifndef MYAPPLICATION_H
#define MYAPPLICATION_H

#include <QDebug>

#ifdef Q_OS_SYMBIAN
    #include <QSymbianEvent>
    #include <w32std.h>
#endif

#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeContext>

#include <QGraphicsObject>

#include "qmlapplicationviewer.h"

class MyApplication : public QApplication
{
    Q_OBJECT
public:
    MyApplication( int argc, char** argv );

    QmlApplicationViewer *m_pViewer;

#ifdef Q_OS_SYMBIAN

protected:
    bool symbianEventFilter( const QSymbianEvent* symbianEvent ) {
        const TWsEvent *event = symbianEvent->windowServerEvent();

        if( !event ) {
            return false;
        }
        switch( event->Type() )
        {
            case EEventFocusGained:
            {
                if(m_pViewer && m_pViewer->rootObject())
                    m_pViewer->rootObject()->setProperty("appFocused", true);
                break;
            }
            case EEventFocusLost:
            {
                if(m_pViewer && m_pViewer->rootObject())
                    m_pViewer->rootObject()->setProperty("appFocused", false);
                break;
            }
            default:
                break;
        }
        // Always return false so we don't stop
        // the event from being processed

        return false;
    }

#endif // Q_OS_SYMBIAN  };

signals:

public slots:


private slots:


};

#endif // MYAPPLICATION_H
