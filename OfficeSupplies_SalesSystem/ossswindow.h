#ifndef OSSSWINDOW_H
#define OSSSWINDOW_H

#include <QWidget>
#include "mysqltool.h"
#include <QMap>
#include <QList>
#include <QMessageBox>
#include <QSqlTableModel>
#include <QDebug>
#include <QGraphicsOpacityEffect>
#include <QMouseEvent>

namespace Ui {
class OsssWindow;
}

class id_and_name{
public:
    id_and_name(QString id,QString name){
        this->name = name;
        this->id = id;
    }
    id_and_name(){
    }
    QString name;
    QString id;
    QString product_price;
};

class OsssWindow : public QWidget
{
    Q_OBJECT

public:
    OsssWindow(QWidget *parent = nullptr,bool isRoot = false);
    ~OsssWindow();

    void setIsRoot(bool is){
        isRoot = is;
    }
    bool getIsRoot(){
        return isRoot;
    }

    void updateUiDataOfDB();
private slots:
    void on_btn_stoping_clicked();

    void on_btn_update_clicked();

    void cb_product_currentIndexChanged(int index);

    void on_btn_state_clicked();

    void on_tableView_clicked(const QModelIndex &index);

    void on_btn_del_order_clicked();

    void on_btn_show_order_detial_clicked();

    void on_btn_savefun_1_clicked();

    void on_btn_savefun_2_clicked();

    void on_btn_query_3_clicked();
    void on_btn_query_4_clicked();
    void on_btn_query_5_clicked();
    void on_btn_query_6_clicked();
    void on_btn_query_7_clicked();
    void on_btn_query_8_clicked();
    void on_btn_query_9_clicked();
    void on_btn_query_10_clicked();

    void on_btn_show_inventory_overview_clicked();

    void on_btn_show_sales_summary_clicked();

    void on_btn_exit_clicked();

private:
    // QMap<int, QString> customersMap;
    // QMap<int, QString> employeesMap;
    // QMap<int, QString> productsMap;
    QList<id_and_name>customersList;
    QList<id_and_name>employeesList;
    QList<id_and_name>productsList;

    int current_update_orderid;

    MySqlTool *sql;
    bool isRoot;
    QSqlTableModel *order_model;

    bool isActionDrag;
    QPoint m_dragStartPosition; // 记录鼠标按下时的位置
    void mousePressEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;
    void mouseReleaseEvent(QMouseEvent *event) override;


    Ui::OsssWindow *ui;
};

#endif // OSSSWINDOW_H
