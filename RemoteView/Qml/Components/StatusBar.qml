import QtQuick 2.0
import QtQuick.Controls 2.0
import de.schleissheimer.rw 1.0
Item {
    Rectangle{
        anchors.fill: parent
        color : "#333333"
        radius: 5
        border.width: 2
        border.color: "white"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                id: statusColor
                position: 0.463
                color: "#800000"
            }
        }

        Label{
            id: statusLabel
            color: "white"
            font.bold: true
            font.pointSize: 22
            anchors.centerIn: parent
            property var adasjkdasl: model.modelData.State
            Component.onCompleted: {

                statusLabel.text = model.modelData.State.toString()
                switch(model.modelData.State.valueOf())
                {
                case RW.ON:
                    statusLabel.text =  model.modelData.CurrentUser.UserName
                    statusColor.color = "darkred"
                    break;
                case RW.OFF:
                    statusColor.color = "black"
                    break;
                case RW.RESERVE:
                    statusColor.color = "darkviolet"
                    break;
                case RW.DEFECT:
                    statusColor.color = "darkred"
                    break;
                case RW.FREE:
                    statusColor.color = "darkgreen"
                    break;
                case RW.OCCUPY:
                    statusColor.color = "darkmagenta"
                    break;
                }
            }
        }


    }
}
