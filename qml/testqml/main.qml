import QtQuick 2.1
import QtGraphicalEffects 1.0


Rectangle {
    id: root

    width: 480
    height: 800
    color: "black"

    property bool menu_shown: false

    /* this rectangle contains the "menu" */
    Rectangle {
        id: menu_view_
        anchors.fill: parent
        color: "#303030";
        opacity: root.menu_shown ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 300 } }

        /* this is my sample menu content (TODO: replace with your own)  */
        ListView {
            anchors { fill: parent; margins: 22 }
            model: 8
            delegate: Item { height: 32; width: parent.width;
                Text { anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                    color: "white"; font.pixelSize: 12; text: "This is menu #" + index  }
                Rectangle { height: 1; width: parent.width * 0.8; color: "gray"; anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom } }
            }
        }
    }

    /* this rectangle contains the "normal" view in your app */
    Rectangle {
        id: normal_view_
        anchors.fill: parent
        color: "white"

        /* this is what moves the normal view aside */
        transform: Translate {
            id: game_translate_
            x: 0
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
        }

        /* this is the menu shadow */
        BorderImage {
            id: menu_shadow_
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: -10
            z: -1 /* this will place it below normal_view_ */
            visible: root.menu_shown
            source: "shadow.png"
            border { left: 12; top: 12; right: 12; bottom: 12 }
        }

        MovieView{

        }

        Image {
            id: menu_button
            width: 32;
            height: 32;
            scale: ma_.pressed ? 1.2 : 1
            source: "menu.png"
            MouseArea { id: ma_; anchors.fill: parent; onClicked: root.onMenu(); }

        }


        /* put this last to "steal" touch on the normal window when menu is shown */
        MouseArea {
            anchors.fill: parent
            enabled: root.menu_shown
            onClicked: root.onMenu();
        }
    }

    /* this functions toggles the menu and starts the animation */
    function onMenu()
    {
        game_translate_.x = root.menu_shown ? 0 : root.width * 0.9
        root.menu_shown = !root.menu_shown;
    }
}

