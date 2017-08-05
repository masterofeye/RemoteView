import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    width: parent.width
    height: parent.width
    Text {
        id: textitem
        color: "white"
        font.pixelSize: 32
        text: "Daimler"
        //anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
    }
}
