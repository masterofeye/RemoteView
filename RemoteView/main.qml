import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    ListView{
        id: view
        anchors.fill: parent
        model: myModel
        delegate: RemoteWorkstation{
            width: view.width
            height: view/model.count
            pcId: model.modelData.name

        }
    }


    /*SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1 {
            RemoteWorkstation{
                anchors.fill : parent
            }
        }

        Page {
            Label {
                text: qsTr("Second page")
                anchors.centerIn: parent
            }
        }
    }*/

    /*footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
    }*/
}
