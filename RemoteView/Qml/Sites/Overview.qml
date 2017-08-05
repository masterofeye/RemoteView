import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    width: parent.width
    height: parent.width
    property var projects
    property var remoteworkstations
    id: root
    ListView {
        model: root.projects
        anchors.fill: parent
        delegate: OverviewDelegate {
            text: model.Projectname
            onClicked: contentViewer.push(Qt.resolvedUrl("../remoteWorkstation/RemoteWorkstation.qml"),{"projectname" : model.Projectname, "remoteworkstations":remoteworkstations})
        }
    }
}
