import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import de.schleissheimer.rw 1.0
import "Qml/Components"
import "Qml/Sites"

ApplicationWindow {
    id: appWindow
    visible: true
    width: 640
    height: 720
    title: qsTr("RemoteView 3.0")
    minimumWidth: 480
    minimumHeight: 720

    /*BACKGROUND*/
    Rectangle {
        id: appWindowBackground
        color: "#212126"
        anchors.fill: parent
    }

    /*HEADER PART*/
    header: BorderImage {
        id: headerBackground
        border.bottom: 8
        source: "../../Resourcen/BorderEffectTop.png"
        width: parent.width
        height: 100
        /*HEADER CONTENT*/

        /*BACK BUTTON*/
        Rectangle {
            id: backButton
            height: 60
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            opacity: contentViewer.depth > 1 ? 1 : 0
            radius: 4
            antialiasing: true
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "../../Resourcen/PreviosArrow.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: contentViewer.pop()
            }
        }
        /*END BACK BUTTON*/
        /*TITELTEXT*/
        Text {
            id:titel
            font.pixelSize: 42
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: "RemoteView 3.0"
        }
        /*LOGINBUTTON*/
        LoginButton{
             text: "Login"
        }
        /*END HEADER CONTENT*/
    }
    /*END HEADER*/
    /*CONTENT PART*/
    ListModel {
        id: pageModel
        ListElement {
            title: "Daimler"
            page: "Sites/KindOverview.qml"
        }
    }

    StackView {
        id: contentViewer
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased:
            if (event.key === Qt.Key_Back|| event.key === Qt.Key_Backspace && contentViewer.depth > 1)
            {
                contentViewer.pop();
                event.accepted = true;
            }
        initialItem: Item {
            width: parent.width
            height: parent.height
            ListView {
                model: pageModel
                anchors.fill: parent
                delegate: KindOverview {
                }
            }
        }
    }

    /*CONTENT END*/
    /*FOOTER PART:  Fügt den Footer hinzu und den Hintergrundeffekt*/
    footer: BorderImage {
        id: footerBackground
        border.top: 8
        source: "../../Resourcen/BorderEffectBottom.png"
        width: parent.width
        height: 100

    }
    /*FOOTER END*/

}
