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
            color: "white"
            font.bold: true
            font.pointSize: 30
            text: "A717"
            anchors.centerIn: parent
        }


    }
}
