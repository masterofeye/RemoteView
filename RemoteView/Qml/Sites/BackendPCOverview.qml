import QtQuick 2.9
import QtQuick.Controls 2.2
import de.schleissheimer.sessionmanager 1.0
Item {
    width: parent.width
    height: parent.width   
    id: root

    property var project
    property bool isProcess: false
    ListView {
        cacheBuffer: 2000
        model:getBackendWorkstation()
        anchors.fill: parent
        delegate: BackendOverview {
            text: model.modelData.hostname
            workstation: model.modelData
            processindicator: root.isProcess
        }

    }

    function getBackendWorkstation ()
    {
        var hostname = SessionManager.UserWorkstation()
        if(hostname.length === 0 )
           return ControllerInstance.CreateListOfBackendWorkstations()
        return hostname;
    }
}
