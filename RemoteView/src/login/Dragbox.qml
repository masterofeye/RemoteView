import QtQuick 2.0
import QtQuick.Window 2.0

MouseArea{
    property variant clickPos: "1,1"
    z: -1
    anchors.fill: parent
    onPressed: {
        clickPos  = Qt.point(mouse.x,mouse.y)
    }
    onPositionChanged: {
        var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y);
        popup.x = popup.x+delta.x;
        popup.y =  popup.y+delta.y;

    }
}
