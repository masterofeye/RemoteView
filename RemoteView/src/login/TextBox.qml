import QtQuick 2.0

FocusScope {
    //FocusScope needs to bind to visual properties of the Rectangle
    id: scope
    property alias color: root.color
    //x: root.x; y: root.y
    //width: root.width; height: root.height
    property alias maxLength: textinput.maximumLength
    property bool isPassword: false
    property alias text: textinput.text
    property bool isOnlyDigit: false
    property bool isOnlyDigitAndAlphabet: false
    property bool isDate: false
    signal enter
    Rectangle{
        id:root
        border{color:"black"}
        width: scope.width
        height: scope.height
        radius: 3
        TextInput{
            id: textinput
            font{
                bold: true
                pixelSize: 20
            }
            width: parent.width-10
            focus: true
            anchors.centerIn: parent
            autoScroll: true
            echoMode: isPassword?TextInput.Password:TextInput.Normal
            maximumLength: 10
            validator: RegExpValidator{
                regExp: isOnlyDigit?/[0-9]*/:isOnlyDigitAndAlphabet?/([0-9a-zA-Z]*)/:isDate?/[1-9][0-9][0-9][0-9]\-[0-3][0-9]\-[0-1][0-9][ ][0-2][0-9]\:[0-5][0-9]/:/.*/
            }
            onAccepted: {
                scope.enter();
            }
        }
    }
}
