import QtQuick 2.5
import QtQuick.Controls 2.1
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: appWindow
    width: 400; height: 400

    Rectangle {
        id: appWindowBackground
        color: "#212126"
        anchors.fill: parent
    }

    TabBar {
        id: bar
        width: parent.width
        TabButton {
            text: qsTr("User")
        }
        TabButton {
            text: qsTr("Reserved")
        }
    }

    StackLayout {
        anchors.top: bar.bottom
        width: parent.width
        currentIndex: bar.currentIndex
        Item {
            id: usersettingstab
            ColumnLayout
            {
                RowLayout{
                    Text{
                        font.pixelSize: 24
                        Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
                        x: backButton.x + backButton.width
                        anchors.verticalCenter: parent.verticalCenter
                        color: "white"
                        text: "Use Ballon Messages on Desktop: "
                    }
                    Switch{

                }
                }
                RowLayout{
                    Text{
                        font.pixelSize: 24
                        Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
                        x: backButton.x + backButton.width
                        anchors.verticalCenter: parent.verticalCenter
                        color: "white"
                        text: "Use Ballon Messages on RemoteDesktop: "
                    }
                    Switch{

                    }
                }
            }
        }
        Item {
            id: usersettingstab2
            Text{
                text: "UseBallonMessages: "
            }
            Button{

            }
        }
    }
}
