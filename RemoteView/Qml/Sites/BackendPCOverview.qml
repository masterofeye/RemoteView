import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    width: parent.width
    height: parent.width   
    id: root

    property var project
    property bool isProcess: false
    property variant workstations : Controller.CreateListOfBackendWorkstations()
    ListView {
        cacheBuffer: 2000
        model:workstations
        anchors.fill: parent
        delegate: BackendOverview {
            text: model.modelData.hostname
            workstation: model.modelData
            processindicator: root.isProcess
        }

    }
}
