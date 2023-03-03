#ifndef COMMUNICATOR_H
#define COMMUNICATOR_H

#include <QObject>

class Communicator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList videos READ videos WRITE setVideos NOTIFY videosChanged)
public:
    explicit Communicator(QObject *parent = nullptr);

    const QStringList &videos() const;
    void setVideos(const QStringList &newVideos);

    Q_INVOKABLE void addVideo(QString newVideo);

    Q_INVOKABLE void removeVideo(int index);

signals:

    void videosChanged();

private:
    QStringList _videos;

};

#endif // COMMUNICATOR_H
