#include "ossswindow.h"
#include "ui_ossswindow.h"

OsssWindow::OsssWindow(QWidget *parent,bool isRoot)
    : QWidget(parent)
    , ui(new Ui::OsssWindow)
{
    ui->setupUi(this);

    setWindowTitle("办公用品销售系统");
    setWindowFlags(Qt::FramelessWindowHint);
    setAttribute(Qt::WA_TranslucentBackground);

    QString dbName = "office_supplies_db";
    sql = MySqlTool::Instance(dbName);
    updateUiDataOfDB();


    order_model = new QSqlTableModel(this,MySqlTool::getDb());

    order_model->setTable("orders");
    order_model->select();
    ui->tableView->setModel(order_model);


    order_model->setHeaderData(0, Qt::Horizontal, tr("订单ID"));
    order_model->setHeaderData(1, Qt::Horizontal, tr("客户ID"));
    order_model->setHeaderData(2, Qt::Horizontal, tr("下单时间"));
    order_model->setHeaderData(3, Qt::Horizontal, tr("对接员工"));
    order_model->setHeaderData(4, Qt::Horizontal, tr("收货地址"));
    order_model->setHeaderData(5, Qt::Horizontal, tr("订单状态"));

    ui->tableView->resizeColumnsToContents();

    current_update_orderid = -1;

    if(isRoot == false){
        ui->frame_3->setEnabled(false);
        ui->frame_4->setEnabled(false);
    }
}

OsssWindow::~OsssWindow()
{
    delete ui;
}

void OsssWindow::updateUiDataOfDB()
{
    customersList.clear();
    employeesList.clear();
    productsList.clear();
    customersList.append(id_and_name());
    employeesList.append(id_and_name());
    productsList.append(id_and_name());

    QSqlQuery query(MySqlTool::getDb());




    if (!query.exec(QString("select customer_id,customer_name from customer"))) {
        qDebug() << "查询失败:" << query.lastError().text();
    }else{
        ui->cb_customer->clear();
        ui->cb_customer->addItem("购买方");
        while (query.next()) {
            QString customerId = query.value("customer_id").toString();
            QString customerName = query.value("customer_name").toString();
            customersList.append(id_and_name(customerId,customerName));

            ui->cb_customer->addItem(customerName);
        }
    }

    if (!query.exec(QString("select employee_id, employee_name from employee"))) {
        qDebug() << "查询失败:" << query.lastError().text();
    }else{
        ui->cb_employee->clear();
        ui->cb_employee->addItem("对接员工");
        while (query.next()) {
            QString employeeId = query.value("employee_id").toString();
            QString employeeName = query.value("employee_name").toString();
            employeesList.append(id_and_name(employeeId,employeeName));

            ui->cb_employee->addItem(employeeName);
        }
    }

    if (!query.exec(QString("select product_id,product_name,unit_price from product"))) {
        qDebug() << "查询失败:" << query.lastError().text();
    }else{
        ui->cb_product->clear();
        ui->cb_product_update->clear();
        disconnect(ui->cb_product, &QComboBox::currentIndexChanged, this, &OsssWindow::cb_product_currentIndexChanged);
        ui->cb_product->addItem("购买商品");
        ui->cb_product_update->addItem("选择商品");
        while (query.next()) {
            QString productId = query.value("product_id").toString();
            QString productName = query.value("product_name").toString();
            id_and_name ian(productId,productName);
            ian.product_price = query.value("unit_price").toString();
            productsList.append(ian);


            ui->cb_product->addItem(productName);
            ui->cb_product_update->addItem(productName);
        }
        connect(ui->cb_product, &QComboBox::currentIndexChanged, this, &OsssWindow::cb_product_currentIndexChanged);
    }


}

void OsssWindow::on_btn_stoping_clicked()
{
    if(ui->cb_customer->currentIndex() == 0 ||
        ui->cb_employee->currentIndex() == 0 ||
        ui->cb_product->currentIndex() == 0){
        QMessageBox::critical(this,"提示","选择有效数据");
    }else if(ui->le_address->text().isEmpty()){
        QMessageBox::critical(this,"提示","请填写地址");
    }else{
        QString customerid = customersList.at(ui->cb_customer->currentIndex()).id;
        QString employeeid = employeesList.at(ui->cb_employee->currentIndex()).id;
        QString address = ui->le_address->text();
        QString productid = productsList.at(ui->cb_product->currentIndex()).id;
        QString quantity = ui->sb_quantity->text();

        QSqlQuery query(MySqlTool::getDb());

        if(!query.exec(QString("call place_order(%1,%2,'%3',%4,%5)")
                            .arg(customerid,employeeid,address,productid,quantity))){
            qDebug()<<query.lastError();
            QString str = query.lastError().databaseText();
            QMessageBox::critical(this,"失败",str);
        }else{
            if (query.next()) {
                order_model->select();
                QMessageBox::information(this,"成功","订单号: "+query.value("order_id").toString());
            }
        }
    }
}


void OsssWindow::on_btn_update_clicked()
{
    if(ui->cb_product_update->currentIndex() == 0){
        QMessageBox::critical(this,"提示","选择有效数据");
    }else if(ui->le_reason->text().isEmpty()){
        QMessageBox::critical(this,"提示","请填写原因");
    }else{
        QString reason = ui->le_reason->text();
        QString productid = productsList.at(ui->cb_product_update->currentIndex()).id;
        QString newPrice = ui->sb_newPrice->text();

        QSqlQuery query(MySqlTool::getDb());

        if(!query.exec(QString("call update_product_price(%1,%2,'%3')")
                            .arg(productid,newPrice,reason))){

            QMessageBox::critical(this,"失败",query.lastError().databaseText());
        }else{
            if (query.next()) {
                QString productName = query.value("product_name").toString();
                double oldPrice = query.value("old_price").toDouble();
                double newPrice = query.value("new_price").toDouble();
                QString reason = query.value("reason").toString();

                QMessageBox::information(nullptr, "价格更新成功",
                                         QString("%1 价格已更新\n从 %2 到 %3\n原因: %4")
                                             .arg(productName)
                                             .arg(oldPrice)
                                             .arg(newPrice)
                                             .arg(reason));
            } else {
                QMessageBox::warning(nullptr, "警告", "更新成功但未返回详细信息");
            }
        }
    }

}


void OsssWindow::cb_product_currentIndexChanged(int index)
{
    if(index == 0){
        ui->lab_tips_Price->setText("价格");
    }else{
        ui->lab_tips_Price->setText(productsList.at(index).product_price);
    }
}


void OsssWindow::on_btn_state_clicked()
{
    if(current_update_orderid == -1){
        QMessageBox::critical(this,"错误","未选择商品");
        return;
    }
    QSqlQuery query(MySqlTool::getDb());

    QString before_info,last_info;
    QString querysql = QString(
                           "select p.product_name, i.current_quantity "
                           "from orders o "
                           "join order_detail od on o.order_id = od.order_id "
                           "join product p on od.product_id = p.product_id "
                           "join inventory i on p.product_id = i.product_id "
                           "where o.order_id = %1 "
                           ).arg(current_update_orderid);
    QString querysql2 = QString(
                            "select i.current_quantity "
                            "from orders o "
                            "join order_detail od on o.order_id = od.order_id "
                            "join product p on od.product_id = p.product_id "
                            "join inventory i on p.product_id = i.product_id "
                            "where o.order_id = %1 "
                            ).arg(current_update_orderid);


    if (query.exec(querysql)) {
        while(query.next()){
            QString product_name = query.value("product_name").toString();
            QString before_qty = query.value("current_quantity").toString();
            before_info=before_info + QString("更新前库存:%1:%2").arg(product_name,before_qty) + '\n';
        }


    } else {
        qDebug() << "库存查询失败:" << query.lastError().text();
        return;
    }

    QString updatesql = QString("update orders set status = '%1' where order_id = %2")
                            .arg(ui->cb_select_state->currentText(),QString::number(current_update_orderid));

    if(!query.exec(updatesql)){
        QMessageBox::critical(this,"错误",query.lastError().databaseText());
        return;
    }

    if (query.exec(querysql2)) {
        while(query.next()){
            QString product_name = query.value("product_name").toString();
            QString before_qty = query.value("current_quantity").toString();
            last_info= last_info + QString("更新前库存:%1:%2").arg(product_name,before_qty) + '\n';
        }
        QMessageBox::information(this,"更新成功",before_info + '\n' + last_info);
    } else {
        qDebug() << "库存查询失败:" << query.lastError().text();
        return;
    }


    ui->lab_order_state->setText(ui->cb_select_state->currentText());
    order_model->select();
}

void OsssWindow::on_tableView_clicked(const QModelIndex &index)
{
    QModelIndex data = index.sibling(index.row(),5);

    ui->lab_order_state->setText(order_model->data(data).toString());

    QModelIndex data2 = index.sibling(index.row(),0);
    current_update_orderid = order_model->data(data2).toInt();
}


void OsssWindow::on_btn_del_order_clicked()
{
    if(current_update_orderid == -1){
        QMessageBox::critical(this,"错误","未选择商品");
        return;
    }

    QSqlQuery query(MySqlTool::getDb());

    if(!query.exec(QString("delete from orders where order_id = %1;").arg(current_update_orderid))){
        QMessageBox::critical(this,"错误",query.lastError().text());
    }else{
        QMessageBox::information(this,"提示","删除成功");
        order_model->select();
    }
}

#include "showview_ofsql.h"
void OsssWindow::on_btn_show_order_detial_clicked()
{
    showView_ofSql view;
    view.viewTo_order_datiel();
    view.exec();
}


void OsssWindow::on_btn_savefun_1_clicked()
{
    showView_ofSql view;
    view.view_saveFun_1();
    view.exec();
}


void OsssWindow::on_btn_savefun_2_clicked()
{
    showView_ofSql view;
    view.view_saveFun_2();
    view.exec();
}

void OsssWindow::on_btn_show_inventory_overview_clicked()
{
    showView_ofSql view;
    view.viewTo_inventory_overview();
    view.exec();
}


void OsssWindow::on_btn_show_sales_summary_clicked()
{
    showView_ofSql view;
    view.viewTo_sales_summary();
    view.exec();
}

void OsssWindow::on_btn_query_3_clicked()
{
    showView_ofSql view;
    QString query =
        "select order_id, customer_id, order_date, delivery_address "
        "from orders "
        "where status = '已完成' "
        "order by order_date desc";
    view.viewTo_query(query,"查询所有'已完成'状态的订单详细信息");
    view.exec();
}

void OsssWindow::on_btn_query_4_clicked()
{
    showView_ofSql view;
    QString query =
        "select o.order_id, p.product_name, od.quantity, od.unit_price, "
        "(od.quantity * od.unit_price) as subtotal "
        "from orders o "
        "join order_detail od on o.order_id = od.order_id "
        "join product p on od.product_id = p.product_id "
        "where o.order_id = 1";
    view.viewTo_query(query,"查询订单id为'1'的所有商品明细");
    view.exec();
}

void OsssWindow::on_btn_query_5_clicked()
{
    showView_ofSql view;
    QString query =
        "select p.category, "
        "count(*) as sales_count, "
        "sum(od.quantity) as total_quantity, "
        "sum(od.quantity * od.unit_price) as total_sales, "
        "avg(od.unit_price) as avg_price "
        "from order_detail od "
        "join product p on od.product_id = p.product_id "
        "group by p.category "
                    "order by total_sales desc";
    view.viewTo_query(query,"统计各类别商品的总销售额和平均单价");
    view.exec();
}
void OsssWindow::on_btn_query_6_clicked()
{
    showView_ofSql view;
    QString query =
        "select c.customer_id, c.customer_name, "
        "sum(od.quantity * od.unit_price) as total_spent "
        "from customer c "
        "join orders o on c.customer_id = o.customer_id "
        "join order_detail od on o.order_id = od.order_id "
        "group by c.customer_id, c.customer_name "
        "having total_spent > 1000 "
        "order by total_spent desc";
    view.viewTo_query(query,"查询总消费金额超过1000元的客户及其消费总额");
    view.exec();
}
void OsssWindow::on_btn_query_7_clicked()
{
    showView_ofSql view;
    QString query =
        "select o.order_id,o.order_date,c.customer_name,p.product_name,p.category,od.quantity,od.unit_price,"
        "(od.quantity * od.unit_price) as subtotal "
        "from "
        "orders o "
        "join customer c on o.customer_id = c.customer_id "
        "join order_detail od on o.order_id = od.order_id "
        "join product p on od.product_id = p.product_id "
        "where "
        "o.order_date between '2023-01-01' and '2026-01-1' "
        "order by "
        "o.order_date, "
        "o.order_id, "
        "p.category";
    view.viewTo_query(query,"查询至今到2023年的商品订单详情");
    view.exec();
}
void OsssWindow::on_btn_query_8_clicked()
{
    showView_ofSql view;
    QString query =
        "select "
        "p.category as '商品类别', "
        "count(*) as '销售记录数', "
        "sum(od.quantity) as '销售总量', "
        "round(sum(od.quantity * od.unit_price), 2) as '总销售额' "
        "from "
        "product p "
        "join order_detail od on p.product_id = od.product_id "
        "group by "
        "p.category "
        "order by "
        "sum(od.quantity * od.unit_price) desc";
    view.viewTo_query(query,"查询各类商品的销售总量和总销售额");
    view.exec();
}
void OsssWindow::on_btn_query_9_clicked()
{
    showView_ofSql view;
    QString query =
        "select customer_id, customer_name, phone "
        "from customer c "
        "where exists ( "
        "select 1 from orders o "
        "where o.customer_id = c.customer_id "
        "and o.status != '已完成' "
        ")";
        view.viewTo_query(query,"查询存在未完成订单的客户信息");
    view.exec();
}
void OsssWindow::on_btn_query_10_clicked()
{
    showView_ofSql view;
    QString query =
        "select e.employee_id, e.employee_name, e.department, "
        "count(distinct o.order_id) as order_count, "
        "sum(od.quantity * od.unit_price) as total_sales, "
        "rank() over (order by sum(od.quantity * od.unit_price) desc) as sales_rank "
        "from employee e "
        "join orders o on e.employee_id = o.employee_id "
        "join order_detail od on o.order_id = od.order_id "
        "group by e.employee_id, e.employee_name, e.department "
        "order by total_sales desc";
    view.viewTo_query(query,"统计每位员工处理的订单总金额和订单数量");
    view.exec();
}

void OsssWindow::on_btn_exit_clicked()
{
    exit(0);
}

void OsssWindow::mousePressEvent(QMouseEvent *event)
{
    if (event->button() == Qt::LeftButton) {

        QObject *obj = childAt(event->pos());
        if(obj == ui->frame ||
            obj == ui->frame_2 ||
            obj == ui->frame_3 ||
            obj == ui->frame_4 ||
            obj == ui->frame_5)
        {
            isActionDrag = true;
        }
        m_dragStartPosition = event->globalPosition().toPoint() - this->window()->frameGeometry().topLeft();
        event->accept();
    }
}

void OsssWindow::mouseMoveEvent(QMouseEvent *event)
{
    if (isActionDrag && event->buttons() & Qt::LeftButton) {

        QPoint newPos = event->globalPosition().toPoint() - m_dragStartPosition;
        this->window()->move(newPos);

        event->accept();
    }
}

void OsssWindow::mouseReleaseEvent(QMouseEvent *event)
{
    isActionDrag = false;
    Q_UNUSED(event);
}



