import QtQuick 2.1
import QtGraphicalEffects 1.0

Item {
    id: movie_view
    anchors.fill: parent

    ListView {
        id: slidelist

        anchors.fill: parent

        orientation: ListView.Horizontal
        clip: true
        snapMode: ListView.SnapOneItem
        boundsBehavior: Flickable.DragAndOvershootBounds
        highlightRangeMode: ListView.StrictlyEnforceRange
        model: CoverModel {}
        delegate: listItemDelegate

        onCurrentIndexChanged: textTitle.text = model.get(currentIndex).title
    }

    Component {
        id: listItemDelegate
        Item {
            Image {
                source: url
                width: slidelist.width
                height: slidelist.height
                fillMode: Image.PreserveAspectCrop
                smooth: true
            }

            //top bar blur
            Item {
                clip: true
                anchors.fill: topbar

                FastBlur {
                    anchors { top: parent.top; left: parent.left; right: parent.right }
                    height: movie_view.height
                    source: slidelist
                    radius: 64
                    //transparentBorder: true
                }
            }

            BorderImage {
                anchors.fill: topbar
                smooth: true
                anchors { leftMargin: -8; topMargin: -13; rightMargin: -8; bottomMargin: -8 }
                border.left: 8
                border.right: 8
                border.top: 13
                border.bottom: 13
                source: "shadow.png"
                opacity: 0.5
            }


            Rectangle {
                id: topbar
                height: 64
                color: "#000000"
                anchors.right: parent.right
                anchors.left: parent.left
                opacity: 0.25

            }

            FocusScope {
                id: focusScope
                width: 250; height: 48
                opacity: 0.50
                anchors { right: topbar.right; rightMargin: 8; verticalCenter: topbar.verticalCenter }

                BorderImage {
                    source: "search_bg.png"
                    width: parent.width; height: parent.height
                    border { left: 10; top: 10; right: 10; bottom: 10 }
                }

                BorderImage {
                    source: "search_hilight.png"
                    width: parent.width; height: parent.height
                    border { left: 16; top: 16; right: 16; bottom: 16 }
                    visible: parent.activeFocus ? true : false
                }

                Text {
                    id: typeSomething
                    anchors.fill: parent; anchors.leftMargin: 8
                    verticalAlignment: Text.AlignVCenter
                    text: "Search..."
                    color: "gray"
                    font.italic: true
                    opacity: textInput.text === ""
                    Behavior on opacity { PropertyAnimation {} }

                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { focusScope.focus = true; }
                }

                TextInput {
                    id: textInput
                    anchors { left: parent.left; leftMargin: 8; right: search.left; rightMargin: 8; verticalCenter: parent.verticalCenter }
                    focus: true
                    selectByMouse: true
                    color: "white"
                }

                Image {
                    id: search
                    anchors { right: parent.right; rightMargin: 8; verticalCenter: parent.verticalCenter }
                    source: "icon_search.png"
                    opacity: 0.8
                    height: 16
                    width: 16
                }
            }


            //bottom bar blur
            Item {
                clip: true
                anchors.fill: bottomBar


                FastBlur {

                    anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
                    height: movie_view.height
                    source: slidelist
                    radius: 64
                    //transparentBorder: true
                }

                Column {

                    Text {
                        id: textTitle
                        color: "white"
                        font.bold: true
                        font.pointSize: 15
                    }
                    Text {
                        color: "#ffea00"
                        text: "Action | Aventure | Sci-fi"
                        font.pointSize: 10
                    }
                    Row {
                        Image {
                            id: star
                            source: "star.png"
                            height: 16
                            width: 16
                        }

                        Text {
                            id: score
                            color: "white"
                            text: " | 798"
                            font.bold: true
                            font.pointSize: 15
                        }

                    }
                }


            }
            Rectangle {
                id: bottomBar
                height: 128
                color: "#000000"
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                opacity: 0.25
            }

            BorderImage {
                anchors.fill: bottomBar
                smooth: true
                anchors { leftMargin: -8; topMargin: -8; rightMargin: -8; bottomMargin: -13 }
                border.left: 8
                border.right: 8
                border.top: 13
                border.bottom: 13
                source: "shadow.png"
                opacity: 0.5
            }
        }
    }
}
