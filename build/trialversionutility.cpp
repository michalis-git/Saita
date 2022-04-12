#include "trialversionutility.h"

#include <QDeclarativeContext>

#include "qmlapplicationviewer.h"

TrialVersionUtility::TrialVersionUtility(QObject *parent) :
    QObject(parent)
{
    m_pQSettings = new QSettings(QSettings::IniFormat,QSettings::UserScope,QLatin1String("Ideal Apps"), QLatin1String("Saita@SchoolTrial"));
    bool initialized = m_pQSettings->value("initialized",QVariant::fromValue(false)).toBool();
    if(!initialized)
    {
        m_pQSettings->setValue("initialized",QVariant::fromValue(true));
        m_pQSettings->setValue("startdate",QVariant::fromValue(QDate::currentDate()));
    }

    QDate currentDate = QDate::currentDate();
    QDate startDate = m_pQSettings->value("startdate").toDate();
    m_daysLeft = currentDate.daysTo(startDate) + 1;

    if(m_daysLeft<0)
        expired = true;
    else
        expired = false;
}

void TrialVersionUtility::useTrial(){

}


TrialVersionUtility::~TrialVersionUtility()
{

}
