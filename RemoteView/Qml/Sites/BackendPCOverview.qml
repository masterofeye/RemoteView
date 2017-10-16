import QtQuick 2.9
import QtQuick.Controls 2.2
import de.schleissheimer.sessionmanager 1.0
Item {
    width: parent.width
    height: parent.width   
    id: backendpcoverview
    property string objectName: ""
    property var project
    property bool isProcess: false
    ListView {
        id:test
        cacheBuffer: 200
        anchors.fill: parent
        delegate: BackendOverview {
            text: model.modelData.hostname
            workstation: model.modelData
        }

        Component.onCompleted:
            test.model = getBackendWorkstation()

    }

    function getBackendWorkstation ()
    {
        var hostname = SessionManager.UserWorkstation()
        if(hostname.length === 0 )
           return ControllerInstance.CreateListOfBackendWorkstations()
        return hostname;
    }
}
