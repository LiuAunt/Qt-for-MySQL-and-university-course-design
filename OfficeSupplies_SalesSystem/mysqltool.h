#ifndef MYSQLTOOL_H
#define MYSQLTOOL_H
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QMessageBox>


class MySqlTool
{
public:
    MySqlTool(const QString &filename);
    ~MySqlTool();

    static MySqlTool* Instance(const QString &filename);
    void CreateDatabase();
    static QSqlDatabase getDb(){
        if(psql == NULL)qDebug()<<"数据库未连接";
        return staticDB;
    }

private:

    QString databaseName;
    static MySqlTool *psql;
    static QSqlDatabase staticDB;

};

#endif // MYSQLTOOL_H
