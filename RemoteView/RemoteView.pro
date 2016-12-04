QT += qml quick

CONFIG += c++11

SOURCES += main.cpp \
    remoteworkstation.cpp

RESOURCES += qml.qrc \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    remoteworkstation.h
