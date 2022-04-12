#include "myapplication.h"

#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QGraphicsObject>
#include <QTimer>

MyApplication::MyApplication(int argc, char **argv)
    : QApplication( argc, argv )
    ,m_pViewer(0)
{

}
