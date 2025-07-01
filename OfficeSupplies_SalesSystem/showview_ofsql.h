#ifndef SHOWVIEW_OFSQL_H
#define SHOWVIEW_OFSQL_H

#include <QDialog>
#include <QSqlTableModel>
#include "mysqltool.h"

namespace Ui {
class showView_ofSql;
}

class showView_ofSql : public QDialog
{
    Q_OBJECT

public:
    explicit showView_ofSql(QWidget *parent = nullptr);
    ~showView_ofSql();

    void view_saveFun_1();
    void view_saveFun_2();
    void viewTo_order_datiel();
    void viewTo_query(const QString sql,QString info);
    void viewTo_inventory_overview();
    void viewTo_sales_summary();

private:
    Ui::showView_ofSql *ui;
};

#endif // SHOWVIEW_OFSQL_H
