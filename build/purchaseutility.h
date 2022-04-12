#ifndef PURCHASEUTILITY_H
#define PURCHASEUTILITY_H

#include <QObject>
#include <QSettings>

#include <iapclient.h>

#include <QSystemDeviceInfo>
#include <QStringList>

QTM_USE_NAMESPACE

class QmlApplicationViewer;

class PurchaseUtility : public QObject
{
    Q_OBJECT
public:
    explicit PurchaseUtility(QObject *parent = 0);

    ~PurchaseUtility();

    Q_INVOKABLE void buyProduct();

    /*
     * Slot to handle user's tap on the Restore button on a catalog's product item.
     */
    Q_INVOKABLE void restoreProducts();

    Q_INVOKABLE void useTrial();

    static QString getTicketDir();
    static QString getTicketUri(const QString& productID);
    static bool readTicket(const QString& productID);
    static void saveTicket(const QString& purchaseTicket,
                           QString& productID);

    bool isExpired() { return expired; }

    void initialize();

public slots:
    void checkPurchaseState();

    void requestNextProduct();
    
signals:
    void purchaseSucceeded();
    void purchaseFailed();
    void getProductsCompleted();
    void restoreCompleted();
    void restoreFailed();
    void appExpired();

    void dataReceived(const QString &info,const QString &price,const QString &shortdescription,const QString &description);
    
private:
    QString defaultProduct;
    /*
     * List of product items as read from app's config file.
     */
    QStringList products;

    /*
     * Index in *products* list indicating which is the last product for which
     * info was requested from Ovi
     */
    int productsRequested;

    /*
     * Holds the requestId returned by the current In-Application Purchase call
     */
    int current_requestId;

    QString current_productId;
    /*
     * In-Application Purchase API
     */
    IAPClient *iap_client;

    /*
     * List of availble products as retrieved from Ovi
     */
    QList<IAPClient::ProductDataHash> available_products;

    IAPClient::ProductDataList restorableProductItems;

    QString getProductId(const QString& path);

    bool isPurchased();

private:
    bool isProductActivated(QString product);

    QmlApplicationViewer *m_pQmlApplicationViewer;

    QSettings *m_pQSettings;

    int daysLeft;

    bool expired;

private slots:

    /*
     * In-Application Purchase specific slots
     *
     * Slots matching the signals of the In-Application Purchase API, allowing
     * the application to receive callbacks
     */
    void productDataReceived( int requestId, QString status,
                              IAPClient::ProductDataHash productData );
    void purchaseCompleted( int requestId, QString status, QString purchaseTicket );
    void purchaseFlowFinished( int requestId );
    void userAndDeviceDataReceived( int requestId, QString status,
                                    IAPClient::UserAndDeviceDataHash userdata );
    void restorableProductsReceived( int requestId, QString status,
                                     IAPClient::ProductDataList items );
    void restorationFlowFinished( int requestId );
    void restorationCompleted( int requestId, QString status, QString purchaseTicket );
    
};

#endif // PURCHASEUTILITY_H
