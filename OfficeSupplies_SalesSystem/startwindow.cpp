#include "startwindow.h"
#include "ui_startwindow.h"

StartWindow::StartWindow(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::StartWindow)
{
    ui->setupUi(this);
    setWindowTitle("请登录");
    QString dbName = "office_supplies_db";
    sql = MySqlTool::Instance(dbName);

    ui->le_inputname->setPlaceholderText("请输入用户名");
    ui->le_inputname_2->setPlaceholderText("请输入密码");
    ui->le_inputname_2->setEchoMode(QLineEdit::Password);
    ui->stackedWidget->setCurrentIndex(0);


    ui->le_inputname->setText("root123");
    ui->le_inputname_2->setText("1234");

}

StartWindow::~StartWindow()
{
    delete ui;
}

void StartWindow::on_btn_login_clicked()
{
    QString name = ui->le_inputname->text();
    QString pwd = ui->le_inputname_2->text();

    QSqlQuery query(MySqlTool::getDb());

    QString sql = QString("select * from user where name = '%1'").arg(name);

    if(name.isEmpty() || pwd.isEmpty()){
        QMessageBox::critical(NULL, "登录失败","请输入用户名或密码");
    }else if (!query.exec(sql)) {
        QMessageBox::critical(NULL, "查询错误","执行查询时出错:\n" + query.lastError().text());
    }else if(!query.next()){
        QMessageBox::critical(NULL, "登录失败","用户名错误");
    }else {
        QString ppwd = query.value(1).toString();
        QString prole = query.value(2).toString();

        if(ppwd != pwd){
            QMessageBox::critical(NULL, "登录失败","密码错误");
        }else{
            QMessageBox::information(NULL, "登录成功","欢迎\n身份是:"+prole);
            OsssWindow *ow = new OsssWindow(nullptr,prole == "管理员");
            ow->show();
            this->close();
        }
    }
}

void StartWindow::on_btn_reg_clicked()
{
    QString name = ui->le_inputname_3->text();
    QString pwd = ui->le_inputname_4->text();
    QString pwd2 = ui->le_inputname_5->text();
    QString role = ui->cb_isAdmin->isChecked()?"管理员":"游客";

    QSqlQuery query(MySqlTool::getDb());
    QString sql = QString("select * from user where name = '%1'").arg(name);
    QString sql2 = QString("insert into user values('%1','%2','%3')").arg(name,pwd,role);

    if(name.isEmpty() || pwd.isEmpty()){
        QMessageBox::critical(NULL, "注册失败","请输入用户名或密码");
    }else if(pwd != pwd2){
            QMessageBox::critical(NULL, "注册失败","两次密码不一致");
    }else if (!query.exec(sql)) {
        QMessageBox::critical(NULL, "查询错误","执行查询时出错:\n" + query.lastError().text());
    }else if(query.next()){
        QMessageBox::critical(NULL, "注册失败","用户已经存在");
    }else if(!query.exec(sql2)){
        QMessageBox::critical(NULL, "插入错误","执行插入时出错:\n" + query.lastError().text());
    }else{
        QMessageBox::information(NULL, "注册成功","用户名: "+name+"\n身份是:"+role);
    }
}

void StartWindow::on_btn_exitsys_clicked()
{
    ui->stackedWidget->setCurrentIndex(1);
}

void StartWindow::on_btn_back_clicked()
{
    ui->stackedWidget->setCurrentIndex(0);
}

