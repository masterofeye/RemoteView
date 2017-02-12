import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
//http://de.slideshare.net/VPlay-Game-Engine/2014-1007qt-dev-days-14-berlinfinalforweb
Item {
    id:mainsection
    width: parent.width
    height:120
    property string identifier
    property int state
    property var featurelist
    Rectangle
    {
        id:test
        height: mainsection.height
        width: mainsection.width
        anchors.fill: parent
        color: "#444444"

        GridLayout
        {
            columns: 4
            rows: 2
            anchors.fill: parent
            columnSpacing: 4
            rowSpacing: 4
            id: grid

            WorkstationIdentifier
            {
                id:workstationIdentifier
                Layout.row: 0
                Layout.column: 0
                Layout.rowSpan: 2
                width: 120
                height: 120
                identifier: mainsection.identifier
                Layout.maximumWidth : 120
            }

            Rectangle
            {
                anchors.left: workstationIdentifier.right
                anchors.leftMargin: 5
                id: featureContainer
                Layout.row: 1
                Layout.column: 1
                width: 120
                height: 80
                color: "transparent"
                Component.onCompleted: {
                    var comp = Qt.createComponent("FeatureList.qml");
                    if(comp.status == Component.Ready)
                    {
                       console.log("elemen");
                       var obj = comp.createObject(this,{"anchors.fill": this, "elementCount" : model.modelData.ElementCfgQml.length, "modeldatas":model.modelData.ElementCfgQml})
                    }
                }
            }

            Rectangle
            {
                anchors.left: featureContainer.right
                anchors.leftMargin: 5
                id: softwareContainer
                Layout.row: 1
                Layout.column: 2
                width: 200
                height: 80
                color: "#19191C"
                radius: 5
                border.width: 2
                border.color: "white"
                visible: isSoftwareVisibile()
                Component.onCompleted: {

                }
                function isSoftwareVisibile()
                {
                    return (statusbar.width - featureContainer.width - buttonContainer.width - 30) >  (softwareContainer.width)
                }
                GridLayout{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    id: softwaregrid
                    columns:2
                    rows:2
                    Text{
                        id: acField
                        text: "AC:"
                        Layout.row: 0
                        Layout.column: 0
                        font.pointSize: 16
                        color: "white"
                    }
                    Text{
                        id: acSoftware
                        text: "E033_pre20"
                        Layout.row: 0
                        Layout.column: 1
                        font.pointSize: 16
                        color: "white"
                    }
                    Text{
                        id: gcField
                        text: "GC:"
                        Layout.row: 1
                        Layout.column:0
                        font.pointSize: 16
                        color: "white"
                    }
                    Text{
                        id: gcSoftware
                        text: "E033_pre20"
                        Layout.row: 1
                        Layout.column: 1
                        font.pointSize: 16
                        color: "white"
                    }
                }
            }

            Rectangle
            {
                id: buttonContainer
                Layout.row: 1
                Layout.column: 3
                width: 120
                height: 80
                anchors.right: grid.right
                anchors.rightMargin: 25
                color: "transparent"
                ColumnLayout{
                    Button {
                        text: qsTr("Connect")
                        id:connectButton
                        background: Rectangle
                        {
                            id: bgconnectButton
                            width: 120
                            implicitHeight: 35
                            color: connectButton.down ? "#33b5e5" : "#19191D"
                            radius: 5
                            border.width: 2
                            border.color: "white"
                        }
                        contentItem: Text {
                            text: connectButton.text
                            font: connectButton.font
                            opacity: enabled ? 1.0 : 0.1
                            color: connectButton.down ? "#FFFFFF" : "#E6E6E6"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight

                        }
                        font.pointSize: 15
                        onClicked: popup.close()
                        //onFocusChanged: {
//                         if(activeFocus)
//                             bgconnectButton.color = "#33b5e5"
//                         else
//                             bgconnectButton.color = "#19191D"
//                        }
                        Keys.onPressed: {
                            if (event.key === Qt.Key_Enter)
                                popup.close();
                        }
                    }

                    Button {
                        text: qsTr("Disconnect")
                        id:disconnectButton
                        background: Rectangle
                        {
                            id: bgdisconnectButton
                            width: 120
                            implicitHeight: 35
                            color: disconnectButton.down ? "#33b5e5" : "#19191D"
                            radius: 5
                            border.width: 2
                            border.color: "white"
                        }
                        contentItem: Text {
                            text: disconnectButton.text
                            font: disconnectButton.font
                            opacity: enabled ? 1.0 : 0.1
                            color: disconnectButton.down ? "#FFFFFF" : "#E6E6E6"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight

                        }
                        font.pointSize: 15
                        onClicked: popup.close()
                        Keys.onPressed: {
                        }
                    }
                }
            }

            StatusBar
            {
                id:statusbar
                Layout.row: 0
                Layout.column: 1
                Layout.columnSpan: 3
                Layout.alignment:  Qt.AlignVCenter | Qt.AlignLeft
                width: mainsection.width - workstationIdentifier.width - 10
                height: 30
                anchors.left: workstationIdentifier.right
                anchors.leftMargin: 5
                Layout.preferredWidth: mainsection.width - workstationIdentifier.width - 10

            }
        }
    }
}
