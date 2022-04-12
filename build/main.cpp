#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "scoresutility.h"

#if defined(SYMBIAN) || defined(HARMATTAN) || defined(ARCADE_SYMBIAN) || defined(ARCADE_HARMATTAN) || defined(SYMBIAN_ADS) || defined(HARMATTAN_ADS) || defined(ARCADE_HARMATTAN_ADFREE)
#include "audioutility.h"
#include "audioplugin.h"

using namespace GE;
#endif

#include "myapplication.h"
#include "generalutilities.h"
#include "xmlutility.h"

#include "box2dqmlplugin/box2dplugin.h"

#include <QDeclarativeContext>
#include <QFontDatabase>
#include <QDir>
#include <QtDeclarative>

#ifdef IN_APP_PURCHASE
#include "purchaseutility.h"
#endif

#if defined(SYMBIAN_ADS) || defined(HARMATTAN_ADS) || defined(ARCADE_HARMATTAN) || defined(ARCADE_SYMBIAN)
// Include inneractiveplugin.h for using inneractive components
#include <inneractiveplugin.h>
#endif

Q_DECL_EXPORT int main(int argc, char *argv[])
{
#if defined(WINDOWS)
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QmlApplicationViewer viewer;

    GeneralUtilities generalUtilities;

    int screenWidth = 854;
    int screenHeight = 480;

    Box2DPlugin bplugin;
    bplugin.registerTypes("Box2D");

    XmlUtility xmlUtility;
    viewer.rootContext()->setContextProperty("XmlUtility",&xmlUtility);

    viewer.rootContext()->setContextProperty("GeneralUtilities",&generalUtilities);

    viewer.rootContext()->setContextProperty("ChangeLevelHelperValue",60);

    QFileInfo file1("qml/desktop_windows/assets/audio/music/gameOver.wav");
    QFileInfo file2("qml/desktop_windows/assets/audio/music/lost.wav");
    QFileInfo file3("qml/desktop_windows/assets/audio/music/main_theme.wav");
    viewer.rootContext()->setContextProperty("GameOverMusicSource",file1.absoluteFilePath());
    viewer.rootContext()->setContextProperty("LostMusicSource",file2.absoluteFilePath());
    viewer.rootContext()->setContextProperty("GamePlayMusicSource",file3.absoluteFilePath());
    viewer.rootContext()->setContextProperty("screenWidth",screenWidth);
    viewer.rootContext()->setContextProperty("screenHeight",screenHeight);

    viewer.setMainQmlFile(QLatin1String("qml/desktop_windows/main.qml"));

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);

    viewer.showExpanded();

    return app->exec();

#elif defined(HARMATTAN)
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());

    AudioPlugin plugin;
    plugin.registerTypes("GEAudio");

    Box2DPlugin bplugin;
    bplugin.registerTypes("Box2D");

    ScoresUtility scoresUtility;
    viewer->rootContext()->setContextProperty("ScoresUtility",&scoresUtility);

    GeneralUtilities generalUtilities;
    viewer->rootContext()->setContextProperty("GeneralUtilities",&generalUtilities);

    viewer->rootContext()->setContextProperty("ChangeLevelHelperValue",60);

    viewer->setMainQmlFile(QLatin1String("qml/harmattan/main.qml"));
    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);

    viewer->showExpanded();

    return app->exec();

#elif defined(ARCADE_HARMATTAN)
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());

    // Initialize QDeclarativeEngine with inneractivePlugin
    inneractivePlugin::initializeEngine(viewer->engine());

    AudioPlugin plugin;
    plugin.registerTypes("GEAudio");

    Box2DPlugin bplugin;
    bplugin.registerTypes("Box2D");

    GeneralUtilities generalUtilities;
    viewer->rootContext()->setContextProperty("GeneralUtilities",&generalUtilities);

    XmlUtility xmlUtility;
    viewer->rootContext()->setContextProperty("XmlUtility",&xmlUtility);

    viewer->rootContext()->setContextProperty("ChangeLevelHelperValue",60);

    viewer->setMainQmlFile(QLatin1String("qml/arcade_harmattan/main.qml"));
    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);

    viewer->showExpanded();

    return app->exec();

#elif defined(ARCADE_HARMATTAN_ADFREE)
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());

    AudioPlugin plugin;
    plugin.registerTypes("GEAudio");

    Box2DPlugin bplugin;
    bplugin.registerTypes("Box2D");

    GeneralUtilities generalUtilities;
    viewer->rootContext()->setContextProperty("GeneralUtilities",&generalUtilities);

    XmlUtility xmlUtility;
    viewer->rootContext()->setContextProperty("XmlUtility",&xmlUtility);

    viewer->rootContext()->setContextProperty("ChangeLevelHelperValue",60);

    viewer->setMainQmlFile(QLatin1String("qml/arcade_harmattan_adfree/main.qml"));
    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);

    viewer->showExpanded();

    return app->exec();

#elif defined(SYMBIAN)
    MyApplication myApp(argc,argv);
    QmlApplicationViewer viewer;

    myApp.m_pViewer = &viewer;

    GeneralUtilities generalUtilities;

    AudioPlugin plugin;
    plugin.registerTypes("GEAudio");

    Box2DPlugin bplugin;
    bplugin.registerTypes("Box2D");

    ScoresUtility scoresUtility;
    viewer.rootContext()->setContextProperty("ScoresUtility",&scoresUtility);

    viewer.rootContext()->setContextProperty("GeneralUtilities",&generalUtilities);

    viewer.rootContext()->setContextProperty("ChangeLevelHelperValue",60);

    QFileInfo file1("qml/symbian/assets/audio/music/gameOver.wav");
    QFileInfo file2("qml/symbian/assets/audio/music/lost.wav");
    QFileInfo file3("qml/symbian/assets/audio/music/main_theme.wav");
    viewer.rootContext()->setContextProperty("GameOverMusicSource",file1.absoluteFilePath());
    viewer.rootContext()->setContextProperty("LostMusicSource",file2.absoluteFilePath());
    viewer.rootContext()->setContextProperty("GamePlayMusicSource",file3.absoluteFilePath());

    viewer.setMainQmlFile(QLatin1String("qml/symbian/main.qml"));

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);

    viewer.showExpanded();

#ifdef IN_APP_PURCHASE

    PurchaseUtility purchaseUtility;
    QTimer::singleShot(1000,&purchaseUtility,SLOT(checkPurchaseState()));
#endif

    return myApp.exec();

#elif defined(ARCADE_SYMBIAN)

    MyApplication myApp(argc,argv);
    QmlApplicationViewer viewer;

    myApp.m_pViewer = &viewer;

    AudioPlugin plugin;
    plugin.registerTypes("GEAudio");

    Box2DPlugin bplugin;
    bplugin.registerTypes("Box2D");

    XmlUtility xmlUtility;
    viewer.rootContext()->setContextProperty("XmlUtility",&xmlUtility);

    GeneralUtilities generalUtilities;
    viewer.rootContext()->setContextProperty("GeneralUtilities",&generalUtilities);

    // Initialize QDeclarativeEngine with inneractivePlugin
    inneractivePlugin::initializeEngine(viewer.engine());

    viewer.rootContext()->setContextProperty("ChangeLevelHelperValue",60);

    QFileInfo file1("qml/arcade_symbian/assets/audio/music/gameOver.wav");
    QFileInfo file2("qml/arcade_symbian/assets/audio/music/lost.wav");
    QFileInfo file3("qml/arcade_symbian/assets/audio/music/main_theme.wav");
    QFileInfo file4("qml/arcade_symbian/assets/audio/music/victory.wav");
    QFileInfo file5("qml/arcade_symbian/assets/audio/effects/lampsqueek.wav");
    QFileInfo file6("qml/arcade_symbian/assets/audio/effects/lampcrash.wav");
    QFileInfo file7("qml/arcade_symbian/assets/audio/effects/bounce.wav");
    QFileInfo file8("qml/arcade_symbian/assets/audio/effects/slowdown.wav");
    viewer.rootContext()->setContextProperty("GameOverMusicSource",file1.absoluteFilePath());
    viewer.rootContext()->setContextProperty("LostMusicSource",file2.absoluteFilePath());
    viewer.rootContext()->setContextProperty("GamePlayMusicSource",file3.absoluteFilePath());
    viewer.rootContext()->setContextProperty("WinMusicSource",file4.absoluteFilePath());
    viewer.rootContext()->setContextProperty("LampSqueekSource",file5.absoluteFilePath());
    viewer.rootContext()->setContextProperty("LampCrashSource",file6.absoluteFilePath());
    viewer.rootContext()->setContextProperty("BounceSource",file7.absoluteFilePath());
    viewer.rootContext()->setContextProperty("SlowDownSource",file8.absoluteFilePath());

    viewer.setMainQmlFile(QLatin1String("qml/arcade_symbian/main.qml"));

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);

    viewer.showExpanded();

#ifdef IN_APP_PURCHASE

    PurchaseUtility purchaseUtility;
    QTimer::singleShot(1000,&purchaseUtility,SLOT(checkPurchaseState()));
#endif

    return myApp.exec();

#elif defined(SYMBIAN_ADS)
    MyApplication myApp(argc,argv);
    QmlApplicationViewer viewer;

    myApp.m_pViewer = &viewer;

    GeneralUtilities generalUtilities;

    AudioPlugin plugin;
    plugin.registerTypes("GEAudio");

    Box2DPlugin bplugin;
    bplugin.registerTypes("Box2D");

    // Initialize QDeclarativeEngine with inneractivePlugin
    inneractivePlugin::initializeEngine(viewer.engine());

    ScoresUtility scoresUtility;
    viewer.rootContext()->setContextProperty("ScoresUtility",&scoresUtility);

    viewer.rootContext()->setContextProperty("GeneralUtilities",&generalUtilities);

    viewer.rootContext()->setContextProperty("ChangeLevelHelperValue",60);

    QFileInfo file1("qml/symbian_ads/assets/audio/music/gameOver.wav");
    QFileInfo file2("qml/symbian_ads/assets/audio/music/lost.wav");
    QFileInfo file3("qml/symbian_ads/assets/audio/music/main_theme.wav");
    viewer.rootContext()->setContextProperty("GameOverMusicSource",file1.absoluteFilePath());
    viewer.rootContext()->setContextProperty("LostMusicSource",file2.absoluteFilePath());
    viewer.rootContext()->setContextProperty("GamePlayMusicSource",file3.absoluteFilePath());

    viewer.setMainQmlFile(QLatin1String("qml/symbian_ads/main.qml"));

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);

    viewer.showExpanded();

    return myApp.exec();

#elif defined(HARMATTAN_ADS)
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());

    AudioPlugin plugin;
    plugin.registerTypes("GEAudio");

    Box2DPlugin bplugin;
    bplugin.registerTypes("Box2D");

    // Initialize QDeclarativeEngine with inneractivePlugin
    inneractivePlugin::initializeEngine(viewer->engine());

    ScoresUtility scoresUtility;
    viewer->rootContext()->setContextProperty("ScoresUtility",&scoresUtility);

    GeneralUtilities generalUtilities;
    viewer->rootContext()->setContextProperty("GeneralUtilities",&generalUtilities);

    viewer->rootContext()->setContextProperty("ChangeLevelHelperValue",60);

    viewer->setMainQmlFile(QLatin1String("qml/harmattan_ads/main.qml"));
    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);

    viewer->showExpanded();

    return app->exec();

#endif
}
