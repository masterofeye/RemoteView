import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0

ApplicationWindow {
    id: appWindow
    width: 400; height: 400

    Text {
        anchors.centerIn: parent
        text: qsTr("Hello World.")
    }
}
