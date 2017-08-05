import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    property string projectname
    width: parent.width
    height: parent.width
    ListView {
        model:Projects
        anchors.fill: parent
        delegate: OverviewDelegate {
            text: model.modelData.Projectname
            onClicked: contentViewer.push(Qt.resolvedUrl("HardwareOverview.qml"),{"project" : model.modelData})

        }
    }
}
