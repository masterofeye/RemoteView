import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQml.Models 2.1
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: root
    property int elementCount: 0
    property variant filteredModel
    property variant model : ({})

    readonly property int minWidthIconSize : 32
    readonly property int minHeightIconSize : 32
    readonly property int maxWidthFeatureSize : 40
    readonly property int maxHeightFeatureSize : 40

    function filterElementConfiguration()
    {
        var tmp = model
        var copy = []
        var j = 0;
        for (var i = 0; i < tmp.length; ++i)
        {
            console.log(tmp[i].Name)
            console.log(tmp[i].IsFeature)
            if(tmp[i].IsFeature)
            {
                copy[j] = tmp[i];
                j++;
            }
        }
        filteredModel = copy;
        elementCount = filteredModel.length;
    }

    Component.onCompleted: filterElementConfiguration()

    GridLayout{
        //property alias element: paremt.elementCount
        //rows: 2
        columns: elementCount / 2 + elementCount % 2
        width : maxHeightFeatureSize *elementCount/2
        height : maxHeightFeatureSize * 2
        id: featureGrid
        rowSpacing: 0
        columnSpacing: 0

        Repeater{
            model: filteredModel
            Rectangle{
                color: "#585858"
                border.color: "black"
                border.width: 2
                width: featureGrid.width / featureGrid.columns
                height: featureGrid.height / featureGrid.rows

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: root.maxWidthFeatureSize
                Layout.minimumWidth: root.maxHeightFeatureSize

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
                        source: mapStringToPicture(filteredModel[index].Name)
                    }

                    function mapStringToPicture(PicName){
                        switch(PicName)
                        {
                             case "Name":
                                 return "../../Resourcen/technology-23.png"
                                 break;
                        }
                    }

                    ToolTip {
                        id: toolTip
                        text: filteredModel[index].ToolTip
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
