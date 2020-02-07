import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QQ交流群：647637553")

    Rectangle{
        anchors.fill: parent
        anchors.margins: 20
        color: "gray"

        TableWidget{
            anchors.fill: parent
        }
    }
}
