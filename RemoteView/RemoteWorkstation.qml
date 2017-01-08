import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: remoteWorkstation
    property string pcId : "NAN"
    height: 144
    Row {
        id: basicLayout
        anchors.fill: parent
        Rectangle{
            id: pcName
            width: parent.width * 1/5
            height: parent.height
            border.color : "black"
            border.width : 1
            radius : 10

            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#ffffff"
                }

                GradientStop {
                    position: 0.116
                    color: "#585858"
                }
            }
            anchors.top: parent.top

            Label{
                color: "white"
                font.bold: true
                font.pointSize: 30
                text: remoteWorkstation.pcId
                anchors.centerIn: parent
            }
        }

        Column{

            id: rightSection
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width * 4/5
            Rectangle{
                id: statusBar
                height: basicLayout.height *1/3
                border.color : "black"
                border.width : 1
                radius : 10
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#ffffff"
                    }

                    GradientStop {
                        id: statusColor
                        position: 1
                        color: "#800000"
                        Component.onCompleted: {
                            if(model.modelData.status == "Free")
                            {
                                this.color = "#1b841b"
                            }
                        }
                    }
                }
                anchors.left: parent.left
                anchors.right: parent.right

                Label{
                    color: "white"
                    font.bold: true
                    font.pointSize: 18
                    text: model.modelData.status
                    anchors.centerIn: parent
                }
            }

            Row{
                id:mainSection
                height: basicLayout.height *2/3
                anchors.left: parent.left
                anchors.right: parent.right
                Rectangle{
                    id:temp
                    height: parent.height
                    width: rightSection.width * 3/7
                    color: "#f6f6f6"

                    Component.onCompleted: {
                        var comp = Qt.createComponent("FeatureList.qml");
                        if(comp.status == Component.Ready)
                        {
                           var obj = comp.createObject(this,{"anchors.fill": this, "modeldata" : model, "elementCount" : model.modelData.features.length})
                            //console.log(model.modelData.features.length)
                        }
                    }
                }
                Column{
                    id:acgcColumn
                    height: parent.height
                    anchors.left: temp.right
                    width: rightSection.width * 2/7
                    Rectangle{
                        id:ac
                        height: parent.height / 2

                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: "#585858"
                        border.width: 1
                        Row{
                            anchors.fill:parent
                            id: gcLayout
                            Text {
                                id: acLabel
                                color: "#f6f6f6"
                                text: qsTr("AC: ")
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                width: gcLayout.width * 2/7
                                font.pixelSize: 10
                            }
                            Text {
                                id: acSoftware
                                color: "#f6f6f6"
                                text: qsTr("BR213IC-HL-AC_MY17")
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                width: gcLayout.width * 5/7
                                font.pixelSize: 10
                            }
                        }
                    }

                    Rectangle{
                        id:gcPlace
                        height: parent.height / 2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: "#585858"
                        border.width: 1

                        Row{
                            anchors.fill:parent
                            id: acLayout

                            Text {
                                id: gcLabel
                                color: "#f6f6f6"
                                text: qsTr("GC: ")
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                width: gcLayout.width * 1/7
                                font.pixelSize: 10
                            }
                            Text {
                                id: gcSoftware
                                color: "#f6f6f6"
                                text: qsTr("BR213IC-HL-GC_MY17")
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                width: gcLayout.width * 6/7
                                font.pixelSize: 10
                            }
                        }

                    }
                }
                Rectangle{
                    id:connect
                    height: parent.height
                    anchors.left: acgcColumn.right
                    anchors.right: parent.right
                    color: "#585858"

                    Button {
                        id: button1
                        text: qsTr("Button")
                        anchors.fill: parent
                    }
                }

            }
        }
    }
}
