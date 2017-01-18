import QtQuick 2.0
import QtQuick.Controls 2.0

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
            Component.onCompleted: {
                var state = model.modelData.State
                switch(state.valueOf())
                {
                case 0:
                    statusLabel.text =  "FREE"
                    statusColor.color = "green"
                    break;
                case 1:
                    statusLabel.text = "OFF"
                    statusColor.color = "black"
                    break;
                case 2:
                    statusLabel.text = "RESERVED"
                    statusColor.color = "yellow"
                    break;
                case 3:
                    statusLabel.text = "DEFECT"
                    statusColor.color = "red"
                    break;
                }
            }
        }


    }
}
