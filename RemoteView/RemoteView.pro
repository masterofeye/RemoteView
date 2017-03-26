QT += qml quick

CONFIG += c++11

SOURCES += main.cpp \
    Session.cpp \
    Sessionmanager.cpp \
    Controller.cpp

RESOURCES += qml.qrc \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = \
src/detailed/

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    Session.h \
    Sessionmanager.h \
    Controller.h

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Lib/ -lRemoteDataConnectLibraryd
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Lib/ -lRemoteDataConnectLibraryd
else:unix: LIBS += -L$$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Lib/ -lRemoteDataConnectLibrary

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteCommunicationLibrary/Lib/ -lRemoteCommunicationLibraryd
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteCommunicationLibrary/Lib/ -lRemoteCommunicationLibraryd
else:unix: LIBS += -L$$PWD/../../RemoteUtil/RemoteCommunicationLibrary/Lib/ -lRemoteCommunicationLibrary

INCLUDEPATH += $$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Include
INCLUDEPATH += $$PWD/../../RemoteUtil/RemoteCommunicationLibrary/Include
INCLUDEPATH += $$PWD/../../RemoteUtil/thirdparty


DEPENDPATH += $$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Include
DEPENDPATH += $$PWD/../../RemoteUtil/RemoteCommunicationLibrary/Include

DISTFILES += \
    src/detailed/FeatureIcon.qml \
    src/detailed/FeatureList.qml \
    src/detailed/MainSection.qml \
    src/detailed/WorkstationIdentifier.qml
