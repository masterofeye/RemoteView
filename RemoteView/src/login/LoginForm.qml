import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Rw.SessionManager 1.0
//import rw.sessionmanager 1.0
//https://jryannel.wordpress.com/2010/02/22/designing-a-login-view/
//https://doc.qt.io/archives/qt-5.5/enginio-qml-users-example.html
//http://portal.bluejack.binus.ac.id/tutorials/qtapplicationusingqmlandcwithmysqldatabase

//UserRole
Item {
    id: root

    function resetLoginForm()
    {
        textPassword.text = ""
        textUsername.text = ""
        //prevent the user to see the arrow message after he starts the screen again
        err.visible = false;
        popup.close();
        username.focus = true
    }

    Rectangle{
        color: "transparent"
        anchors.fill: parent
        anchors.topMargin: 20
        ColumnLayout {
            anchors.fill: parent
            spacing: 16
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 4
                Text{
                    id:username
                    text: "Username"
                    color: "grey"
                    font{
                        pixelSize: 16
                        bold: true
                    }
                    anchors{
                        leftMargin: 10

                    }
                }
                TextBox{
                    focus:true //The username textbox should have the focus at start
                    id: textUsername
                    width: 150
                    height: 30
                    anchors{
                        leftMargin: 10
                        top: username.bottom
                        topMargin: 5
                    }
                    KeyNavigation.tab: textPassword
                }
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 4
                Text{
                      id: password
                      text: "Password"
                      color: "grey"
                      font{
                          pixelSize: 16
                          bold: true
                      }
                      anchors{
                          bottom : textPassword.top
                          bottomMargin: 5
                          leftMargin: 10
                      }
                }
                TextBox{
                    id: textPassword
                    width: 150
                    height: 30
                    maxLength: 19
                    anchors{
                        leftMargin: 10
                    }
                    isPassword: true //Use the textbox as a passwordbox
                    onEnter: {
                        loginButton.doLogin();
                    }
                }
            }
            ColumnLayout {
                visible: false
                id:err
                property alias text: errtext.text
                Layout.alignment: Qt.AlignHCenter
                Text{
                    id:errtext
                    color:"red"
                    font{
                        pixelSize: 10
                        bold: true
                    }
                    anchors{
                        leftMargin: 100
                    }
                    Layout.alignment: Qt.AlignHCenter
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.leftMargin: 20
                spacing: 10
                Button {
                    id:loginButton
                    text: qsTr("Login")
                    Keys.onPressed:{
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                        {
                            loginButton.doLogin();
                            event.accepted = true
                        }
                    }
                    onClicked:
                    {
                        doLogin();
                    }

                    function doLogin()
                    {
                        if(textPassword.text.trim()==="" || textUsername.text.trim()==="")
                        {
                            err.visible = true;
                            err.text = "Username or password must be filled"
                        }
                        else if(SessionManager.AuthenticateUser(textUsername.text,textPassword.text))
                        {
                            console.log("IstUser:");
                            console.log(SessionManager.IsUserRole());
                            console.log("IstAdmin:");
                            console.log(SessionManager.IsAdminRole());
                            console.log("IstCaretaker:");
                            console.log(SessionManager.IsCaretakerRole());
                            root.resetLoginForm();
                        }
                        else
                        {
                            err.visible = true;
                            err.text = "Wrong Username or password"
                        }
                    }

                    background: Rectangle
                    {
                        id: bgloginButton
                        implicitWidth: 75
                        implicitHeight: 35
                        radius: 10
                        color: loginButton.down ? "#33b5e5" : "#212126"
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

                    font.pointSize: 15
                    onFocusChanged: {
                     if(activeFocus)
                         bgloginButton.color = "#434344"
                     else
                         bgloginButton.color = "#212126"
                    }
                }
                Button {
                    text: qsTr("Cancel")
                    id:closeLoginButton
                    background: Rectangle
                    {
                        id: bgCloseLoginButton
                        implicitWidth: 75
                        implicitHeight: 35
                        radius: 10
                        color: closeLoginButton.down ? "#33b5e5" : "#212126"
                    }
                    contentItem: Text {
                        text: closeLoginButton.text
                        font: closeLoginButton.font
                        opacity: enabled ? 1.0 : 0.1
                        color: closeLoginButton.down ? "#FFFFFF" : "#E6E6E6"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight

                    }
                    font.pointSize: 15
                    onClicked: {
                        //Close the Dialog and reset the form to the initial state
                        root.resetLoginForm();
                    }
                    onFocusChanged: {
                     if(activeFocus)
                         bgCloseLoginButton.color = "#434344"
                     else
                         bgCloseLoginButton.color = "#212126"
                    }

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                        {
                            //Close the Dialog and reset the form to the initial state
                            root.resetLoginForm();
                        }
                    }
                    KeyNavigation.tab: textUsername}
            }
        }
    }
}
