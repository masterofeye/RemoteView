#pragma once
#include "qwidget.h"

class QTextEdit;
class QLabel;
class QBoxLayout;
class QTimer;

enum class Information
{
    INFO,
    WARNING,
    ALERT,
    NON
};

class MessageWindow :
    public QWidget
{
    Q_OBJECT

private:
    enum class TasklistOrientation
    {
        TOP,
        BOTTOM,
        LEFT,
        RIGHT,
        NON
    };

    QLabel *m_Message = nullptr;
    QLabel *m_Icon = nullptr;
    QBoxLayout *m_Layout = nullptr;
    QTimer *m_Timer = nullptr;
public:
    MessageWindow(QWidget *parent = nullptr);
    ~MessageWindow();
public slots:
    void Ballon(quint64 Msecs, QString Message, Information Index);
private:
    TasklistOrientation GetTaskListOrientation();
    void OnTimeout();
protected:
    void mousePressEvent(QMouseEvent *event);
};

Q_DECLARE_METATYPE(Information)

