#include "mysqltool.h"

MySqlTool* MySqlTool::psql = NULL;
QSqlDatabase MySqlTool::staticDB;

MySqlTool::MySqlTool(const QString &filename)
{
    databaseName = filename;
    staticDB = QSqlDatabase::addDatabase("QMYSQL","DataBase_assignment");
    staticDB.setHostName("localhost");  // 本地主机
    staticDB.setPort(3306);             //默认端口号
    staticDB.setUserName("root");       // 设置用户名
    staticDB.setPassword("lskk");       // 设置密码
    staticDB.setDatabaseName(databaseName);
    if(staticDB.open()){
        qDebug() << "数据库打开成功";
    }else{
        qDebug() << "数据库打开失败" << staticDB.lastError().text();
    }
}

MySqlTool::~MySqlTool()
{
    staticDB.close();
}

MySqlTool *MySqlTool::Instance(const QString &filename)
{
    if(psql == NULL){
        psql = new MySqlTool(filename);
    }
    return psql;
}

void MySqlTool::CreateDatabase()
{
    QSqlQuery query(staticDB);

    //只执行一次
    if(query.exec("create table user(name text(50) primary key,pwd text(50),role text(20));")){
        query.exec("insert into user values('xiaoming','123456','访客')");
        query.exec("insert into user values('root123','1234','管理员')");
    }
}
