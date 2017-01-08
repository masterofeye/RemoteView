QT += qml quick

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    test.h

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Lib/ -lRemoteDataConnectLibrary
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Lib/ -lRemoteDataConnectLibraryd
else:unix: LIBS += -L$$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Lib/ -lRemoteDataConnectLibrary

INCLUDEPATH += $$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Include
INCLUDEPATH += $$PWD/../../RemoteUtil/thirdparty
DEPENDPATH += $$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Include
