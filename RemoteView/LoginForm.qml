import QtQuick 2.0
https://jryannel.wordpress.com/2010/02/22/designing-a-login-view/
https://doc.qt.io/archives/qt-5.5/enginio-qml-users-example.html
http://portal.bluejack.binus.ac.id/tutorials/qtapplicationusingqmlandcwithmysqldatabase

//UserRole
Item {
    Rectangle {
      width: 640
      height: 480
      Background { anchors.fill: parent }
      Column {
        anchors.centerIn: parent
        spacing: 16
        Column {
          spacing: 4
          MediumText { text: "Username" }
          LineInput { focus: true }
        }
        Column {
          spacing: 4
          MediumText { text: "Password" }
          LineInput { input.echoMode: TextInput.Password }
        }
        Row {
          spacing: 16
          anchors.horizontalCenter: parent.horizontalCenter
          Button { text: "Login"; onClicked: console.log("login") }
          Button { text: "Guest"; onClicked: console.log("guest") }
        }
      }
    }
}
