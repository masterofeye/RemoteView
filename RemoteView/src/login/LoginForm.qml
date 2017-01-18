import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

//import rw.sessionmanager 1.0
//https://jryannel.wordpress.com/2010/02/22/designing-a-login-view/
//https://doc.qt.io/archives/qt-5.5/enginio-qml-users-example.html
//http://portal.bluejack.binus.ac.id/tutorials/qtapplicationusingqmlandcwithmysqldatabase

//UserRole
Item {
    Rectangle{
        anchors.fill: parent
        anchors.topMargin: 20
        ColumnLayout {
            anchors.fill: parent
            spacing: 16
            ColumnLayout {

                Layout.alignment: Qt.AlignHCenter
                spacing: 4
                Text{

                    id: username
                    text: "Username"
                    color: "grey"
                    font{
                        pixelSize: 12
                        bold: true
                    }
                    anchors{
                        leftMargin: 10
                    }
                }
                TextBox{
                    id: textUsername
                    width: 150
                    height: 20
                    maxLength: 20
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
                          pixelSize: 12
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
                    height: 20
                    maxLength: 19
                    anchors{
                        leftMargin: 10
                    }
                    isPassword: true
                    onFocusChanged:{
                        focus :true
                    }

                    onEnter: {
                        if(textPassword.text.trim()==="" || textUsername.text.trim()==="")
                        {
                            err.visible = true;
                            err.text = "Username or password must be filled"
                        }
                        else if(Services.doLogin(textUsername.text,textPassword.text))
                        {
                            Session.username = textUsername.text;
                            var userid = Services.getUserID(Session.username);
                            if(Services.getUserRole(userid)==="Assistant Supervisor")
                            {
                                container.state = "AstSpv";
                            }
                            else
                            {
                                container.state = "MainMenu";
                            }
                        }
                        else
                        {
                            err.visible = true;
                            err.text = "Wrong Username or password"
                        }
                    }
          }
            }
            RowLayout {
                Layout.alignment: Qt.AlignRight
                Layout.leftMargin: 20
                Button {
                    text: qsTr("Login")
                    id:loginButton
                    onClicked:
                    {
                        var session = Sessionmanager.Instance()
                        session.ActiveSession
                    }
                    background: Rectangle
                    {
                        id: bgloginButton
                        implicitWidth: 80
                        implicitHeight: 40
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
                        implicitWidth: 80
                        implicitHeight: 40
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
                    onClicked: popup.close()
                    onFocusChanged: {
                     if(activeFocus)
                         bgCloseLoginButton.color = "#434344"
                     else
                         bgCloseLoginButton.color = "#212126"
                    }
                    Keys.onPressed: {
                        if (event.key === Qt.Key_Enter)
                            popup.close();
                    }
                    KeyNavigation.tab: textUsername}
            }
        }
    }
}
