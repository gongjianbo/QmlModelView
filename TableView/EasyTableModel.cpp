#include "EasyTableModel.h"

#include <QDebug>

EasyTableModel::EasyTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
}

QStringList EasyTableModel::getHorHeader() const
{
    return _horHeaderList;
}

void EasyTableModel::setHorHeader(const QStringList &header)
{
    _horHeaderList=header;
    emit horHeaderChanged();
}

QJsonArray EasyTableModel::getInitData() const
{
    return _initData;
}

void EasyTableModel::setInitData(const QJsonArray &jsonArr)
{
    _initData=jsonArr;
    if(_completed){
        loadData(_initData);
    }
    emit initDataChanged();
}

void EasyTableModel::classBegin()
{
    //qDebug()<<"EasyTableModel::classBegin()";
}

void EasyTableModel::componentComplete()
{
    //qDebug()<<"EasyTableModel::componentComplete()";
    _completed=true;
    if(!_initData.isEmpty()){
        loadData(_initData);
    }
}

QHash<int, QByteArray> EasyTableModel::roleNames() const
{
    //value表示取值，edit表示编辑
    return QHash<int,QByteArray>{
        { Qt::DisplayRole,"value" },
        { Qt::EditRole,"edit" }
    };
}

QVariant EasyTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    //返回表头数据，无效的返回None
    if(role==Qt::DisplayRole){
        if(orientation==Qt::Horizontal){
            return _horHeaderList.value(section,QString::number(section));
        }else if(orientation==Qt::Vertical){
            return QString::number(section);
        }
    }
    return QVariant();
}

bool EasyTableModel::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (value != headerData(section, orientation, role)) {
        if(orientation==Qt::Horizontal&&role==Qt::EditRole){
            _horHeaderList[section]=value.toString();
            emit headerDataChanged(orientation, section, section);
            return true;
        }
    }
    return false;
}


int EasyTableModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return _modelData.count();
}

int EasyTableModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return _horHeaderList.count();
}

QVariant EasyTableModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    switch (role) {
    case Qt::DisplayRole:
    case Qt::EditRole:
        return _modelData.at(index.row()).at(index.column());
    default:
        break;
    }
    return QVariant();
}

bool EasyTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (value.isValid()&&index.isValid()&&(data(index, role) != value)) {
        if(Qt::EditRole==role){
            _modelData[index.row()][index.column()]=value;
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
    }
    return false;
}

Qt::ItemFlags EasyTableModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEnabled|Qt::ItemIsSelectable|Qt::ItemIsEditable;
}

void EasyTableModel::loadData(const QJsonArray &data)
{
    //如果要区分类型的话，可以用role，
    //这样ui中就能使用model.role来获取对应index的参数
    QVector<QVector<QVariant>> newData;
    QJsonArray::const_iterator iter;
    for(iter=data.begin();iter!=data.end();++iter){
        QVector<QVariant> newRow;
        const QJsonObject itemRow=(*iter).toObject();
        newRow.append(itemRow.value("id"));
        newRow.append(itemRow.value("name"));
        newRow.append(itemRow.value("age"));
        newRow.append(itemRow.value("note"));
        newData.append(newRow);
    }

    emit beginResetModel();
    _modelData=newData;
    emit endResetModel();
}

/*
bool EasyTableModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
}

bool EasyTableModel::insertColumns(int column, int count, const QModelIndex &parent)
{
    beginInsertColumns(parent, column, column + count - 1);
    // FIXME: Implement me!
    endInsertColumns();
}

bool EasyTableModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
}

bool EasyTableModel::removeColumns(int column, int count, const QModelIndex &parent)
{
    beginRemoveColumns(parent, column, column + count - 1);
    // FIXME: Implement me!
    endRemoveColumns();
}*/
