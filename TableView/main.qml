import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("TableView")

    Rectangle{
        anchors.fill: parent
        anchors.margins: 20
        color: "gray"

        EasyTableWidget{
            anchors.fill: parent
        }
    }
}
