import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import mediaDuasNotas2

Window {
  width: 640
  height: 480
  visible: true
  title: qsTr("Calculadora Média de Notas")

  property int mediaNotas: 0

  Backend {
    id: meuBackend
    onEmitirMedia: function (media) {
      mediaNotas = media
    }
  }
  ListModel {
    id: meuListModel
  }

  Item {
    id: container
    width: 400
    height: 480
    anchors.horizontalCenter: parent.horizontalCenter
    StackView {
      id: meuStackView
      anchors.fill: parent
      initialItem: pgNotas
      clip: true
    }
  }

  Component {
    id: pgNotas
    Item {
      id: containerPgNotas
      width: container.width
      height: container.height
      Column {
        spacing: 10
        TextField {
          id: meuInputNome
          placeholderText: "Nome do Aluno"
          width: 380
          height: 40
        }
        TextField {
          id: meuInputNota1
          placeholderText: "Insira a Nota 1"
          width: 380
          height: 40
        }
        TextField {
          id: meuInputNota2
          placeholderText: "Insira a Nota 2"
          width: 380
          height: 40
        }
        Frame {
          id: frameMedia
          width: 380
          height: 80
          Text {
            id: textoMedia
            text: mediaNotas
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Verdana"
            font.pixelSize: 50
            font.bold: true
            color: "teal"
          }
        }
        Button {
          id: meuBotao
          width: 380
          height: 80
          text: "Calcular Nota"
          highlighted: true
          Material.background: Material.Teal
          enabled: (meuInputNota1.text
                    && meuInputNota2.text !== "") ? true : false
          onClicked: {
            //Envia notas para C++ calcular média
            meuBackend.calcularMedia(meuInputNota1.text, meuInputNota2.text)
            //Insere nome e média no ListModel
            meuListModel.append({
                                  "nome": meuInputNome.text,
                                  "nota": mediaNotas
                                })
            meuInputNota1.text = ""
            meuInputNota2.text = ""
            meuInputNome.text = ""
          }
        }
        Button {
          id: botaoMostrarContatos
          Material.background: Material.Teal
          text: "Mostrar Registros"
          width: 380
          height: 80
          onClicked: {
            meuStackView.push(pgMostrarContatos, StackView.Immediate)
          }
        }
      }
    }
  }

  Component {
    id: pgMostrarContatos
    Item {
      id: containerPgMostrarContatos
      width: container.width
      height: container.height
      Rectangle {
        id: containerListView
        width: container.width
        height: container.height / 2
        anchors.horizontalCenter: parent.horizontalCenter
        //border.color: "red"
        Frame {
          id: frameListView
          width: container.width - 20
          height: container.height / 2
          anchors.horizontalCenter: parent.horizontalCenter
          visible: false
        }
        ListView {
          id: meuListView
          anchors.fill: frameListView
          spacing: 5
          model: meuListModel
          clip: true
          delegate: Rectangle {
            width: frameListView.width
            height: 40
            color: "#f4f4f4"
            Column {
              Text {
                text: "<b>Nome</b>: " + nome
              }
              Text {
                text: "<b>Nota</b>: " + nota
              }
            }
          }
        }
      }
      Button {
        id: botao2
        width: container.width
        height: 80
        text: "Inserir Notas"
        anchors.top: containerListView.bottom
        anchors.topMargin: 20
        Material.background: Material.Teal
        onClicked: {
          meuStackView.pop(StackView.Immediate)
        }
      }
    }
  }
}
