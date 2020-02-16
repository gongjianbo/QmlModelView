import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: control

    //几个简单的ListView应用展示
    RowLayout{
        anchors.fill: parent
        spacing: 10

        ListView{
            id: listview_1
            Layout.fillHeight: true
            Layout.fillWidth: true

            orientation: ListView.Vertical
            clip: true
            spacing: 2
            model: 20 //用数字类似于Repeater
            delegate: Rectangle{
                width: ListView.view.width
                height: 30
                radius: 15
                //附加属性见文档，注意只对delegate第一层的Item
                color:  ListView.isCurrentItem?"darkRed":"red"
                Text {
                    anchors.centerIn: parent
                    text: index+1
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: listview_1.currentIndex=index
                }
            }
            //highlight感觉没啥用，只能做个背景
            highlight: Rectangle{
                width: ListView.view.width
                height: 30
                color: "darkRed"
            }

            //有焦点才能按键切换当前item
            //经测试还得给外面的Loader加focus
            focus: true
            keyNavigationEnabled: true
            keyNavigationWraps: true //打到最后一个返回到第一个

            //默认不显示滚动条，我们用一个最简单的滚动条
            ScrollBar.vertical: ScrollBar{}
        }

        ListView{
            id: listview_2
            Layout.fillHeight: true
            Layout.fillWidth: true

            clip: true
            spacing: 2
            model: ["a","b","c","d","e","f","g","h","i","j","k","l","m","n"] //可以用Json数组
            delegate: Rectangle{
                width: ListView.view.width
                height: 30
                color: "green"
                Text {
                    anchors.centerIn: parent
                    text: modelData
                }
            }
            //不要拉扯的动画
            boundsBehavior: Flickable.StopAtBounds
            //header固定在顶部
            headerPositioning: ListView.OverlayHeader
            header: Rectangle{
                width: ListView.view.width
                height: 30
                color: "darkGreen"
                z:2 //默认会被内容遮挡住
            }

            //footer固定在底部
            footerPositioning: ListView.OverlayFooter
            footer: Rectangle{
                width: ListView.view.width
                height: 30
                color: "darkGreen"
                z:2
            }
            ScrollBar.vertical: ScrollBar{}
        }

        ListView{
            id: listview_3
            Layout.fillHeight: true
            Layout.fillWidth: true

            clip: true
            spacing: 2
            model: [
                {"name":"tom","age":10},
                {"name":"sen","age":15},
                {"name":"kin","age":13},
                {"name":"li","age":18}
            ]
            delegate: Rectangle{
                width: ListView.view.width
                height: 30
                color: "blue"
                Text {
                    anchors.centerIn: parent
                    text: modelData.name+":"+modelData.age
                }
            }

            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar{}
        }

        ListView{
            id: listview_4
            Layout.fillHeight: true
            Layout.fillWidth: true

            //listview默认只有竖向滚动条，要显示横向的需要加上下面两句
            flickableDirection: Flickable.AutoFlickIfNeeded
            contentWidth: width*2

            clip: true
            spacing: 2
            model: ListModel{
                ListElement{ name:"一"; age:"1" }
                ListElement{ name:"切"; age:"2" }
                ListElement{ name:"都"; age:"3" }
                ListElement{ name:"是"; age:"4" }
                ListElement{ name:"稍"; age:"5" }
                ListElement{ name:"纵"; age:"6" }
                ListElement{ name:"即"; age:"7" }
                ListElement{ name:"逝"; age:"8" }
                ListElement{ name:"的"; age:"9" }
                ListElement{ name:"追"; age:"10" }
                ListElement{ name:"寻"; age:"11" }
            }

            delegate: Rectangle{
                width: ListView.view.width
                height: 30
                color: "orange"
                Text {
                    anchors.centerIn: parent
                    //注意，和直接使用json不一样，不需要modelData
                    text: name+":"+age
                }
            }

            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar{}
            ScrollBar.horizontal: ScrollBar{}
        }
    }
}
