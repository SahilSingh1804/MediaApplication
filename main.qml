import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15
 import Qt.labs.platform 1.1

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("Media Player")
    property int playbackSpeed: 1
    property int forwardOffset: 1000
    onPlaybackSpeedChanged: {
        if(playbackSpeed > 5)
            playbackSpeed = 5
        if(playbackSpeed < 1)
            playbackSpeed = 1
    }
    onForwardOffsetChanged: {
        if(forwardOffset > 10000)
            forwardOffset = 10000

        if(forwardOffset < 1000)
            forwardOffset = 1000
    }


    FileDialog {
        id: dialog
        nameFilters: ["AVI files (*.avi)"]
        onAccepted: com.addVideo(file)
    }

//    Timer{
//        id: plybackTimer
//        duration:
//    }

    Rectangle {
        id: root
        anchors.fill: parent
        color: "black"

        Column {
            id: mainCol
            width: parent.width
            Row {
                id: video_Playlist
                height: root.height - (root.height/10)
                Rectangle {
                    id: videoRect
                    width: (root.width - root.width/4)
                    height: parent.height//root.height - root.height/10
                    color: "transparent"
                    border.width: 1
                    border.color: "green"

                    Video {
                        id: video
                        width: parent.width - (parent.border.width*3)
                        height: parent.height - (parent.border.width*3)
                        anchors.centerIn: parent
                        playbackRate: playbackSpeed
                        audioRole: MediaPlayer.VideoRole
                    }
                }

                Rectangle {
                    id: playlistRect
                    width: mainCol.width - videoRect.width
                    height: parent.height//videoRect.height
                    color: "transparent"
                    border.width: 1
                    border.color: "green"

                    Rectangle {
                        id: playlistHeader
                        width: parent.width
                        height: parent.height/18
                        anchors.top: parent.top
                        color: "transparent"
                        border.width: 1
                        border.color: "green"
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: height
                            color: "grey"
                            text: qsTr("Playlist")
                        }
                    }

                    Rectangle {
                        id: playListArea
                        width: parent.width - (parent.border.width*5)
                        height: parent.height - settingsRect.height - playlistHeader.height - (parent.border.width*5)
                        anchors.top: playlistHeader.bottom
                        anchors.topMargin: parent.border.width*2
                        anchors.horizontalCenter: playlistHeader.horizontalCenter
                        color: "transparent"
                        clip: true

                        Column {
                            width: parent.width
                            spacing: 5

                            Rectangle {
                                id: addSongBtn
                                width: parent.width/2
                                height: width/4
                                color: "lightSteelBlue"
                                border.width: 2
                                border.color: "transparent"
                                anchors.horizontalCenter: parent.horizontalCenter
                                Text {
                                    text: qsTr("Add Song")
                                    anchors.centerIn: parent
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onPressed: parent.border.color = "blue"
                                    onReleased: parent.border.color = "transparent"
                                    onClicked: dialog.open()
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: playListArea.height - addSongBtn.height - addSongBtn.height/2
                                ListView {
                                    anchors.fill: parent
                                    model: com.videos//100
                                    spacing: 2
                                    delegate: Rectangle {
                                        width: playListArea.width
                                        height: 20
                                        color: "lightsteelblue"
                                        Text {
                                            id: musicName
                                            anchors.centerIn: parent
                                            color: "black"
                                            text: modelData//qsTr("text")
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            onDoubleClicked: video.source = musicName.text
                                        }
                                    }
                                }

                            }
                        }


                    }

                    Rectangle {
                        id: settingsRect
                        width: parent.width - (parent.border.width*5)
                        height: parent.height - (parent.height/1.5)
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.border.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "transparent"
                        Rectangle {
                            id: settingsHeader
                            width: parent.width
                            height: parent.height/6
                            anchors.top: parent.top
                            color: "transparent"
                            border.width: 1
                            border.color: "green"
                            Text {
                                anchors.centerIn: parent
                                font.pixelSize: height
                                color: "grey"
                                text: qsTr("Settings")
                            }
                        }

                        Rectangle {
                            id: settingArea
                            width: parent.width
                            height: parent.height - settingsHeader.height
                            anchors.top: settingsHeader.bottom
                            color: "transparent"

                            Column {
                                anchors.centerIn: parent
                                width: parent.width
                                spacing: height/3

                                Rectangle {
                                    id: playbackSpeedRect
                                    height: settingArea.height/4
                                    width: settingArea.width - settingArea.width/2
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "transparent"

                                    Row {
                                        height: parent.height
                                        Rectangle {
                                            id: decrementer
                                            width: playbackSpeedRect.width/3
                                            height: parent.height
                                            Text {
                                                anchors.centerIn: parent
                                                color: "black"
                                                text: "-"
                                            }
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: playbackSpeed = playbackSpeed-1
                                            }
                                        }
                                        Rectangle {
                                            width: playbackSpeedRect.width/3
                                            height: parent.height
                                            color: "transparent"
                                            Text {
                                                anchors.centerIn: parent
                                                color: "white"
                                                text: playbackSpeed
                                            }
                                        }
                                        Rectangle {
                                            id: incrementer
                                            width: playbackSpeedRect.width/3
                                            height: parent.height
                                            Text {
                                                anchors.centerIn: parent
                                                color: "black"
                                                text: "+"
                                            }
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: playbackSpeed = playbackSpeed+1
                                            }
                                        }
                                    }
                                }
                                Rectangle {
                                    height: settingArea.height/4
                                    width: settingArea.width - settingArea.width/2
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "transparent"

                                    Rectangle {
                                        id: forwardOffsetRect
                                        height: settingArea.height/4
                                        width: settingArea.width - settingArea.width/2
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        color: "transparent"

                                        Row {
                                            height: parent.height
                                            Rectangle {
                                                id: offSetDecrementer
                                                width: playbackSpeedRect.width/3
                                                height: parent.height
                                                Text {
                                                    anchors.centerIn: parent
                                                    color: "black"
                                                    text: "-"
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    onClicked: forwardOffset = forwardOffset-1000
                                                }
                                            }
                                            Rectangle {
                                                width: playbackSpeedRect.width/3
                                                height: parent.height
                                                color: "transparent"
                                                Text {
                                                    anchors.centerIn: parent
                                                    color: "white"
                                                    text: forwardOffset
                                                }
                                            }
                                            Rectangle {
                                                id: offSetIncrementer
                                                width: playbackSpeedRect.width/3
                                                height: parent.height
                                                Text {
                                                    anchors.centerIn: parent
                                                    color: "black"
                                                    text: "+"
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    onClicked: forwardOffset = forwardOffset+1000
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: controlRect
                width: parent.width
                height: root.height - video_Playlist.height
                color: "transparent"
                border.width: 1
                border.color: "green"
                Column {
                    id: controlCol
                    width: parent.width
                    anchors.centerIn: parent
                    spacing: 1
                    Rectangle {
                        id: seekerRect
                        width: parent.width// - (parent.width/4)
                        height: controlRect.height  - controlRect.height/1.5
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            id: mainSeekerLine
                            width: parent.width - (parent.width/7)
                            height: 2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            Rectangle {
                                id: duration
                                width: parent.width/13
                                height: seekerRect.height
                                anchors.right: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"
                                Text {
                                    color: "white"
                                    font.pixelSize: parent.height/2
                                    anchors.centerIn: parent
                                    text: {
                                        var mSec = video.duration
                                        var sec = mSec/1000
                                        var mins = sec/60

                                        return mins.toFixed(2)
                                    }
                                }
                            }

                            Rectangle {
                                id: elapsed
                                width: parent.width/13
                                height: seekerRect.height
                                anchors.left: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"
                                Text {
                                    color: "white"
                                    font.pixelSize: parent.height/2
                                    anchors.centerIn: parent
                                    text: {
                                        var mSec = video.duration - video.position
                                        var sec = mSec/1000
                                        var mins = sec/60

                                        var seekerUnit = mainSeekerLine.width/video.duration
                                        var overlapSeekerWidth = mainSeekerLine.width - ((video.duration - video.position)*seekerUnit)
                                        overlapSeekerLine.width = overlapSeekerWidth
                                        return mins.toFixed(2)

                                    }
                                }
                            }

                            Rectangle {
                                id: overlapSeekerLine
                                width: 1
                                height: mainSeekerLine.height
                                color: "blue"
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
//                                rotation: 180

                                Rectangle {
                                    id: seeker
                                    height: seekerRect.height/2
                                    width: height
                                    radius: width/2
                                    color: "green"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right: overlapSeekerLine.right
                                    property bool draggingEnable: false

                                    MouseArea {
                                        anchors.fill: parent

                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: controlSection
                        width: parent.width/5
                        height: controlRect.height - seekerRect.height - (controlRect.height/10)
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "transparent"
                        Row {
                            height: parent.height
                            anchors.horizontalCenter: parent.horizontalCenter

                            Rectangle {
                                id: backButton
                                height: parent.height
                                width: height//parent.width
                                color: "transparent"
                                radius: height/3
                                border.width: 2
//                                border.color: "blue"
                                anchors.verticalCenter: parent.verticalCenter

                                Image {
                                    height: parent.height
                                    width: parent.width
                                    source: "qrc:/FastForwardButton.png"
                                    rotation: 180

                                    MouseArea {
                                        anchors.fill: parent
                                        onPressed: backButton.border.color = "blue"
                                        onReleased: backButton.border.color = "transparent"
                                        onClicked: {
                                            video.seek(video.position-1000)
                                        }
                                    }
                                }
                            }

                            Image {
                                id: playPauseButton
                                height: parent.height
                                width: height//parent.width
                                property bool playPause: false
                                source: {
                                    if(playPause) {
                                        video.play()
                                        return "qrc:/PauseButton.png"
                                    }
                                    else {
                                        video.pause()
                                        return "qrc:/PlayButton.png"
                                    }

//                                    playPause ? "qrc:/PauseButton.png" : "qrc:/PlayButton.png"
                                }
                                anchors.verticalCenter: parent.verticalCenter

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: parent.playPause = !parent.playPause
                                }
                            }

                            Rectangle {
                                id: forwardButton
                                height: parent.height
                                width: height//parent.width
                                color: "transparent"
                                border.width: 2
                                radius: height/3
                                anchors.verticalCenter: parent.verticalCenter

                                Image {
                                    height: parent.height
                                    width: parent.width
                                    source: "qrc:/FastForwardButton.png"

                                    MouseArea {
                                        anchors.fill: parent
                                        onPressed: forwardButton.border.color = "blue"
                                        onReleased: forwardButton.border.color = "transparent"
                                        onClicked: {
                                            video.seek(video.position+1000)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        focus: true
        Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
        Keys.onLeftPressed: video.seek(video.position - forwardOffset)
        Keys.onRightPressed: video.seek(video.position + forwardOffset)
    }
}
