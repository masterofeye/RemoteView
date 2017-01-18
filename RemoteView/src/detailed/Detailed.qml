import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQml.Models 2.2

Item {
    width: parent.width
    height: parent.width
    id: root
    property variant remoteworkstations
    property string projectname

    ListView {
        id: displayListView
        anchors.fill: parent
        spacing: 5
        model: displayDelegateModel
    }

    DelegateModel {
        id: displayDelegateModel

        delegate: MainSection{
            identifier: model.modelData.Hostname
            state: model.modelData.State
        }
        model: RemoteWorkstations
        groups: [
            DelegateModelGroup {
            includeByDefault: false
            name: "test"
            }
        ]
        filterOnGroup: "test"
        Component.onCompleted: {
            var rowCount = RemoteWorkstations.length;
            var state = items.get(0).model.modelData.State
            for( var i = 0;i < rowCount;i++ ) {
                if( items.get(i).model.modelData.AssignedProject.Projectname === projectname) {
                     items.get(i).inTest = true
                }
            }
        }
    }

}
