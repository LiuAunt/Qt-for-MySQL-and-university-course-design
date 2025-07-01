#include "showview_ofsql.h"
#include "ui_showview_ofsql.h"

showView_ofSql::showView_ofSql(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::showView_ofSql)
{
    ui->setupUi(this);
}

showView_ofSql::~showView_ofSql()
{
    delete ui;
}
void showView_ofSql::view_saveFun_1()
{
    QSqlQueryModel *model = new QSqlQueryModel(this);
    model->setQuery("select "
                    "p.product_id as '商品ID', "
                    "p.product_name as '商品名称', "
                    "p.category as '类别', "
                    "i.current_quantity as '库存量', "
                    "p.unit_price as '单价', "
                    "calculate_inventory_value(p.product_id) as '库存价值' "
                    "from product p "
                    "join inventory i on p.product_id = i.product_id "
                    "order by calculate_inventory_value(p.product_id) desc",MySqlTool::getDb());

    if (model->lastError().isValid()) {
        qDebug() << "查询失败:" << model->lastError().text();
        return;
    }

    ui->tableView->setModel(model);
    ui->tableView->resizeColumnsToContents();

    QString info = QString("存储函数（获取包含库存价值总价的详细商品列表）");
    ui->lab_info->setText(info);
}

void showView_ofSql::view_saveFun_2()
{
    QSqlQueryModel *model = new QSqlQueryModel(this);

    model->setQuery("select "
                    "s.supplier_id as '供应商id', "
                    "s.supplier_name as '供应商名称', "
                    "count(p.product_id) as '活跃商品数', "
                    "group_concat(p.product_name separator '、') as '商品列表' "
                    "from supplier s "
                    "left join product p on s.supplier_id = p.supplier_id and p.is_discontinued = false "
                    "group by s.supplier_id, s.supplier_name "
                    "order by count(p.product_id) desc",MySqlTool::getDb());

    if (model->lastError().isValid()) {
        qDebug() << "查询错误:" << model->lastError().text();
        return;
    }
    ui->tableView->setModel(model);
    ui->tableView->resizeColumnsToContents();
    QString info = QString("存储函数（获取商品活跃的供应商及商品与数量）");
    ui->lab_info->setText(info);
}

void showView_ofSql::viewTo_order_datiel()
{
    QSqlTableModel *order_model = new QSqlTableModel(this,MySqlTool::getDb());
    order_model->setTable("customer_order_details");
    order_model->select();
    ui->tableView->setModel(order_model);
    ui->tableView->resizeColumnsToContents();
    QString info = QString("当前订单条数：%1     此界面是订单视图(customer_order_details)")
                       .arg(order_model->rowCount());
    ui->lab_info->setText(info);
}

void showView_ofSql::viewTo_query(const QString sql, QString info)
{
    QSqlQueryModel *model = new QSqlQueryModel(this);
    model->setQuery(sql,MySqlTool::getDb());
    ui->tableView->setModel(model);
    ui->tableView->resizeColumnsToContents();

    ui->lab_info->setText(info);
}

void showView_ofSql::viewTo_inventory_overview()
{
    QSqlTableModel *order_model = new QSqlTableModel(this,MySqlTool::getDb());
    order_model->setTable("inventory_overview");
    order_model->select();
    ui->tableView->setModel(order_model);
    ui->tableView->resizeColumnsToContents();
    QString info = QString("条数：%1     此界面是库存概览视图(inventory_overview)")
                       .arg(order_model->rowCount());
    ui->lab_info->setText(info);
}

void showView_ofSql::viewTo_sales_summary()
{
    QSqlTableModel *order_model = new QSqlTableModel(this,MySqlTool::getDb());
    order_model->setTable("sales_summary");
    order_model->select();
    ui->tableView->setModel(order_model);
    ui->tableView->resizeColumnsToContents();
    QString info = QString("条数：%1     此界面是销售统计视图(sales_summary)")
                       .arg(order_model->rowCount());
    ui->lab_info->setText(info);
}
