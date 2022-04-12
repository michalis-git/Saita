#include "exitscreen.h"
#include "ui_exitscreen.h"

#include <QApplication>

ExitScreen::ExitScreen(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::ExitScreen)
{
    ui->setupUi(this);

    connect(ui->pushButton,SIGNAL(clicked()),qApp,SLOT(quit()));
}

ExitScreen::~ExitScreen()
{
    delete ui;
}
