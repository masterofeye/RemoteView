import QtQuick 2.9
import QtQuick.Controls 2.2
import de.schleissheimer.workstationmodel 1.0
Item {
    WorkstationModel {
        id: myModel
        type:RW.RemoteWorkstation
        projectName: root.project
    }

    id: root
    width: parent.width
    height: parent.width
    property var project
    ListView {
        model:myModel
        anchors.fill: parent
        delegate: HardwareOverviewDelegate {
            hostname: Hostname
            project: root.project
            workstation : myModel
        }
    }

}
