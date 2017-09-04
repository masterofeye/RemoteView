import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    width: parent.width
    height: parent.width   
    id: root

    property var project
    property variant workstations : Controller.CreateListOfBackendWorkstations()
    ListView {
        model:workstations
        anchors.fill: parent
        delegate: BackendOverview {
            text: model.modelData.hostname
            workstation: model.modelData
        }

    }
}
