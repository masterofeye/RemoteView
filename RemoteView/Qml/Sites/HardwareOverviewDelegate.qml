import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import de.schleissheimer.rw 1.0
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
                /*SOFTWARE ANZEIGE*/
                SoftwareViewer
                {
                    id:softwareViewerContainer
                    width: 200
                    height: 80
                    softwareProjects:  Controller.CreateListOfSoftwareProjectsByProject(mainsection.project)
                }
                /*END SOFTWARE ANZEIGE*/

                ConnectButtonManager
                {
                    id: buttonContainer
                    width: 120
                    height: 80
                    //anchors.right: grid.right
                    //anchors.rightMargin: 25
                    Layout.row: 1
                    Layout.column: 3
                    workstation: mainsection.workstation
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
