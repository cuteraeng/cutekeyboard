import CuteKeyboard 1.0
import QtQuick 2.0

Key {
    btnKey: Qt.Key_Enter
    repeatable: true
    showPreview: false
    btnBackground: InputPanelIface.btnSpecialBackgroundColor
    btnText: "\n"
    btnDisplayedText: InputPanelIface.enterIcon === "" ? "Enter" : ""
    btnIcon: InputPanelIface.enterIcon === "" ? "" : InputPanelIface.enterIcon
    enabled: InputContext.inputItem ? InputContext.inputItem.EnterKeyAction.enabled : true
    opacity: enabled ? 1 : 0.5
}
