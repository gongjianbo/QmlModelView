import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: root_window
    visible: true
    width: 640
    height: 480
    title: qsTr("【QQ交流群：647637553】"+root_loader.source)

    Loader{
        id: root_loader
        anchors.fill: parent
        anchors.margins: 10
        source: "qrc:/QmlListModel.qml"
        focus: true
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("page")
            Action {
                text: "QmlListModel"
                onTriggered: root_loader.setSource("qrc:/QmlListModel.qml")
            }
        }
    }
}
