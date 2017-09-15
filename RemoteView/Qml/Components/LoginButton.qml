import QtQuick 2.9
import QtQuick.Controls 2.2


Button
{
    id:loginButton
    font.pointSize: 20;
    anchors.right: parent.right
    anchors.verticalCenter: titel.verticalCenter
    property bool loggedIn: false
    onLoggedInChanged:{
        if(loggedIn)
            loginButton.text = "Settings"
        else
            loginButton.text = "Login"
    }

    background: Rectangle
    {
        implicitWidth: 100
        implicitHeight: 50
        radius: 10
        color:"black"
    }
    contentItem: Text {
        text: loginButton.text
        font: loginButton.font
        opacity: enabled ? 1.0 : 0.1
        color: loginButton.down ? "#FFFFFF" : "#E6E6E6"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    LoginWrapper {
        id: loginPopup
    }



    onClicked:{
        if(!loggedIn)
        {
            loginPopup.open()
        }
        else
        {
            var component = Qt.createComponent(Qt.resolvedUrl("../Sites/Settings.qml"));
            if (component.status == Component.Ready) {
                var win = component.createObject(appWindow);
            }
            else
            {
                console.log(component.errorString())
                //Todo Error
            }

            win.show();
        }
    }
}
