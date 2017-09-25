import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1

Item {
    id: root
    property alias buttonText: remoteButton.text
    width: 200
    height: 40
    signal click 
    signal pressAndHold

    Button {
        id:remoteButton
        height: root.height
        width: root.width

        background: Rectangle
        {
            id: bgconnectButton
            width: root.width
            color: longPressArea.pressed ? "#33b5e5" : "#19191D"
            radius: 5
            border.width: 2
            border.color: "white"
            height: root.height
        }
        contentItem: Text {
            text: remoteButton.text
            font: remoteButton.font
            opacity: enabled ? 1.0 : 0.1
            color: longPressArea.pressed ? "#FFFFFF" : "#E6E6E6"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        Component.onCompleted: {
             remoteButton.clicked.connect(click)
        }


        font.pointSize: 15
        Keys.onPressed: {
            if (event.key === Qt.Key_Enter)
                popup.close();
        }

        MouseArea{
            id:longPressArea
            acceptedButtons: Qt.PreferredSize
            anchors.fill: parent
            propagateComposedEvents: true
            onPressAndHold: {
                root.pressAndHold()
                remoteButton.focus=false
            }

            Component.onCompleted: {
                 longPressArea.clicked.connect(click)
            }
        }

    }

}

