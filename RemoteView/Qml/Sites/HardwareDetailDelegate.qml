import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../../Qml/Components"

Item {
    id:mainsection
    width: parent.width
    height: 155

    property alias hostname: workstationIdentifier.identifier
    property variant project
    property var workstation

    Rectangle
    {
        id:test
        height: mainsection.height
        width: mainsection.width
        anchors.fill: parent
        color: "#212126"

        ColumnLayout{
            height: parent.height
            width: parent.width

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
                        //var comp = Qt.createComponent("FeatureList.qml");
                        //if(comp.status === Component.Ready)
                        //{
                        //   var obj = comp.createObject(this,{"anchors.fill": this, "elementCount" : model.modelData.ElementCfgQml.length, "model":model.modelData.ElementCfgQml})
                        //}
                    }
                }

                SoftwareViewer
                {
                    id:softwareViewerContainer
                    width: 200
                    height: 80
                    softwareProjects:  Controller.CreateListOfSoftwareProjectsByProject(mainsection.project)
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



            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 15
                height: 1
                color: "#424246"
            }
        }
    }
}
