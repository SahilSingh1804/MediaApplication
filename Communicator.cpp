#include "Communicator.h"

Communicator::Communicator(QObject *parent)
    : QObject{parent}
{

}

const QStringList &Communicator::videos() const
{
    return _videos;
}

void Communicator::setVideos(const QStringList &newVideos)
{
    if (_videos == newVideos)
        return;
    _videos = newVideos;
    emit videosChanged();
}

void Communicator::addVideo(QString newVideo)
{
    _videos.append(newVideo);
    emit videosChanged();
}

void Communicator::removeVideo(int index)
{
    _videos.removeAt(index);
    emit videosChanged();
}
