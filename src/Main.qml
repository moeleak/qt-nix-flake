import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow {
    id: win
    property int layoutMargin: 32

    width: 720
    height: 500

    minimumWidth: rootLayout.implicitWidth + layoutMargin * 2
    minimumHeight: rootLayout.implicitHeight + layoutMargin * 2 + (appMenuBar ? appMenuBar.implicitHeight : 0)

    visible: true
    title: backend.windowTitle

    Material.theme: Material.Light
    Material.primary: Material.Blue
    Material.accent: Material.Pink

    Action { id: openDialogAction; text: qsTr("Show Status Dialog"); onTriggered: statusDialog.open() }
    Action { id: openDrawerAction; text: qsTr("Toggle Drawer"); onTriggered: appDrawer.open() }

    menuBar: MenuBar {
        id: appMenuBar
        Menu {
            title: qsTr("View")
            MenuItem { action: openDialogAction }
            MenuItem { action: openDrawerAction }
        }
        Menu {
            title: qsTr("Edit")
            MenuItem { text: qsTr("Clear Text"); onTriggered: backend.inputText = "" }
        }
    }

    RowLayout {
        id: rootLayout
        anchors.fill: parent
        anchors.margins: layoutMargin
        spacing: 32

        // ---------------- Status GroupBox ----------------
        GroupBox {
            id: statusBox
            title: qsTr("Status")

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 200
            Layout.preferredWidth: 280
            Layout.minimumHeight: implicitHeight
            Layout.alignment: Qt.AlignTop

            ColumnLayout {
                id: statusColumn
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                spacing: 12

                Label {
                    text: backend.statusText
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                    Layout.preferredWidth: 200
                }
            }
        }

        // ---------------- Controls GroupBox ----------------
        GroupBox {
            id: controlBox
            title: qsTr("Controls")

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 250
            Layout.preferredWidth: 360
            Layout.minimumHeight: implicitHeight
            Layout.alignment: Qt.AlignTop

            ColumnLayout {
                id: controlColumn
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                spacing: 12

                Button {
                    text: backend.buttonLabel
                    onClicked: backend.handleButtonClicked()
                    Layout.fillWidth: true
                }

                Slider {
                    from: 0
                    to: 100
                    value: backend.sliderValue
                    Layout.fillWidth: true
                    onMoved: backend.sliderValue = value
                }

                ComboBox {
                    Layout.fillWidth: true
                    model: ["Option 1", "Option 2", "Option 3"]
                    currentIndex: backend.comboIndex
                    onActivated: backend.comboIndex = currentIndex
                }

                CheckBox {
                    text: "Enable something"
                    checked: backend.featureEnabled
                    onToggled: backend.featureEnabled = checked
                }

                TextField {
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter text")
                    text: backend.inputText
                    onTextEdited: backend.inputText = text
                }

                Button {
                    Layout.fillWidth: true
                    text: qsTr("Show Dialog")
                    onClicked: openDialogAction.trigger()
                }

                Button {
                    Layout.fillWidth: true
                    text: qsTr("Open Drawer")
                    onClicked: openDrawerAction.trigger()
                }
            }
        }
    }

    Dialog {
        id: statusDialog
        title: qsTr("Status Details")
        modal: true
        standardButtons: Dialog.Ok
        x: (win.width - width) / 2
        y: (win.height - height) / 2
        contentItem: Column {
            spacing: 12
            Label {
                text: backend.statusText
                wrapMode: Text.WordWrap
                width: 300
            }
            TextArea {
                width: 300
                readOnly: true
                text: qsTr("Current input: %1").arg(backend.inputText)
            }
        }
    }

    Drawer {
        id: appDrawer
        width: Math.min(280, win.width * 0.6)
        height: win.height
        modal: true
        interactive: true
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16
            Label {
                text: qsTr("Quick Actions")
                font.pixelSize: 20
            }
            Button {
                text: qsTr("Toggle Feature")
                onClicked: backend.featureEnabled = !backend.featureEnabled
            }
            Button {
                text: qsTr("Close Drawer")
                onClicked: appDrawer.close()
            }
        }
    }
}
