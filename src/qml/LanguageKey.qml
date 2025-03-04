import CuteKeyboard 1.0
import QtQuick 2.0

Key {
    weight: 108.5
    btnKey: Qt.Key_Context2
    btnIcon: InputPanelIface.languageIcon
    functionKey: true
    showPreview: false
    btnBackground: InputPanelIface.btnSpecialBackgroundColor
    onClicked: {
        var indx = InputPanelIface.availableLanguageLayouts.indexOf(InputPanelIface.languageLayout);
        if (indx != -1) {
            var nextIndx = (indx + 1) % InputPanelIface.availableLanguageLayouts.length;
            var nextLangLayout = InputPanelIface.availableLanguageLayouts[nextIndx];
            if (InputEngine.inputLayoutValid(nextLangLayout))
                InputPanelIface.languageLayout = nextLangLayout;
            else
                InputPanelIface.languageLayout = "En";
        } else {
            InputPanelIface.languageLayout = InputPanelIface.availableLanguageLayouts[0];
        }
    }
}
