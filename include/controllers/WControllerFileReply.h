#pragma once

#include <WAbstractThreadReply>

// Sk includes
#include <WController>

//=================================================================================================
// WControllerFileReply
//=================================================================================================

class SKY_CORE_EXPORT WControllerFileReply : public WAbstractThreadReply
{
    Q_OBJECT

protected:
    WControllerFileReply() {}

protected: // WAbstractThreadReply reimplementation
    /* virtual */ void onCompleted(bool ok);

signals:
    void actionComplete(bool ok);

private:
    Q_DISABLE_COPY(WControllerFileReply)

        friend class WControllerFileAction;
};
