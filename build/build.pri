INCLUDEPATH +=  $$PWD
DEPENDPATH += $$PWD/Symbian

HEADERS += \
                $$PWD/scoresutility.h \
                $$PWD/myapplication.h \
                $$PWD/generalutilities.h \
                $$PWD/box2dqmlplugin/box2dworld.h \
                $$PWD/box2dqmlplugin/box2drevolutejoint.h \
                $$PWD/box2dqmlplugin/box2dprismaticjoint.h \
                $$PWD/box2dqmlplugin/box2dplugin.h \
                $$PWD/box2dqmlplugin/box2djoint.h \
                $$PWD/box2dqmlplugin/box2dfixture.h \
                $$PWD/box2dqmlplugin/box2ddistancejoint.h \
                $$PWD/box2dqmlplugin/box2ddestructionlistener.h \
                $$PWD/box2dqmlplugin/box2ddebugdraw.h \
                $$PWD/box2dqmlplugin/box2dbody.h \
                $$PWD/levelutility.h \
                $$PWD/xmlutility.h

symbian{
    HEADERS += \
                $$PWD/audioutility.h \
#                $$PWD/purchaseutility.h \
#                $$PWD/drmfile.h \
#                $$PWD/Symbian/drmfile_p.h
}

SOURCES += \
                $$PWD/main.cpp \
                $$PWD/scoresutility.cpp \
                $$PWD/myapplication.cpp \
                $$PWD/generalutilities.cpp \
                $$PWD/box2dqmlplugin/box2dworld.cpp \
                $$PWD/box2dqmlplugin/box2drevolutejoint.cpp \
                $$PWD/box2dqmlplugin/box2dprismaticjoint.cpp \
                $$PWD/box2dqmlplugin/box2dplugin.cpp \
                $$PWD/box2dqmlplugin/box2djoint.cpp \
                $$PWD/box2dqmlplugin/box2dfixture.cpp \
                $$PWD/box2dqmlplugin/box2ddistancejoint.cpp \
                $$PWD/box2dqmlplugin/box2ddestructionlistener.cpp \
                $$PWD/box2dqmlplugin/box2ddebugdraw.cpp \
                $$PWD/box2dqmlplugin/box2dbody.cpp \
                $$PWD/levelutility.cpp \
                $$PWD/xmlutility.cpp

symbian{
    SOURCES += \
                $$PWD/audioutility.cpp  \
#                $$PWD/purchaseutility.cpp \
#                $$PWD/drmfile.cpp \
#                $$PWD/Symbian/drmfile_p.cpp
}
