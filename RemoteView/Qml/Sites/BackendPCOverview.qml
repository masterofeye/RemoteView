import QtQuick 2.9
import QtQuick.Controls 2.2
import de.schleissheimer.sessionmanager 1.0
import de.schleissheimer.workstationmodel 1.0
import de.schleissheimer.rw 1.0
Item {
    WorkstationModel {
        id: backendPC
        type:RW.BackendPC
    }

    width: parent.width
    height: parent.width   
    id: backendpcoverview
    property string objectName: ""
    property bool isProcess: false
    ListView {


        id:test
        cacheBuffer: 200
        anchors.fill: parent
        model: backendPC
        delegate: BackendOverview {
            text: Hostname
            workstation: model
        }
    }
}
