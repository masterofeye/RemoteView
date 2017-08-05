import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import de.schleissheimer.rw 1.0

Item {
    id: root

    Rectangle
    {
        id: managarerContainer
        color: "transparent"
        width: parent.width
        height: parent.height

        function shouldStart()
        {
            var val = mainsection.workstation.State.valueOf()
            if(val === RW.OFF)
                return true;
            else
                return false;
        }

        function isVisible()
        {
            var val = mainsection.workstation.State.valueOf()
            if(val === RW.FREE)
                return true;
            else
                return false;
        }

        ColumnLayout{
            anchors.fill: parent
            RemoteButton{
                id: button1
                buttonText: qsTr("Connect")
                visible: managarerContainer.isVisible()
                width: managarerContainer.width
                onClick: Controller.StartRemoteDesktop(Controller.Default,mainsection.workstation.hostname);
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
                onClick: popup.close()
                visible: managarerContainer.shouldStart()
                height: 80
                width: managarerContainer.width
            }
        }


    }


}
