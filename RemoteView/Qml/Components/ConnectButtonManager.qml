import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import de.schleissheimer.rw 1.0
import QtQuick.Controls.Styles 1.4
Item {
    id: root
    property var workstation
    Rectangle
    {
        id: managarerContainer
        color: "transparent"
        width: parent.width
        height: parent.height

        function shouldStart()
        {
            var val = workstation.State.valueOf()
            if(val === RW.OFF)
                return true;
            else
                return false;
        }

        function isVisible()
        {
            var val = workstation.State.valueOf()
            if(val === RW.FREE || val === RW.ON)
                return true;
            else
                return false;
        }

        ColumnLayout{
            id: layout
            anchors.fill: parent
            property var isProgVisible:false
            RemoteButton{
                id: button1
                buttonText: qsTr("Connect")
                visible: managarerContainer.isVisible()
                width: managarerContainer.width
                onClick: Controller.StartRemoteDesktop(Controller.Default,workstation.hostname);
            }

            RemoteButton{
                id: button2
                buttonText: qsTr("Disconnect")
                onClick: popup.close()
                visible: managarerContainer.isVisible()
                width: managarerContainer.width
            }

            RemoteButton{
                id: button3
                buttonText: qsTr("Start")
                onClick:
                {
                    button3.visible = false
                    busyindicator.visible = true;
                }
                visible: managarerContainer.shouldStart()
                height: 80
                width: managarerContainer.width

            }
            BusyIndicator {
                id:busyindicator
                anchors.horizontalCenter: parent.horizontalCenter
                running: true
                visible: false
            }
        }


    }


}
