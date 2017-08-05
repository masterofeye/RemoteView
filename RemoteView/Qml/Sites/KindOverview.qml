import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
Item {
    width: parent.width
    height: parent.width
    id: root
    ListView {
        model: WorkstationKinds
        anchors.fill: parent
        delegate:
        ColumnLayout {
            width: parent.width
            height: 50
            Text {
                id: textitem
                color: "white"
                font.pixelSize: 32
                text: modelData
                anchors.left: parent.left
                anchors.leftMargin: 30

            }
            Rectangle {
                id: t2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 15
                height: 1
                color: "#424246"
            }
            MouseArea {
                id: mouse
                anchors.fill: parent
                onClicked:contentViewer.push(Qt.resolvedUrl("../Sites/"+modelData+"Overview.qml"))
            }
            Rectangle {
                id: t1
                anchors.fill: parent
                color: "#11ffffff"
                visible: mouse.pressed
                height: 10
            }

        }
    }
}
