

//办公用品销售系统

#include <QApplication>
#include "startwindow.h"
#include "mysqltool.h"
#include "ossswindow.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    a.setWindowIcon(QIcon(":/image1/images/购物 礼盒.png"));
    // qDebug()<<QSqlDatabase::drivers();

    // QString linkName = "DataBase_assignment";
    QString dbName = "office_supplies_db";
    MySqlTool *sql = MySqlTool::Instance(dbName);
    sql->CreateDatabase();

    // OsssWindow *sw = new OsssWindow;
    StartWindow *sw = new StartWindow;
    sw->show();

    return a.exec();
}
