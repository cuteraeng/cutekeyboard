import CuteKeyboard 1.0
import QtQuick 2.0

Key {
    btnKey: Qt.Key_Shift
    functionKey: true
    showPreview: false
    btnBackground: InputPanelIface.btnSpecialBackgroundColor
    btnIcon: InputEngine.uppercase ? InputPanelIface.shiftOnIcon : InputPanelIface.shiftOffIcon
    onClicked: InputEngine.uppercase = !InputEngine.uppercase
}
