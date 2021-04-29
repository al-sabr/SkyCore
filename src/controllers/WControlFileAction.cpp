// Sk includes
#include <WAbstractThreadReply>
#include <WControllerFileReply>

//=================================================================================================
// WControllerFileAction
//=================================================================================================

/* virtual */ WAbstractThreadReply * WControllerFileAction::createReply() const
{
    return new WControllerFileReply;
}

//-------------------------------------------------------------------------------------------------

WControllerFileReply * WControllerFileAction::controllerReply()
{
    return qobject_cast<WControllerFileReply *> (reply());
}
