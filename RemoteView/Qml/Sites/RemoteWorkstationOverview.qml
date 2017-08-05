import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    width: parent.width
    height: parent.width
    property var projects
    property var remoteworkstations
    id: root
    ListModel
    {
        id: customerlist
        ListElement {
            CustomerName: "Daimler"
        }
        ListElement {
            CustomerName: "VW"
        }
        ListElement {
            CustomerName: "Ford"
        }
        ListElement {
            CustomerName: "Müller"
        }
    }
    ListView {
        model:customerlist
        anchors.fill: parent
        delegate: OverviewDelegate {
            text: CustomerName
            onClicked: contentViewer.push(Qt.resolvedUrl("ProjectsOverview.qml"),{"projectname" : CustomerName})
        }
    }
}
