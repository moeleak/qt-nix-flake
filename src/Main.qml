import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow {
    id: win
    width: 720
    height: 500
    minimumWidth: 720
    minimumHeight: 500
    visible: true
    title: backend.windowTitle

    Material.theme: Material.Light
    Material.primary: Material.Blue
    Material.accent: Material.Pink

    RowLayout {
        anchors.fill: parent
        anchors.margins: 32
        spacing: 32

        GroupBox {
            id: statusBox
            title: qsTr("Status")
            Layout.fillWidth: true
            Layout.minimumWidth: 220
            Layout.preferredWidth: 280
            Layout.fillHeight: true
            implicitHeight: statusColumn.implicitHeight + topPadding + bottomPadding
            clip: true

            Column {
                id: statusColumn
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                Label {
                    text: backend.statusText
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    width: parent.width
                }
            }
        }

        GroupBox {
            id: controlBox
            title: qsTr("Controls")
            Layout.fillWidth: true
            Layout.minimumWidth: 260
            Layout.preferredWidth: 360
            Layout.fillHeight: true
            Layout.minimumHeight: 350
            implicitHeight: controlColumn.implicitHeight + topPadding + bottomPadding
            clip: true

            Column {
                id: controlColumn
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                Button {
                    text: backend.buttonLabel
                    onClicked: backend.handleButtonClicked()
                    width: parent.width
                }

                Slider {
                    from: 0
                    to: 100
                    value: backend.sliderValue
                    width: parent.width
                    onMoved: backend.sliderValue = value
                }

                ComboBox {
                    width: parent.width
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
                    width: parent.width
                    placeholderText: qsTr("Enter text")
                    text: backend.inputText
                    onTextEdited: backend.inputText = text
                }
            }
        }
    }
}
