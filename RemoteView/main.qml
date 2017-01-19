import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.4

import './src/remoteWorkstation'
import "./src/overview"
import "./src/login"


ApplicationWindow {
    visible: true
    width: 640
    height: 720
    title: qsTr("Hello World")
    minimumWidth: 480
    minimumHeight: 720


    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }

    header: BorderImage {
        border.bottom: 8
        source: "../../Resourcen/toolbar.png"
        width: parent.width
        height: 100
        Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 60
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "../../Resourcen/navigation_previous_item.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: stackView.pop()
            }
        }

        Text {
            font.pixelSize: 42
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: "RemoteView 3.0"
            id:titel
        }

        Button
        {
            id:control

            background: Rectangle
            {
                implicitWidth: 100
                implicitHeight: 50
                radius: 10
                color:"black"
            }
            contentItem: Text {
                text: control.text
                font: control.font
                opacity: enabled ? 1.0 : 0.1
                color: control.down ? "#FFFFFF" : "#E6E6E6"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            text: "Login"
            font.pointSize: 20;
            anchors.right: parent.right
            anchors.verticalCenter: titel.verticalCenter

            onClicked: popup.open()
        }

        Popup {
            id: popup
            x: 100
            y: 100
            width: 250
            height: 200
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape
            background :Rectangle {
                color: "#212126"
                anchors.fill: parent
            }
            BorderImage {
                border.bottom:  8
                border.left:  8
                border.top: 8
                border.right: 8
                source: "../../Resourcen/highlight.png"
                width: 250
                height: 200
                LoginForm{}
            }
        }
    }
    ListModel {
        id: pageModel
        ListElement {
            title: "Daimler"
            page: "src/overview/Overview.qml"
        }

    }

    StackView {
        id: stackView
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back|| event.key === Qt.Key_Backspace && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }

        initialItem: Item {
            width: parent.width
            height: parent.height
            ListView {
                model: pageModel
                anchors.fill: parent
                delegate: AndroidDelegate {
                    text: title
                    onClicked: stackView.push(Qt.resolvedUrl(page),{"projects" : Projects, "remoteworkstations" : RemoteWorkstations})
            }
        }
    }
}

    footer: BorderImage {
        border.top: 8
        source: "../../Resourcen/statusbar.png"
        width: parent.width
        height: 100

    }
}
