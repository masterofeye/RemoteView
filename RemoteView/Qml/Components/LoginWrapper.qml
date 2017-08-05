import QtQuick 2.9
import QtQuick.Controls 2.2

Popup {
    id: loginPopup
    x: -300
    y: -100
    width: 250
    height: 250
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape
    background :Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    BorderImage {
        border.bottom:  8
        border.left:  8
        border.top: 8
        border.right: 8
        source: "../../Resourcen/BorderEffectAround.png"
        width: 250
        height: 250
        LoginForm{
            width: 240
            height: 230
        }
    }
}
