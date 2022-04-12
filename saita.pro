#DEFINES += SYMBIAN
#DEFINES += WINDOWS
DEFINES += HARMATTAN
#DEFINES += ARCADE_SYMBIAN
#DEFINES += ARCADE_HARMATTAN
#DEFINES += ARCADE_HARMATTAN_ADFREE
#DEFINES += SYMBIAN_ADS
#DEFINES += HARMATTAN_ADS

# platform checking
contains(DEFINES,HARMATTAN){
    folder_01.source = qml/harmattan
    VERSION = 2.00.1
    TARGET = saita
}

contains(DEFINES,SYMBIAN){
    folder_01.source = qml/symbian
    VERSION = 2.00.1
    TARGET = saita
}

contains(DEFINES,ARCADE_SYMBIAN){
    folder_01.source = qml/arcade_symbian

    include(component/component.pri)
    folder_components.source = component/inneractive
    folder_components.target = qml/arcade_symbian
    DEPLOYMENTFOLDERS += folder_components

    VERSION = 1.00.1
    TARGET = saita2
}

contains(DEFINES,WINDOWS){
    folder_01.source = qml/desktop_windows
    VERSION = 1.00.1
    TARGET = saita2
}

contains(DEFINES,ARCADE_HARMATTAN){
    folder_01.source = qml/arcade_harmattan

    include(component/component.pri)
    folder_components.source = component/inneractive
    folder_components.target = qml/arcade_harmattan
    DEPLOYMENTFOLDERS += folder_components

    VERSION = 1.00.1
    TARGET = saita2
}

contains(DEFINES,ARCADE_HARMATTAN_ADFREE){
    folder_01.source = qml/arcade_harmattan_adfree

    VERSION = 1.00.1
    TARGET = saita2adfree
}

contains(DEFINES,HARMATTAN_ADS){
    folder_01.source = qml/harmattan_ads

    include(component/component.pri)
    folder_components.source = component/inneractive
    folder_components.target = qml/harmattan_ads
    DEPLOYMENTFOLDERS += folder_components

    VERSION = 2.00.1
}

contains(DEFINES,SYMBIAN_ADS){
    folder_01.source = qml/symbian_ads

    include(component/component.pri)
    folder_components.source = component/inneractive
    folder_components.target = qml/symbian_ads
    DEPLOYMENTFOLDERS += folder_components

    VERSION = 2.00.1
}

folder_01.target = qml
DEPLOYMENTFOLDERS += folder_01 #folder_02

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# add extra qt modules
QT += network xml

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
symbian:DEPLOYMENT.installer_header = 0x2002CCCF


# Allow network access on Symbian
#symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility #\
#        inapppurchase \
#        debug

MOBILITY += network multimedia

# include the build folder which contain all header and source files built for this project
include(build/build.pri)

# Audio plugin
include(qtgameenabler/qtgameenableraudioplugin.pri)

include(Box2D/box2d.pri)

TEMPLATE = app

RESOURCES += \
    saita.qrc

# symbian uid used for self signing
symbian{
    contains(DEFINES,ARCADE_SYMBIAN){
#    TARGET.UID3 = 0xE73C838C
#    TARGET.UID3 = 0x20065C08
    ICON = saita2.svg
    }

    contains(DEFINES,SYMBIAN_ADS){
#        TARGET.UID3 = 0x200307D7
#        TARGET.UID3 = 0xE73C838C
    }
    contains(DEFINES,SYMBIAN){
        TARGET.UID3 = 0x20065C09
#        TARGET.UID3 = 0x20065C08
    }

    TARGET.CAPABILITY += NetworkServices

    LIBS += -lcone -leikcore -lavkon -lhwrmvibraclient

    LIBS += -lcaf \
        -lcafutils \
        -lapmime

    # Enables In-App Purchase API
#    DEFINES += IN_APP_PURCHASE
    #DEFINES += IN_APP_PURCHASE_DEBUG

    # Enables test mode for IAP
#    DEFINES += IA_PURCHASE_TEST_MODE

#    contains(DEFINES, IN_APP_PURCHASE) {
#        # IAP configuration
#        addConfigFiles.sources = ./iap/IAP_VARIANTID.txt ./iap/TEST_MODE.txt
#        addConfigFiles.path = .
#        DEPLOYMENT += addConfigFiles

#        addDrm.sources = ./iap/data
#        addDrm.path = ./drm
#        DEPLOYMENT += addDrm
#    }

    my_deployment.pkg_prerules += \
            "; Dependency to Symbian Qt Quick components" \
            "(0x200346de), 1, 1, 0 , {\"Qt Quick components for Symbian\"}"

    DEPLOYMENT += my_deployment
}

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable

#needed for symbian development
CONFIG      += qt-components

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qtc_packaging/debian_harmattan/postinst

contains(MEEGO_EDITION,harmattan) {
    contains(DEFINES,ARCADE_HARMATTAN_ADFREE){
        desktopfile.files = saita2adfree.desktop
    }

    contains(DEFINES,ARCADE_HARMATTAN){
        desktopfile.files = saita2.desktop
    }

    desktopfile.path = /usr/share/applications
    INSTALLS += desktopfile
}
