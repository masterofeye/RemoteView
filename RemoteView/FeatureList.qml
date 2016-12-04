import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQml.Models 2.1
import QtQuick.Controls 2.0
Item {
    property int elementCount: 7
    property variant modeldata : ({})
    id: test
    Grid{

        //property alias element: paremt.elementCount
        rows: 2
        columns: elementCount / 2 + elementCount % 2
        width : parent.width
        height : parent.height
        id: featureGrid
        Component.onCompleted: console.log(elementCount)

        Repeater{
            model: elementCount
            Rectangle{
                color: "#585858"
                border.color: "black"
                border.width: 2
                width: featureGrid.width / featureGrid.columns
                height: featureGrid.height / featureGrid.rows
                //Component.onCompleted: console.log(featureGrid.width);


                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(48, 48)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#BDBDBD" }
                        GradientStop { position: 1.0; color: "black" }
                    }
                }
                Rectangle {
                    width: 32; height: 32
                    color: "transparent"
                    anchors.centerIn: parent
                    id : tester
                    Image {
                        anchors.fill: parent
                        source: modeldata.modelData.features[index]

                    }

                    ToolTip {
                                id: toolTip
                                text: "ToolTip"
                                visible: mouseArea.pressed
                            }
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                    }
                }
            }
       }

    }
}
