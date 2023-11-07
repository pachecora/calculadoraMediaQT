#ifndef BACKEND_H
#define BACKEND_H
#include <QtQml>
#include <QObject>

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Backend(QObject *parent = nullptr);
    Q_INVOKABLE void calcularMedia(int nota1, int nota2);
signals:
    void emitirMedia(int media);
};

#endif // BACKEND_H
