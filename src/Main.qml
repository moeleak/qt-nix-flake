import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: "Hello Nix Qt"
    color: "#333333"

    Text {
        anchors.centerIn: parent
        text: "It Works!"
        color: "white"
        font.pixelSize: 24
    }
}
