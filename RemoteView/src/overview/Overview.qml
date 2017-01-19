import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    width: parent.width
    height: parent.width
    property var projects
    property var remoteworkstations
    id: root

    ListView {
        model: root.projects
        anchors.fill: parent
        delegate: AndroidDelegate {
            text: model.Projectname
            onClicked: stackView.push(Qt.resolvedUrl("../remoteWorkstation/RemoteWorkstation.qml"),{"projectname" : model.Projectname, "remoteworkstations":remoteworkstations})
        }
    }
}
