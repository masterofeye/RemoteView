import QtQuick 2.9
import QtQuick.Controls 2.2


Item {
    id: root
    width: parent.width
    height: parent.width

        Image {
            id: icon
            source: "../../Resourcen/PowerIconPositive.png"
            property bool active: false
            width: 88
            height: 88
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    icon.active = !icon.active;
                    if(icon.active)
                        icon.source = "../../Resourcen/PowerIconNegative.png"
                    else
                        icon.source = "../../Resourcen/PowerIconPositive.png"
                }

            }
        }
        Text {
            width: 70
            id: name
            x: 5
            y: 5
            font.bold: true
            font.pointSize: 12
            wrapMode:Text.Wrap
            text: qsTr("Minicube")
            color:"white"
        }

}
