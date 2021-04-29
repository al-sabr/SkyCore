#pragma once

#include <WControllerFileReply>
#include <WAbstractThreadReply>
#include <WAbstractThreadAction>

// Sk includes
#include <WController>

//=================================================================================================
// WControllerFileAction
//=================================================================================================

class SKY_CORE_EXPORT WControllerFileAction : public WAbstractThreadAction
{
    Q_OBJECT

protected: // WAbstractThreadAction reimplementation
    /* virtual */ WAbstractThreadReply* createReply() const;

public: // Properties
    WControllerFileReply* controllerReply();
};

