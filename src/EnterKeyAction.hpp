#pragma once

#include <QObject>
#include <QQmlEngine>

#include "EnterKeyActionAttachedType.hpp"

class EnterKeyAction : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_ATTACHED(EnterKeyActionAttachedType)

   public:
    static EnterKeyActionAttachedType *qmlAttachedProperties(QObject *object);
};
