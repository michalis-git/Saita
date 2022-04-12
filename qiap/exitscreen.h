#ifndef EXITSCREEN_H
#define EXITSCREEN_H

#include <QWidget>

namespace Ui {
class ExitScreen;
}

class ExitScreen : public QWidget
{
    Q_OBJECT
    
public:
    explicit ExitScreen(QWidget *parent = 0);
    ~ExitScreen();
    
private:
    Ui::ExitScreen *ui;
};

#endif // EXITSCREEN_H
