import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import de.schleissheimer.rw 1.0
import de.schleissheimer.controller 1.0
import QtQuick.Controls.Styles 1.4
import Qt.labs.settings 1.0

Item {
    id: myitem
    property var workstation
    property bool process : settings.process

    Settings {
        id: settings
        property bool process : false
    }

    Component.onDestruction: {
        settings.process = myitem.process
    }

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
            if(val === RW.FREE || val === RW.ON || val === RW.OCCUPY)
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
                width: managarerContainer.width
                onClick: ControllerInstance.StartRemoteDesktop(Controller.Default,workstation.hostname);
                onPressAndHold: {
                    popup.open()
                }


                Component.onCompleted:
                {
                    button1.visible = managarerContainer.isVisible()
                }
                Popup {
                    id: popup
                    x: -200
                    y: -50
                    width: 200
                    height: 170
                    modal: true
                    focus: true
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                    background: Rectangle{
                        id: bgconnectButton
                        width: popup.width
                        height: popup.height
                        color: "#19191D"
                        radius: 5
                        border.width: 2
                        border.color: "white"
                    }

                    ColumnLayout
                    {
                        anchors.fill: parent
                        RemoteButton{
                             id:defaultRDP
                             width: popup.width -20
                             buttonText: qsTr("Default")
                             onClick:
                             {
                                 ControllerInstance.StartRemoteDesktop(Controller.DEFAULT,workstation.hostname);
                                 popup.close()
                             }
                        }
                        RemoteButton{
                             id:doubleRDP
                             width: popup.width -20
                             buttonText: qsTr("DualScreen")
                             onClick:{
                                 ControllerInstance.StartRemoteDesktop(Controller.DUALSCREEN,workstation.hostname);
                                 popup.close()
                             }
                        }
                        RemoteButton{
                             id:allscreenRDP
                             width: popup.width -20
                             buttonText: qsTr("AllScreen")
                             onClick: {
                                 ControllerInstance.StartRemoteDesktop(Controller.ALLSCREEN,workstation.hostname);
                                 popup.close()
                             }
                        }
                    }
                }
            }

            RemoteButton{
                id: button2
                buttonText: qsTr("Disconnect")
                onClick: popup.close()
                width: managarerContainer.width

                Component.onCompleted:
                {
                    button2.visible = managarerContainer.isVisible()
                }
            }

            RemoteButton{
                id: button3
                buttonText: qsTr("Start")
                width: managarerContainer.width
                onClick:
                {
                    button3.visible = false
                    busyindicator.state = "active"
                    ControllerInstance.WakeUpPC(workstation.Mac, workstation.hostname)
                }

                Connections {
                    target: ControllerInstance
                    onWakeUpFeedback: {
                        if(Hostname ===  workstation.hostname)
                        {
                            if(Ret === false)
                            {
                                //Hier erneut den Start button sichtbar schalten
                                button3.visible = true
                                busyindicator.state = "inactive"
                            }
                            else
                            {
                                //Hier die Connect und Disconnect Buttons sichtbar schalten
                                button3.visible = false
                                button1.visible = true;
                                button2.visible = true;
                                busyindicator.state = "inactive"
                            }
                        }
                    }
                }
                height: 80

                Component.onCompleted:
                {
                    button3.visible = managarerContainer.shouldStart()
                }
            }
            BusyIndicator {
                id:busyindicator
                anchors.horizontalCenter: parent.horizontalCenter
                running: true
                enabled: false
                visible: false
                states: [
                    State { name: "active"; when: button3.pressed
                        PropertyChanges { target: busyindicator; enabled: true; visible: true }
                    },
                    State { name: "inactive";
                        PropertyChanges { target: busyindicator; enabled: false; visible: false }
                    }
                ]
            }
        }


    }


}
