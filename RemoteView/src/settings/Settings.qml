import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Window {

width: 300
height: 200


    TabBar {
        id: bar
        width: parent.width
        TabButton {
            text: qsTr("Home")
        }
        TabButton {
            text: qsTr("Discover")
        }
        TabButton {
            text: qsTr("Activity")
        }
    }

    StackLayout {
        width: parent.width
        currentIndex: bar.currentIndex
        Item {
            id: homeTab
            GroupBox {
                title: "Default RemoteMonitor"

                RowLayout {
                    anchors.fill: parent
                    CheckBox { text: qsTr("SingleScreen") }
                    CheckBox { text: qsTr("DualScreen") }
                    CheckBox { text: qsTr("MultiScreen") }
                }
            }
        }
        Item {
            id: discoverTab
        }
        Item {
            id: activityTab
        }
    }
}
