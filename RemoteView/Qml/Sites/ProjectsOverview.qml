import QtQuick 2.9
import QtQuick.Controls 2.2
import de.schleissheimer.projectModel 1.0
Item {
    ProjectModel {
        id: myModel

    }

    property string projectname
    width: parent.width
    height: parent.width
    ListView {
        model:myModel
        anchors.fill: parent
        delegate: OverviewDelegate {
            text: Name
            onClicked: contentViewer.push(Qt.resolvedUrl("HardwareOverview.qml"),{"project" : ProjectObj})

        }
    }
}
