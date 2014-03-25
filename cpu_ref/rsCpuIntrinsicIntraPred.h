#ifndef RSD_CPU_SCRIPT_INTRINSIC_INTRA_PRED_H
#define RSD_CPU_SCRIPT_INTRINSIC_INTRA_PRED_H

#include "rsCpuIntrinsic.h"
#include "rsCpuIntrinsicInlines.h"
#include "intra/vp9_intra.h"
#include "intra/vp9_blockd.h"
#define MAX_TILE 4

using namespace android;
using namespace android::renderscript;

namespace android {
namespace renderscript {

class RsdCpuScriptIntrinsicIntraPred: public RsdCpuScriptIntrinsic {
public:
    virtual void populateScript(Script *);
    virtual void invokeFreeChildren();

    virtual void setGlobalObj(uint32_t slot, ObjectBase *data);
    virtual void setGlobalVar(uint32_t slot, const void *data, size_t dataLength);
    virtual ~RsdCpuScriptIntrinsicIntraPred();
    RsdCpuScriptIntrinsicIntraPred(RsdCpuReferenceImpl *ctx, const Script *s, const Element *e);

protected:
    INTRA_PARAM *mIntraParam;
    int mBlockCnt;
    static void kernel(const RsForEachStubParamStruct *p,
                       uint32_t xstart, uint32_t xend,
                       uint32_t instep, uint32_t outstep);
};

}
}
#endif
