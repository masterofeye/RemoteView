import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    width: parent.width
    height: parent.width
    property var projects
    property var remoteworkstations
    id: root
    MouseArea {
      anchors.fill: test
      onWheel: test.flick(0, wheel.angleDelta.y * 20)
    }
    ListView {
        id:test
        model: root.projects
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        delegate: OverviewDelegate {
            text: model.Projectname
            onClicked: contentViewer.push(Qt.resolvedUrl("../remoteWorkstation/RemoteWorkstation.qml"),{"projectname" : model.Projectname, "remoteworkstations":remoteworkstations})
        }
    }
}
