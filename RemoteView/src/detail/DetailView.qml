import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

Item {
    id:root
    property var elementCfg
    Rectangle{
        width: root.width
        height: root.height
        color: "transparent"
        radius: 5

        ColumnLayout{
            anchors.fill: parent
            GridLayout{
                columns: 3
                Repeater {
                    model: elementCfg
                    delegate: elementCfgButton
                }
            }

            width: parent.width;
            ListView {
                Layout.alignment: Qt.AlignBottom
                id:logView
                width: parent.width;
                height:root.height/2
                model: Logs
                focus: true
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                highlightFollowsCurrentItem: false
                delegate:logEntry
//                section.property: "Message"
//                        section.criteria: ViewSection.FullString
//                        section.delegate: Rectangle{
//                            width: logView.width
//                            height: 5
//                            color: "red"
//                        }
            }
        }
    }

    Component{
        id: logEntry
        Item
        {
            width: parent.width
            height: icon.height
            id: test
            RowLayout{
                id: row
                width: parent.width
                Column{
                    Layout.alignment: Qt.AlignLeft
                    width: 400
                    Text {
                        font.pointSize: 12
                        text: "Date: " + LogTime
                        color: "white"
                    }
                    Text {
                        font.pointSize: 10
                        text: "Logmessage: " + Message
                        color: "white"
                        width: parent.width
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }
                Image {
                    Layout.alignment: Qt.AlignRight
                    id: icon
                    width:64
                    source: "../../Resourcen/177.png"
                }

            }
            MouseArea {
                anchors.fill: row
                onClicked: test.ListView.view.currentIndex = index
            }
        }
    }

    Component
    {id: elementCfgButton
        Item{
            width:128
            height:72
            Rectangle{
                anchors.fill: parent
                color:"#34343B"
                radius: 5
                ColumnLayout{
                    anchors.fill: parent
                    Text
                    {
                        Layout.alignment: Qt.AlignHCenter
                        text: model.modelData.Name
                        color: "white"
                        font.bold: true
                    }
                    Loader { sourceComponent: switchButton }
                }
            }

        }
    }

    Component{
        id:switchButton
        Item
        {
            width: 128
            height: 54
            id:root
            signal clicked
            property bool checked: false
            Image{
                id: backgroundImage
                anchors.fill: parent
                source: checked ? "../../Resourcen/yes.png" : "../../Resourcen/no.png"
            }
            Text {
                id: innerText
                anchors.centerIn: parent
                font.bold: true
                text:"OFF"
                color: "red"
            }
            MouseArea {
                id: button
                objectName: "button"
                signal newMessage()
                onNewMessage:
                {
                }

                anchors.fill: root
                onClicked: {
                    if(mouse.button & Qt.RightButton) {
                        console.log("test")
                    }
                    root.clicked();}
                onPressed: {
                    if(checked)
                    {
                        backgroundImage.source = "../../Resourcen/no.png";
                        checked = false;
                        innerText.text = "OFF"
                        innerText.color = "red"
                    }
                    else
                    {
                        backgroundImage.source ="../../Resourcen/yes.png"
                        checked = true;
                        innerText.text = "ON"
                        innerText.color = "green"
                    }
                }
            }
            Menu {
                id: contextmenu
                x: 20
                y: 20
                modal: true

                MenuItem {
                    text: "Compare"
                    height: 20
                }
                MenuItem {
                    text: "Send..."
                    height: 20
                }
                MenuItem {
                    text: "Edit..."
                }
                MenuItem {
                    text: "Delete"
                }
            }
        }
    }

}


