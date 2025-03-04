import CuteKeyboard 1.0
import QtQml 2.0
import QtQuick 2.0

Item {
    id: root

    property bool active: Qt.inputMethod.visible
    property color backgroundColor: "#000000"
    property color btnBackgroundColor: "#808080"
    property color btnSpecialBackgroundColor: Qt.darker("#808080")
    property color btnTextColor: "#ffffff"
    property string btnTextFontFamily
    property string languageLayout: "En"
    property string backspaceIcon: "qrc:/CuteKeyboard/icons/white/backspace.png"
    property string enterIcon: ""
    property string shiftOnIcon: "qrc:/CuteKeyboard/icons/white/caps-lock-on.png"
    property string shiftOffIcon: "qrc:/CuteKeyboard/icons/white/caps-lock-off.png"
    property string hideKeyboardIcon: "qrc:/CuteKeyboard/icons/white/hide-arrow.png"
    property string languageIcon: "qrc:/CuteKeyboard/icons/white/language.png"
    property var availableLanguageLayouts: ["En"]

    /*! \internal */
    readonly property bool __isRootItem: inputPanel.parent !== null && inputPanel.parent.parent === null

    function showKeyPopup(keyButton) {
        keyPopup.popup(keyButton, root);
    }

    function hideKeyPopup() {
        keyPopup.visible = false;
    }

    function showAlternativesKeyPopup(keyButton) {
        alternativesKeyPopup.open(keyButton, root);
    }

    function loadLettersLayout() {
        var description = InputEngine.descriptionOfLayout(languageLayout);
        var spaceIdentifier = InputEngine.spaceIdentifierOfLayout(languageLayout);
        var source = InputEngine.fileOfLayout(languageLayout);
        if (description !== "" && source !== "") {
            layoutLoader.langDescription = description;
            layoutLoader.spaceIdentifier = spaceIdentifier;
            layoutLoader.setSource(source + ".qml", {
                "inputPanel": root
            });
        } else {
            layoutLoader.langDescription = "English";
            layoutLoader.spaceIdentifier = "space";
            layoutLoader.setSource("EnLayout.qml", {
                "inputPanel": root
            });
        }
    }

    objectName: "inputPanel"
    width: parent.width
    height: width / 4
    onYChanged: InputEngine.setKeyboardRectangle(Qt.rect(x, y, width, height))
    onActiveChanged: {
        if (alternativesKeyPopup.visible && !active)
            alternativesKeyPopup.visible = false;
    }
    onLanguageLayoutChanged: loadLettersLayout()
    Component.onCompleted: {
        InputContext.registerInputPanel(root);

        if (availableLanguageLayouts.length == 0)
            availableLanguageLayouts = ["En"];

        InputPanelIface.backgroundColor = backgroundColor;
        InputPanelIface.btnBackgroundColor = btnBackgroundColor;
        InputPanelIface.btnSpecialBackgroundColor = btnSpecialBackgroundColor;
        InputPanelIface.btnTextColor = btnTextColor;
        InputPanelIface.btnTextFontFamily = btnTextFontFamily;
        InputPanelIface.backspaceIcon = backspaceIcon;
        InputPanelIface.enterIcon = enterIcon;
        InputPanelIface.shiftOnIcon = shiftOnIcon;
        InputPanelIface.shiftOffIcon = shiftOffIcon;
        InputPanelIface.hideKeyboardIcon = hideKeyboardIcon;
        InputPanelIface.languageIcon = languageIcon;
        InputPanelIface.availableLanguageLayouts = availableLanguageLayouts;
        InputPanelIface.languageLayout = languageLayout;
        loadLettersLayout();
    }

    KeyPopup {
        id: keyPopup

        popupColor: btnBackgroundColor
        popupTextColor: btnTextColor
        popupTextFont: btnTextFontFamily
        visible: false
        z: 100
    }

    AlternativeKeysPopup {
        id: alternativesKeyPopup

        visible: false
        z: 100
    }

    MouseArea {
        id: alternativesKeyPopupMouseArea

        visible: alternativesKeyPopup.visible
        enabled: visible
        anchors.fill: parent
        propagateComposedEvents: false
        z: 99
    }

    Rectangle {
        id: keyboardRect

        color: InputPanelIface.backgroundColor
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
        }

        Loader {
            id: layoutLoader

            // lang description only needed for layouts that share a file
            property string langDescription
            // space identifier for the correct translation of the word "space"
            property string spaceIdentifier

            anchors {
                fill: parent
                margins: 5
            }
        }

        Connections {
            function refreshLayouts() {
                if (InputEngine.symbolMode)
                    layoutLoader.setSource("SymbolLayout.qml", {
                        "inputPanel": root
                    });
                else if (InputEngine.inputMode === InputEngine.DigitsOnly)
                    layoutLoader.setSource("DigitsLayout.qml", {
                        "inputPanel": root
                    });
                else
                    loadLettersLayout();
            }

            function onInputModeChanged() {
                refreshLayouts();
            }

            function onIsSymbolModeChanged() {
                refreshLayouts();
            }

            target: InputEngine
        }

        Connections {
            function onLanguageLayoutChanged() {
                languageLayout = InputPanelIface.languageLayout;
                loadLettersLayout();
            }

            target: InputPanel
        }
    }
}
