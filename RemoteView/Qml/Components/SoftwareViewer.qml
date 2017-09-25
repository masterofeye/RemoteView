import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: softwareViewerRoot
    property variant softwareProjects
    visible: isSoftwareVisibile()

    /*BACKGROUND SOFTWAREVIEVWER*/
    Rectangle
    {
        id: softwareContainer
        anchors.fill:parent
        color: "#19191C"
        radius: 5
        border.width: 2
        border.color: "white"
    }
    /*END BACKGROUND SOFTWAREVIEVWER*/
    /*SOFTWARE CONTAINER CONTENT*/
    RowLayout{
        anchors.fill: parent
        ColumnLayout
        {
            Layout.alignment: Qt.AlignHCenter
            Repeater {
                model: softwareViewerRoot.softwareProjects
                delegate:
                Row{
                    Layout.leftMargin:  20
                    /*FLASHTYPE BEZEICHNER*/
                    Text {
                        fontSizeMode: Text.Fit; minimumPixelSize: 8; font.pixelSize: 72
                        height:calcMaxHeigthOfText()
                        color: "white"
                        text: model.modelData.NaturalName
                        width:50
                        elide: Text.ElideRight
                    }
                    /*END FLASHTYPE BEZEICHNER*/
                    /*SOFTWARE VERSION*/
                    Text {
                        fontSizeMode: Text.Fit; minimumPixelSize: 8; font.pixelSize: 72
                        height:calcMaxHeigthOfText()
                        color: "white"
                        text: ControllerInstance.GetFlashEntry(mainsection.workstation,model.modelData)
                        elide: Text.ElideRight
                    }
                    /*END SOFTWARE VERSION*/
                }
            }
        }
    }
    /*END SOFTWARE CONTAINER CONTENT*/

    function isSoftwareVisibile(){
        return (statusbar.width - featureContainer.width - buttonContainer.width - 30) >  (softwareContainer.width)
    }

    function calcMaxHeigthOfText()
    {

        return (softwareViewerRoot.height -softwareViewerRoot.height /softwareViewerRoot.softwareProjects.length)/softwareViewerRoot.softwareProjects.length
    }


}
