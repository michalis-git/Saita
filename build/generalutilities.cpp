#include "generalutilities.h"

#include <QMessageBox>
#include <QDebug>
#include <QApplication>
#include <QDir>
#include <QTimer>
#include <QDate>

GeneralUtilities::GeneralUtilities(QObject *parent) :
    QObject(parent)
  #ifdef Q_OS_SYMBIAN
        , iVibrate(0)
  #endif
{
#ifdef Q_OS_SYMBIAN
    iVibrate = CHWRMVibra::NewL();
#endif
}

/*!
  Provides fast haptics feedback.
*/
void GeneralUtilities::fastVibra()
{
#ifdef Q_OS_SYMBIAN
    if ( iVibrate )
        {
        TRAPD( err, iVibrate->StartVibraL( 100, KHWRMVibraMaxIntensity ) );
        }
#endif
}

GeneralUtilities::~GeneralUtilities(){
#ifdef Q_OS_SYMBIAN
    delete iVibrate;
#endif
}
