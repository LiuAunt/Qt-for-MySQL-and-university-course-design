#ifndef STARTWINDOW_H
#define STARTWINDOW_H

#include <QDialog>
#include <QCryptographicHash>
#include "mysqltool.h"
#include "ossswindow.h"

namespace Ui {
class StartWindow;
}

class StartWindow : public QDialog
{
    Q_OBJECT

public:
    explicit StartWindow(QWidget *parent = nullptr);
    ~StartWindow();

private:
    MySqlTool *sql;
private slots:

    void on_btn_login_clicked();

    void on_btn_exitsys_clicked();

    void on_btn_reg_clicked();

    void on_btn_back_clicked();

private:
    Ui::StartWindow *ui;
};

#endif // STARTWINDOW_H
