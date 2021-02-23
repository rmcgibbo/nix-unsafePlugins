#include <config.h>
#include <primops.hh>
#include <eval-inline.hh>
#include <dlfcn.h>
#include <cstdio>

using namespace nix;


static void prim_traceFd(EvalState & state, const Pos & pos, Value ** args, Value & v)
{
    PathSet context;
    state.forceValue(*args[0], pos);
    if (args[0]->type != tInt) {
        throw EvalError({
            .msg = "`mkTraceFd` expected first argument to be an integer",
            .errPos = pos
        });
    }
    int fd = args[0]->integer;
    state.forceValue(*args[1]);
    string content = state.coerceToString(pos, *args[1], context);
    int nbytes = dprintf(fd, "%s\n", content.c_str());
    if (nbytes == 0) {
      throw EvalError({
            .msg = "`mkTraceFd` failed to print to file descriptor",
            .errPos = pos
        });
    }

    state.forceValue(*args[2]);
    v = *args[2];
}


static RegisterPrimOp rp("traceFd", 3, prim_traceFd);
