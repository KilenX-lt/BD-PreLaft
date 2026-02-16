import sys
import pymysql
import matplotlib.pyplot as plt
import numpy as np

from PyQt5.QtWidgets import (
    QApplication, QWidget, QPushButton, QVBoxLayout,
    QLabel, QLineEdit, QMessageBox,QComboBox
)

def mysqlconnect():
    return pymysql.connect(
        host='localhost',
        user='root',
        port=3306,
        password='12345',
        db='prelaft_db',
        charset='utf8'
    )

def insertar(conexion, datos):
    try:
        with conexion.cursor() as cursor:
            sql = """
            INSERT INTO cliente
            (nombre, ruc, tipo_cliente, direccion, telefono)
            VALUES (%s, %s, %s, %s, %s)
            """
            cursor.execute(sql, datos)
        conexion.commit()
        return True
    except Exception as e:
        conexion.rollback()
        raise e

def desplegar_registros(conexion):
    with conexion.cursor() as cursor:
        cursor.execute('SELECT * FROM cliente')
        return cursor.fetchall()

def liquido(conexion):
    with conexion.cursor() as cursor:
        cursor.execute('SELECT puntaje FROM evaluacion')
        datos = cursor.fetchall()
        puntajes = [fila[0] for fila in datos]
        return sum(np.array(puntajes))

def graficar(conexion):
    with conexion.cursor() as cursor:
        sql = '''
        SELECT c.nombre, e.puntaje
        FROM evaluacion e
        JOIN cliente c ON e.id_cliente = c.id_cliente
        '''
        cursor.execute(sql)
        datos = cursor.fetchall()

    nombres = [fila[0] for fila in datos]
    puntajes = np.array([fila[1] for fila in datos])

    plt.figure(figsize=(10,5))
    plt.bar(nombres, puntajes)
    plt.title('Puntaje de Riesgo por Cliente')
    plt.xlabel('Cliente')
    plt.ylabel('Puntaje')
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()

class MenuPRELAFT(QWidget):

    def __init__(self):
        super().__init__()
        self.conexion = mysqlconnect()
        self.setWindowTitle("Sistema PRELAFT")
        self.setGeometry(400, 200, 350, 300)
        self.init_ui()

    def init_ui(self):
        layout = QVBoxLayout()

        titulo = QLabel("MENÚ PRINCIPAL PRELAFT")
        titulo.setStyleSheet("font-size:16px; font-weight:bold;")
        layout.addWidget(titulo)

        btn_insertar = QPushButton("Insertar Cliente")
        btn_mostrar = QPushButton("Mostrar Clientes")
        btn_total = QPushButton("Total Puntaje Riesgo")
        btn_grafica = QPushButton("Gráfica")
        btn_salir = QPushButton("Salir")

        btn_insertar.clicked.connect(self.ventana_insertar)
        btn_mostrar.clicked.connect(self.mostrar_clientes)
        btn_total.clicked.connect(self.mostrar_total)
        btn_grafica.clicked.connect(lambda: graficar(self.conexion))
        btn_salir.clicked.connect(self.close)

        layout.addWidget(btn_insertar)
        layout.addWidget(btn_mostrar)
        layout.addWidget(btn_total)
        layout.addWidget(btn_grafica)
        layout.addWidget(btn_salir)

        self.setLayout(layout)

    def ventana_insertar(self):
        self.v = QWidget()
        self.v.setWindowTitle("Insertar Cliente")
        layout = QVBoxLayout()

        self.nombre = QLineEdit()
        self.ruc = QLineEdit()
        self.tipo = QComboBox()
        self.tipo.addItems(["Natural", "Juridico"])
        self.direccion = QLineEdit()
        self.telefono = QLineEdit()

        layout.addWidget(QLabel("Nombre"))
        layout.addWidget(self.nombre)
        layout.addWidget(QLabel("RUC / Cédula"))
        layout.addWidget(self.ruc)
        layout.addWidget(QLabel("Tipo Cliente"))
        layout.addWidget(self.tipo)
        layout.addWidget(QLabel("Dirección"))
        layout.addWidget(self.direccion)
        layout.addWidget(QLabel("Teléfono"))
        layout.addWidget(self.telefono)

        btn_guardar = QPushButton("Guardar")
        btn_guardar.clicked.connect(self.guardar_cliente)

        layout.addWidget(btn_guardar)
        self.v.setLayout(layout)
        self.v.show()

    def guardar_cliente(self):
        datos = (
            self.nombre.text(),
            self.ruc.text(),
            self.tipo.currentText(),
            self.direccion.text(),
            self.telefono.text()
        )
        try:
            insertar(self.conexion, datos)
            QMessageBox.information(self, "Éxito", "Cliente insertado correctamente")
            self.v.close()
        except Exception as e:
            QMessageBox.critical(self, "Error", str(e))


    def mostrar_clientes(self):
        datos = desplegar_registros(self.conexion)
        texto = ""
        for fila in datos:
            texto += str(fila) + "\n"
        QMessageBox.information(self, "Clientes", texto)

    def mostrar_total(self):
        total = liquido(self.conexion)
        QMessageBox.information(self, "Total", f"Total puntaje riesgo: {total}")


if __name__ == "__main__":
    app = QApplication(sys.argv)
    menu = MenuPRELAFT()
    menu.show()
    sys.exit(app.exec_())
