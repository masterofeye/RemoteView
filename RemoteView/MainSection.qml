import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Item {
    id:mainsection
    property string identifier

    Rectangle
    {
        anchors.fill: parent
        color: "#444444"

        GridLayout
        {
            columns: 4
            rows: 2
            anchors.fill: parent
            columnSpacing: 0
            rowSpacing: 0


            WorkstationIdentifier
            {
                Layout.row: 0
                Layout.column: 0
                Layout.rowSpan: 2
                width: 120
                height: 120
                identifier: mainsection.identifier
            }

            Rectangle
            {

                Layout.row: 1
                Layout.column: 1
                width: 120
                height: 80
                Component.onCompleted: {
                    var comp = Qt.createComponent("FeatureList.qml");
                    if(comp.status == Component.Ready)
                    {
                       var obj = comp.createObject(this,{"anchors.fill": this, "elementCount" : 6})
                        //console.log(model.modelData.features.length)
                    }
                }
            }

            Rectangle
            {
                Layout.row: 1
                Layout.column: 2
                width: 120
                height: 80
            }

            Rectangle
            {
                Layout.row: 1
                Layout.column: 3
                width: 120
                height: 80
            }

            StatusBar
            {
                Layout.row: 0
                Layout.column: 1
                Layout.columnSpan: 3
                Layout.alignment:  Qt.AlignVCenter | Qt.AlignLeft
                width: 500
                height: 30
                identifier: mainsection.identifier

            }

        }
    }
}
