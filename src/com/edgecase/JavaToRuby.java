package com.edgecase;

import org.jruby.Ruby;
import java.lang.reflect.Method;
import java.util.Map;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;


class JavaToRuby{
    public static final Ruby RUBY_RUNTIME = Ruby.getDefaultInstance();
    public static final int  DEFAULT_MAX  = 100;

    public JavaToRuby() {}

    public Object randomNumber() throws ScriptException{
        return randomNumber(DEFAULT_MAX);
    }

    public Object randomNumber(int max) throws ScriptException{
        ScriptEngine jruby = new ScriptEngineManager().getEngineByName("jruby");
        /* jruby.put("message", "hello world"); */
        return jruby.eval("puts 'craaaaaaaap!!!!'; rand "+max);
    }
}


