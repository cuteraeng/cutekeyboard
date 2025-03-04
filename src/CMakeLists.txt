set(HEADERS
    "EnterKeyAction.hpp" "EnterKeyActionAttachedType.hpp" "InputPanelIface.hpp"
    "DeclarativeInputEngine.h" "VirtualKeyboardInputContext.h"
)

set(SOURCES
    "EnterKeyAction.cpp" "EnterKeyActionAttachedType.cpp" "InputPanelIface.cpp"
    "DeclarativeInputEngine.cpp" "VirtualKeyboardInputContext.cpp")

set(QML_FILES
    "qml/AlternativeKeysPopup.qml"
    "qml/BackspaceKey.qml"
    "qml/CsLayout.qml"
    "qml/DeLayout.qml"
    "qml/DigitsLayout.qml"
    "qml/ElLayout.qml"
    "qml/EnLayout.qml"
    "qml/EnterKey.qml"
    "qml/EsLayout.qml"
    "qml/FrLayout.qml"
    "qml/HideKey.qml"
    "qml/InputPanel.qml"
    "qml/ItLayout.qml"
    "qml/KeyModel.qml"
    "qml/KeyPopup.qml"
    "qml/Key.qml"
    "qml/NlLayout.qml"
    "qml/PlLayout.qml"
    "qml/PtLayout.qml"
    "qml/QwertyLayout.qml"
    "qml/ShiftKey.qml"
    "qml/SpaceKey.qml"
    "qml/SymbolKey.qml"
    "qml/SymbolLayout.qml"
    "qml/LanguageKey.qml")

qt_add_qml_module(
  ${PROJECT_NAME}
  URI
  "CuteKeyboard"
  VERSION
  1.0
  STATIC
  PLUGIN_TARGET
  ${PROJECT_NAME}
  SOURCES
  ${HEADERS}
  ${SOURCES}
  QML_FILES
  ${QML_FILES}
)

qt_add_resources(${PROJECT_NAME}
    "icons"
    PREFIX "/CuteKeyboard"
    FILES
        "icons/backspace.png"
        "icons/caps-lock-off.png"
        "icons/caps-lock-on.png"
        "icons/hide-arrow.png"
        "icons/language.png"
)

target_link_libraries(
  ${PROJECT_NAME} PRIVATE Qt::Core Qt::Gui Qt::GuiPrivate Qt::Qml Qt::Quick
                          Qt::QuickPrivate)

qt_add_plugin(
    VirtualKeyboardInputContextPlugin
    STATIC
    "VirtualKeyboardInputContextPlugin.h" "VirtualKeyboardInputContextPlugin.cpp"
)

target_link_libraries(
  VirtualKeyboardInputContextPlugin PRIVATE Qt::Core Qt::Gui Qt::GuiPrivate Qt::Quick)
