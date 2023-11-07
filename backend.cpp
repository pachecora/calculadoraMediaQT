#include "backend.h"

Backend::Backend(QObject *parent)
    : QObject{parent}
{

}

void Backend::calcularMedia(int nota1, int nota2)
{
    int media;
    media = (nota1 + nota2) / 2;
    emit emitirMedia(media);
}
