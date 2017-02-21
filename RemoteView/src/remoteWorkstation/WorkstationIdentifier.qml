import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    property alias  identifier : identifierLabel.text

    Rectangle{
        anchors.fill: parent
        color : "#333333"
        radius: 5

        border.width: 2
        border.color: "white"

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onEntered:
            {
                parent.color = "#454545";
            }
            onExited:
            {
                parent.color = "#333333";
            }
            onClicked: {
                stackView.push(Qt.resolvedUrl("../detail/DetailView.qml"),{"elementCfg":model.modelData.ElementCfgQml})
            }

        }

        Label{
            id: identifierLabel
            color: "white"
            font.bold: true
            font.pointSize: 30
            text: identifier
            anchors.centerIn: parent
        }


    }
}
