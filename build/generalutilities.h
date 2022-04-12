#ifndef GENERALUTILITIES_H
#define GENERALUTILITIES_H

#include <QObject>
#include <QSettings>

#ifdef Q_OS_SYMBIAN
    #include <hwrmvibra.h>
#endif

#ifdef IN_APP_PURCHASE

    class PurchaseScreen;
#endif

//#include <QSystemDeviceInfo>

//QTM_USE_NAMESPACE

class GeneralUtilities : public QObject
{
    Q_OBJECT
public:
    explicit GeneralUtilities(QObject *parent = 0);

    ~GeneralUtilities();

    Q_INVOKABLE void fastVibra();

private:
#ifdef Q_OS_SYMBIAN
    CHWRMVibra* iVibrate;
#endif

};

#endif // GENERALUTILITIES_H
