import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.2


Window {

width: 300
height: 200

    Rectangle {

        anchors.fill: parent

        color: "lightGrey"

        Text {

            anchors.centerIn: parent

            text: "My New Window"
        }
    }
}
