#include "purchaseutility.h"
#include "drmfile.h"
#include "qmlapplicationviewer.h"

#include <qplatformdefs.h> // MEEGO_EDITION_HARMATTAN

#include <QDeclarativeContext>
#include <QDirIterator>
#include <QMessageBox>
#include <QDebug>
#include <QApplication>
#include <QTimer>
#include <QTranslator>

#define PRODUCTID 843814
#define INVALID_VALUE -1
#define TICKETFOLDERNAME "tickets"

Q_DECLARE_METATYPE(IAPClient::ProductDataList)

PurchaseUtility::PurchaseUtility(QObject *parent) :
    QObject(parent),
    productsRequested(0),
    current_requestId(INVALID_VALUE)
{
    // required so that IAPClient::ProductData can be queued in the signal
    qRegisterMetaType<IAPClient::ProductDataHash>("IAPClient::ProductDataHash");

    iap_client = new IAPClient(this);

    QString filepath = QApplication::applicationDirPath();
    filepath.append(QDir::separator());
    filepath.append(QLatin1String("drm"));
    filepath.append(QDir::separator());
    filepath.append(QLatin1String("data"));

    QFile file(filepath);
    file.open(QFile::ReadOnly);

    QDirIterator dirit(filepath, QDir::Dirs, QDirIterator::NoIteratorFlags);
    while(dirit.hasNext())
    {
        QString dir = dirit.next();
        if(dir.contains("resourceid_", Qt::CaseInsensitive))
        {
            // breakdown the !:/private/<SID>/drm/data/resourceid_<productID>/
            // extract the product to which this file belongs
            QString product;
            QStringList elem = dir.split("_", QString::SkipEmptyParts);
            elem=elem[1].split("/", QString::SkipEmptyParts);
            product = elem[0].trimmed();
            if(!product.isEmpty())
            {
                if(!isProductActivated(product))
                {
                    products.append(product);
                    qDebug() << "++ ProductID " << product << " to be puchased.";
                }
                else
                {
                    qDebug() << "++ ProductID " << product << " is activated.";
                }
            }
        }
    }

    if(products.count()>0)
    {
        connect(iap_client, SIGNAL(productDataReceived( int, QString, IAPClient::ProductDataHash)), this,
                SLOT(productDataReceived(int, QString, IAPClient::ProductDataHash)), Qt::QueuedConnection);
        connect(iap_client, SIGNAL(purchaseCompleted( int , QString, QString)), this,
                SLOT(purchaseCompleted( int , QString, QString)),Qt::QueuedConnection);
        connect(iap_client, SIGNAL(purchaseFlowFinished(int)), this, SLOT(purchaseFlowFinished(int)), Qt::QueuedConnection);

        requestNextProduct();
    }

    connect(iap_client, SIGNAL(restorableProductsReceived( int, QString, IAPClient::ProductDataList)), this,
            SLOT(restorableProductsReceived( int, QString, IAPClient::ProductDataList)));
    connect(iap_client, SIGNAL(restorationCompleted(int, QString, QString)), this,
            SLOT(restorationCompleted(int, QString, QString)),Qt::QueuedConnection);

    m_pQmlApplicationViewer = NULL;

    m_pQSettings = new QSettings(QSettings::IniFormat,QSettings::UserScope,QLatin1String("Ideal Apps"), QLatin1String("Saita@School"),this);
}

void PurchaseUtility::checkPurchaseState()
{
    if(!isPurchased())
    {
        qDebug() << "product is not purchased";

        initialize();
    }
}

void PurchaseUtility::useTrial(){
    if(isPurchased())
    {
        m_pQmlApplicationViewer->hide();

        qDebug() << "it is already purchased..";
    }
    else if(!isPurchased() && !expired)
    {
        m_pQmlApplicationViewer->hide();

        qDebug() << "it is not purchased and it is not expired..";
    }
    else
    {
        emit appExpired();

        QTimer::singleShot(5000,qApp,SLOT(quit()));
    }
}

void PurchaseUtility::initialize()
{
    bool initialized = m_pQSettings->value("initialized",QVariant::fromValue(false)).toBool();
    if(!initialized)
    {
        m_pQSettings->setValue("initialized",QVariant::fromValue(true));
        m_pQSettings->setValue("startdate",QVariant::fromValue(QDate::currentDate()));
    }

    QDate currentDate = QDate::currentDate();
    QDate startDate = m_pQSettings->value("startdate").toDate();
    daysLeft = currentDate.daysTo(startDate) + 2;

    if(daysLeft<=0)
        expired = true;
    else
        expired = false;

    m_pQmlApplicationViewer = new QmlApplicationViewer;
    m_pQmlApplicationViewer->rootContext()->setContextProperty("PurchaseUtility",this);
    m_pQmlApplicationViewer->rootContext()->setContextProperty("DaysLeft",QVariant::fromValue(daysLeft));
    m_pQmlApplicationViewer->setMainQmlFile("qml/symbian/PurchaseScreen.qml");
    m_pQmlApplicationViewer->setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    m_pQmlApplicationViewer->showExpanded();
}

bool PurchaseUtility::isPurchased()
{
    QString filepath = QApplication::applicationDirPath();
    filepath.append(QDir::separator());
    filepath.append(QLatin1String("drm"));
    filepath.append(QDir::separator());
    filepath.append(QLatin1String("data"));

    QFile file(filepath);
    file.open(QFile::ReadOnly);

    QDirIterator dirit(filepath, QDir::Dirs, QDirIterator::NoIteratorFlags);
    while(dirit.hasNext())
    {
        QString dir = dirit.next();
        if(dir.contains("resourceid_", Qt::CaseInsensitive))
        {
            // breakdown the !:/private/<SID>/drm/data/resourceid_<productID>/
            // extract the product to which this file belongs
            QString product;
            QStringList elem = dir.split("_", QString::SkipEmptyParts);
            elem=elem[1].split("/", QString::SkipEmptyParts);
            product = elem[0].trimmed();
            if(!product.isEmpty())
            {
                return readTicket(product);
            }
        }
    }

    return false;
}

PurchaseUtility::~PurchaseUtility()
{
    delete iap_client;

    if(m_pQmlApplicationViewer != NULL)
    {
        delete m_pQmlApplicationViewer;
        m_pQmlApplicationViewer = NULL;
    }
}

QString PurchaseUtility::getProductId(const QString& path)
{
    // breakdown the !:/private/<SID>/drm/data/resourceid_<productID>/file.ext
    // extract the product to which this file belongs
    QStringList elem = path.split("_", QString::SkipEmptyParts);
    elem=elem[1].split("/", QString::SkipEmptyParts);
    return (elem[0]);
}

/*
 * Returns true if the product files can be accessed or false if the purchase/restore is needed
 */
bool PurchaseUtility::isProductActivated(QString product)
{
    // ToDo: construct path, find first file and attempt to open it
    // return false if open request fails with DRM access code
    return false;
}

void PurchaseUtility::saveTicket(const QString& purchaseTicket, QString& productID)
{
    if (purchaseTicket.isEmpty() || productID.isEmpty())
        return;

    QString privatedir(getTicketDir());
    if (!QDir(privatedir).exists())
        QDir().mkdir(privatedir);

    QFile file(getTicketUri(productID));
    if (file.open(QIODevice::WriteOnly)){
        QDataStream out(&file);
        out << purchaseTicket;
        file.close();
    }
    else
    {
        qDebug() << "MainWindow::testModeSaveTicket >>> Cannot open file for writing: ";
    }

    productID = "";
}

bool PurchaseUtility::readTicket(const QString& productID)
{
    return (QFile(getTicketUri(productID)).exists());
}

QString PurchaseUtility::getTicketUri(const QString& productID)
{
    QString fname(QApplication::applicationDirPath());
    fname.append("/");
    fname.append(TICKETFOLDERNAME);
    fname.append("/");
    fname.append(productID);
    fname.append(".ticket");
    return fname;
}

QString PurchaseUtility::getTicketDir()
{
    QString fname(QApplication::applicationDirPath());
    fname.append("/");
    fname.append(TICKETFOLDERNAME);
    return fname;
}

void PurchaseUtility::buyProduct()
{
    if(available_products.isEmpty())
        return;

    IAPClient::ProductDataHash info = available_products[0];
    // issue a buy request for the corresponding product
    // if the user has paid for this content already, restoration of the license is needed
    current_productId = info.value("id").toString();
    current_requestId = iap_client->purchaseProduct(current_productId, IAPClient::ForcedAutomaticRestoration);
}

/*
 *
 *
 *
 */
void PurchaseUtility::productDataReceived( int requestId, QString status, IAPClient::ProductDataHash productData )
{
    qDebug() << "::. productDataReceived";

    //Q_ASSERT(requestId == current_requestId);

    if(QString::compare(status, "OK", Qt::CaseInsensitive)==0)
    {
        available_products.append(productData);

        emit dataReceived(productData.value("info").toString(),productData.value("price").toString(),productData.value("shortdescription").toString(),productData.value("description").toString());
//    }
//    else // what are all the possible status messages?
//    {
        // the product is not available for one reason or another?
        // probably you can ignore this
        // or report it to your server for analysis
//        qDebug() << "Requested product could not be retrived: " << status;
    }
}

/*
 *
 *
 *
 */
void PurchaseUtility::requestNextProduct()
{
    qDebug() << "::. requestNextProduct";

    if(productsRequested < products.count())
    {
        QString prod = products[productsRequested++];
        current_requestId = iap_client->getProductData(prod);

        qDebug() << "+ Request for product" << prod << " returned id: " << current_requestId;
    }

    qDebug() << ".:: requestNextProduct";
}

/*
 *
 *
 *
 */
void PurchaseUtility::purchaseCompleted( int requestId, QString status, QString purchaseTicket )
{
    qDebug() << "::. purchaseCompleted with status: " << status;

    if(requestId != current_requestId)
        return;

    if(QString::compare(status, "OK", Qt::CaseInsensitive)==0
         || QString::compare(status, "RestorableProduct", Qt::CaseInsensitive)==0)
    {
        saveTicket(purchaseTicket, current_productId);
        // In-Application Purchase API will take care of downloading the DRM license
        // the files covered by this license will become accessible

//        if(productID.toInt() !=PRODUCTID)
//            return;

//        m_pQSettings->setValue(QString("productid"),QString::number(PRODUCTID));
//        m_pQSettings->setValue(QString("deviceno"),QString(m_pQDeviceInfo->uniqueDeviceID()));

        emit purchaseSucceeded();
    }
    else
    {
        // some error
        // error message already displayed by In-Application Purchase UI, may also be reflected in app's UI.
    }

    qDebug() << ".:: purchaseCompleted";
}

/*
 *
 *
 *
 */
void PurchaseUtility::userAndDeviceDataReceived( int /*requestId*/, QString /*status*/,
                                            IAPClient::UserAndDeviceDataHash /*userdata*/ )
{
    qDebug() << "::. userAndDeviceDataReceived";

    qDebug() << ".:: userAndDeviceDataReceived";
}

/*
 *
 *
 *
 */
void PurchaseUtility::restorableProductsReceived( int requestId, QString status,
                                             IAPClient::ProductDataList items )
{
    qDebug() << "::. restorableProductsReceived with status: " << status;
    if(requestId != current_requestId){
        qDebug() << "::. restorableProductsReceived failed ";
        return;
    }

    current_requestId = INVALID_VALUE;

    if(!items.empty()){
        restorableProductItems.append(items);
        current_productId = restorableProductItems.takeFirst().value("id").toString();
        current_requestId = iap_client->restoreProduct(current_productId);
    }
}

/*
 *
 *
 *
 */
void PurchaseUtility::restorationFlowFinished( int requestId )
{
    qDebug() << "::. restorationFlowFinished";

    qDebug() << ".:: restorationFlowFinished";
}

/*
 *
 *
 *
 */
void PurchaseUtility::restorationCompleted( int requestId, QString status, QString purchaseTicket )
{
    qDebug() << "::. restorationCompleted with status: " << status;

    purchaseCompleted(requestId, status, purchaseTicket);

    if(restorableProductItems.empty()){
    }else{
        current_productId = restorableProductItems.takeFirst().value("id").toString();
        current_requestId = iap_client->restoreProduct(current_productId);

        emit restoreCompleted();
    }

    qDebug() << ".:: restorationCompleted";
}

/*
 *
 *
 *
 */
void PurchaseUtility::purchaseFlowFinished( int requestId )
{
    qDebug() << "::. purchaseFlowFinished";

    // now the user is back in app's UI

    qDebug() << ".:: purchaseFlowFinished";
}


void PurchaseUtility::restoreProducts()
{
    current_requestId = iap_client->getRestorableProducts();
    if(current_requestId < 0)
        return;

    //lock ui
    restorableProductItems.clear();
}
