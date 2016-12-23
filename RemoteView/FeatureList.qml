import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQml.Models 2.1
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property int elementCount: 7
    property variant modeldata : ({})
    readonly property int minWidthIconSize : 32
    readonly property int minHeightIconSize : 32

    readonly property int maxWidthFeatureSize : 48
    readonly property int maxHeightFeatureSize : 48

    id: test
    GridLayout{

        //property alias element: paremt.elementCount
        //rows: 2
        columns: elementCount / 2 + elementCount % 2
        width : maxHeightFeatureSize *elementCount/2
        height : maxHeightFeatureSize * 2
        id: featureGrid
        rowSpacing: 0
        columnSpacing: 0

       //Component.onCompleted: console.log(elementCount)

        Repeater{
            model: elementCount
            Rectangle{
                color: "#585858"
                border.color: "black"
                border.width: 2
                width: featureGrid.width / featureGrid.columns
                height: featureGrid.height / featureGrid.rows

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: 48
                Layout.minimumWidth: 48


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
                    width: minWidthIconSize; height: minHeightIconSize
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
