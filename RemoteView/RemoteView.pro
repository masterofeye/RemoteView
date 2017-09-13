QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp \
    C++/controller.cpp \
    C++/NetworkWrapper.cpp \
    C++/MessageWindow.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH += $$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Include
INCLUDEPATH += $$PWD/../../RemoteUtil/RemoteCommunicationLibrary/Include
INCLUDEPATH += $$PWD/../../RemoteUtil/RemoteThirdParty
INCLUDEPATH += $$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Src/DataBase/Repository

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Lib/Release -lRemoteDataConnectLibrary
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Lib/Debug -lRemoteDataConnectLibraryd
else:unix: LIBS += -L$$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Lib/ -lRemoteDataConnectLibrary


win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteCommunicationLibrary/Lib/Release -lRemoteCommunicationLibrary
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../RemoteUtil/RemoteCommunicationLibrary/Lib/Debug -lRemoteCommunicationLibraryd

DEPENDPATH += $$PWD/../../RemoteUtil/RemoteDataConnectLibrary/Include
DEPENDPATH += $$PWD/../../RemoteUtil/RemoteCommunicationLibrary/Include
DEPENDPATH += $$PWD/../../RemoteUtil/RemoteThirdParty



# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
    C++/controller.h \
    C++/NetworkWrapper.h \
    C++/MessageWindow.h
