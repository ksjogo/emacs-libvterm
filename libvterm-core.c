#include <vterm.h>
#include <vterm_keycodes.h>
#include <emacs-module.h>
#include <string.h>

/* Declare mandatory GPL symbol.  */
int plugin_is_GPL_compatible;

//UTILS

/* Bind NAME to FUN.  */
static void bind_function (emacs_env *env, const char *name, emacs_value Sfun)
{
    /* Set the function cell of the symbol named NAME to SFUN using
       the 'fset' function.  */

    /* Convert the strings to symbols by interning them */
    emacs_value Qfset = env->intern (env, "fset");
    emacs_value Qsym = env->intern (env, name);

    /* Prepare the arguments array */
    emacs_value args[] = { Qsym, Sfun };

    /* Make the call (2 == nb of arguments) */
    env->funcall (env, Qfset, 2, args);
}

/* Provide FEATURE to Emacs.  */
static void provide (emacs_env *env, const char *feature)
{
    /* call 'provide' with FEATURE converted to a symbol */

    emacs_value Qfeat = env->intern (env, feature);
    emacs_value Qprovide = env->intern (env, "provide");
    emacs_value args[] = { Qfeat };

    env->funcall (env, Qprovide, 1, args);
}

//HELPERS

//FUNCS

static emacs_value Flibvterm_test (emacs_env *env, ptrdiff_t nargs, emacs_value args[], void *data)
{
    return env->make_integer (env, 42);
}

static emacs_value Flibvterm_new (emacs_env *env, ptrdiff_t nargs, emacs_value args[], void *data)
{
    VTerm *vterm = vterm_new(20,80);
    return env->make_integer (env, 1);
}

//INIT

int emacs_module_init (struct emacs_runtime *ert)
{
    emacs_env *env = ert->get_environment (ert);

#define DEFUN(lsym, csym, amin, amax, doc, data)  bind_function (env, lsym, env->make_function(env, amin, amax, csym, doc, data))

    DEFUN("libvterm-core-test", Flibvterm_test, 0, 0, "libvterm test", NULL);
    DEFUN("libvterm-new", Flibvterm_new, 0, 0, "libvterm new", NULL);

#undef DEFUN

    provide (env, "libvterm-core");

    return 0;
}
