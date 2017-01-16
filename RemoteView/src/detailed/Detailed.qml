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
            identifier: Hostname
        }
        model: remoteworkstations
        groups: [
            DelegateModelGroup {
            includeByDefault: false
            name: "test"
            }
        ]
        filterOnGroup: "test"
        Component.onCompleted: {
            var rowCount = remoteworkstations.length; //23
             var entry2 =items.get(0)
            items.remove(0,rowCount); //0
            for( var i = 0;i < rowCount;i++ ) {
                var entry = root.remoteworkstations[i]; //Entry visible in the debugger


                //if(root.projectname === entry.AssignedProject.Projectname)
                    items.insert(entry,  "test"); //
            }
            console.log(items.count) //always 0
        }
    }

}
