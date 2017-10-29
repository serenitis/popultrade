package com.popultrade.webapp;

import java.util.*;
import javax.servlet.ServletContext;

public class JavaScriptControl implements java.io.Serializable 
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 7788989789898967561L;
	private ServletContext servletContext;
    private boolean jesetcontext;
    private boolean jesetI18n;
    private ResourceBundle rb;
    
    public JavaScriptControl()
    {
        jesetcontext = false;
        jesetI18n = false;
        rb = null;
    }

    public void setServletContext(ServletContext servletContext)
    {
        if(!jesetcontext)
        {
            this.servletContext = servletContext;
            jesetcontext = true;
        }
    }

    public String getControlsEmptyValues(String formnamepath, String values[])
    {
        StringBuffer sbuf = new StringBuffer();
        if(values.length > 0)
        {
            sbuf.append("<script language='javascript'>\n");
            sbuf.append("function check() {\n");
            for(int a = 0; a < values.length; a++)
            {
                sbuf.append((new StringBuilder()).append("if (typeof(").append(formnamepath).append(".").append(values[a]).append(")!='undefined' && ").append(formnamepath).append(".").append(values[a]).append(".disabled==false  && ").append(formnamepath).append(".").append(values[a]).append(".readOnly==false  && ( ").append(formnamepath).append(".").append(values[a]).append("==null || ").append(formnamepath).append(".").append(values[a]).append(".value=='')) {\n").toString());
                sbuf.append((new StringBuilder()).append("alert('").append(values[a]).append(" ").append(" ").append("');\n").append(formnamepath).append(".").append(values[a]).append(".focus();\n return false;\n}\n").toString());
            }

            sbuf.append("if (window.number){\n if(!number()) {\nreturn false;\n}\n}\n");
            sbuf.append("if (window.number2){\n if(!number2()) {\nreturn false;\n}\n}\n");
            sbuf.append("if (window.size){\n if(!size()) {\nreturn false;\n}\n}\n");
            sbuf.append("if (window.datee){\n if(!datee()) {\nreturn false;\n}\n}\n");
            sbuf.append("if (window.custom){\n if(!custom()) {\nreturn false;\n}\n}\n");
            sbuf.append("return true;\n}\n</script>");
            return sbuf.toString();
        } else
        {
            return "";
        }
    }

    public String getControlsNumericValues(String formnamepath, String values[])
    {
        StringBuffer sbuf = new StringBuffer();
        if(values.length > 0)
        {
            sbuf.append("<script language='javascript' src='scripts/isNumeric.js'></script>\n");
            sbuf.append("<script language='javascript'>\n");
            sbuf.append("function number() {\n");
            for(int a = 0; a < values.length; a++)
            {
                sbuf.append((new StringBuilder()).append("if (").append(formnamepath).append(".").append(values[a]).append("!='' && ").append(formnamepath).append(".").append(values[a]).append(".disabled==false && ").append(formnamepath).append(".").append(values[a]).append(".readOnly==false && !isNum(").append(formnamepath).append(".").append(values[a]).append(".value) ) {\n").toString());
                sbuf.append((new StringBuilder()).append("alert('").append(values[a]).append("');\n").append(formnamepath).append(".").append(values[a]).append(".focus();\n return false;\n}\n").toString());
            }

            sbuf.append("return true;\n}\n</script>");
            return sbuf.toString();
        } else
        {
            return "";
        }
    }

    public String getControlsDateValues(String formnamepath, String values[])
    {
        StringBuffer sbuf = new StringBuffer();
        if(values.length > 0)
        {
            sbuf.append("<script language='javascript' src='scripts/isNumeric.js'></script>\n");
            sbuf.append("<script language='javascript'>\n");
            sbuf.append("function datee() {\n");
            for(int a = 0; a < values.length; a++)
            {
                sbuf.append((new StringBuilder()).append("if (typeof(").append(formnamepath).append(".").append(values[a]).append(")!='undefined' && ").append(formnamepath).append(".").append(values[a]).append(".disabled==false  && ").append(formnamepath).append(".").append(values[a]).append(".readOnly==false && ").append(formnamepath).append(".").append(values[a]).append("!='' && !checkdatum(").append(formnamepath).append(".").append(values[a]).append(".value)) {\n").toString());
                sbuf.append((new StringBuilder()).append("alert('").append(values[a]).append("');\n").append(formnamepath).append(".").append(values[a]).append(".focus();\n return false;\n}\n").toString());
            }

            sbuf.append("return true;\n}\n</script>");
            return sbuf.toString();
        } else
        {
            return "";
        }
    }

    public String getControlsEmptyValuesHashtable(String formnamepath, Hashtable values)
    {
        StringBuffer sbuf = new StringBuffer();
        if(values.size() > 0)
        {
            sbuf.append("<script language='javascript'>\n");
            sbuf.append("function check() {\n");
            String key;
            for(Enumeration en = values.keys(); en.hasMoreElements(); sbuf.append((new StringBuilder()).append("alert('").append(key).append(" ").append("").append("');\n").append(formnamepath).append(".").append(values.get(key)).append(".focus();\n return false;\n}\n").toString()))
            {
                key = en.nextElement().toString();
                sbuf.append((new StringBuilder()).append("if ( (typeof(").append(formnamepath).append(".").append(values.get(key)).append(")!='undefined' && ").append(formnamepath).append(".").append(values.get(key)).append(".disabled==false  && (").append(formnamepath).append(".").append(values.get(key)).append(".readOnly==null || ").append(formnamepath).append(".").append(values.get(key)).append(".readOnly==false)  && trim(").append(formnamepath).append(".").append(values.get(key)).append(".value)=='') ) {\n").toString());
            }

            sbuf.append("if (window.number){\n if(!number()) {\nreturn false;\n}\n}\n");
            sbuf.append("if (window.number2){\n if(!number2()) {\nreturn false;\n}\n}\n");
            sbuf.append("if (window.size){\n if(!size()) {\nreturn false;\n}\n}\n");
            sbuf.append("if (window.datee){\n if(!datee()) {\nreturn false;\n}\n}\n");
            sbuf.append("if (window.custom){\n if(!custom()) {\nreturn false;\n}\n}\n");
            sbuf.append("return true;\n}\n</script>");
            return sbuf.toString();
        } else
        {
            return "";
        }
    }

    public String getControlsNumericValuesHashtable(String formnamepath, Hashtable values)
    {
        StringBuffer sbuf = new StringBuffer();
        if(values.size() > 0)
        {
            sbuf.append("<script language='javascript' src='scripts/isNumeric.js'></script>\n");
            sbuf.append("<script language='javascript'>\n");
            sbuf.append("function number() {\n");
            String key;
            for(Enumeration en = values.keys(); en.hasMoreElements(); sbuf.append((new StringBuilder()).append("alert('").append(key).append("');\n").append(formnamepath).append(".").append(values.get(key)).append(".focus();\n return false;\n}\n").toString()))
            {
                key = en.nextElement().toString();
                sbuf.append((new StringBuilder()).append("if (typeof(").append(formnamepath).append(".").append(values.get(key)).append(")!='undefined' && ").append(formnamepath).append(".").append(values.get(key)).append(".disabled==false  && ").append(formnamepath).append(".").append(values.get(key)).append(".readOnly==false && trim(").append(formnamepath).append(".").append(values.get(key)).append(".value)!=''  && (").append(formnamepath).append(".").append(values.get(key)).append(".value.indexOf(\".\")!=-1 || ").append(formnamepath).append(".").append(values.get(key)).append(".value.indexOf(\",\")!=-1)  ) {\n").toString());
                sbuf.append((new StringBuilder()).append("\n ").append(formnamepath).append(".").append(values.get(key)).append(".value=").append(formnamepath).append(".").append(values.get(key)).append(".value.replace(\",\",\".\");\n").toString());
                sbuf.append((new StringBuilder()).append("var spl = ").append(formnamepath).append(".").append(values.get(key)).append(".value.split(\".\");\n").toString());
                sbuf.append("if (spl.length>2){\n");
                sbuf.append((new StringBuilder()).append("alert('").append(key).append("');\n").append(formnamepath).append(".").append(values.get(key)).append(".focus();\n return false;\n}\n}\n").toString());
                sbuf.append((new StringBuilder()).append("if ((").append(formnamepath).append(".").append(values.get(key)).append(".value!='' && ").append(formnamepath).append(".").append(values.get(key)).append(".disabled==false  && ").append(formnamepath).append(".").append(values.get(key)).append(".readOnly==false && !isNum(").append(formnamepath).append(".").append(values.get(key)).append(".value)) || (").append(formnamepath).append(".").append(values.get(key)).append("!='' && ").append(formnamepath).append(".").append(values.get(key)).append(".disabled==false && Number(").append(formnamepath).append(".").append(values.get(key)).append(".value)<0) ) {\n").toString());
            }

            sbuf.append("return true;\n}\n</script>");
            return sbuf.toString();
        } else
        {
            return "";
        }
    }
    
    
    public String getControlsNumericValuesHashtableZNulo(String formnamepath, Hashtable values)
    {
        StringBuffer sbuf = new StringBuffer();
        if(values.size() > 0)
        {
            sbuf.append("<script language='javascript' src='scripts/isNumeric.js'></script>\n");
            sbuf.append("<script language='javascript'>\n");
            sbuf.append("function number2() {\n");
            String key;
            for(Enumeration en = values.keys(); en.hasMoreElements(); sbuf.append((new StringBuilder()).append("alert('").append(key).append("');\n").append(formnamepath).append(".").append(values.get(key)).append(".focus();\n return false;\n}\n").toString()))
            {
                key = en.nextElement().toString();
                sbuf.append((new StringBuilder()).append("if (typeof(").append(formnamepath).append(".").append(values.get(key)).append(")!='undefined' && ").append(formnamepath).append(".").append(values.get(key)).append(".disabled==false  && ").append(formnamepath).append(".").append(values.get(key)).append(".readOnly==false && trim(").append(formnamepath).append(".").append(values.get(key)).append(".value)!=''  && (").append(formnamepath).append(".").append(values.get(key)).append(".value.indexOf(\".\")!=-1 || ").append(formnamepath).append(".").append(values.get(key)).append(".value.indexOf(\",\")!=-1)  ) {\n").toString());
                sbuf.append((new StringBuilder()).append("\n ").append(formnamepath).append(".").append(values.get(key)).append(".value=").append(formnamepath).append(".").append(values.get(key)).append(".value.replace(\",\",\".\");\n").toString());
                sbuf.append((new StringBuilder()).append("var spl = ").append(formnamepath).append(".").append(values.get(key)).append(".value.split(\".\");\n").toString());
                sbuf.append("if (spl.length>2){\n");
                sbuf.append((new StringBuilder()).append("alert('").append(key).append("');\n").append(formnamepath).append(".").append(values.get(key)).append(".focus();\n return false;\n}\n}\n").toString());
                sbuf.append((new StringBuilder()).append("if ((").append(formnamepath).append(".").append(values.get(key)).append(".value!='' && ").append(formnamepath).append(".").append(values.get(key)).append(".disabled==false  && ").append(formnamepath).append(".").append(values.get(key)).append(".readOnly==false && !isNumViaNic(").append(formnamepath).append(".").append(values.get(key)).append(".value)) || (").append(formnamepath).append(".").append(values.get(key)).append("!='' && ").append(formnamepath).append(".").append(values.get(key)).append(".disabled==false && Number(").append(formnamepath).append(".").append(values.get(key)).append(".value)<0) ) {\n").toString());
            }

            sbuf.append("return true;\n}\n</script>");
            return sbuf.toString();
        } else
        {
            return "";
        }
    }

    public String getControlsDateValuesHashtable(String formnamepath, Hashtable values)
    {
        StringBuffer sbuf = new StringBuffer();
        if(values.size() > 0)
        {
            sbuf.append("<script language='javascript' src='scripts/isNumeric.js'></script>\n");
            sbuf.append("<script language='javascript'>\n");
            sbuf.append("function datee() {\n");
            for(Enumeration en = values.keys(); en.hasMoreElements(); sbuf.append("}\n"))
            {
                String key = en.nextElement().toString();
                sbuf.append((new StringBuilder()).append("if (typeof(").append(formnamepath).append(".").append(values.get(key)).append(")!='undefined' && ").append(formnamepath).append(".").append(values.get(key)).append(".disabled==false  && ").append(formnamepath).append(".").append(values.get(key)).append(".readOnly==false && ").append(formnamepath).append(".").append(values.get(key)).append(".value!='' && !checkdatum(").append(formnamepath).append(".").append(values.get(key)).append(".value) ) {\n").toString());
                sbuf.append((new StringBuilder()).append("alert('").append(key).append("');\n").append(formnamepath).append(".").append(values.get(key)).append(".focus();\n return false;\n}\n").toString());
                sbuf.append((new StringBuilder()).append("if (typeof(").append(formnamepath).append(".").append(values.get(key)).append("_U)!='undefined') {\n").toString());
                sbuf.append((new StringBuilder()).append("ev = ").append(formnamepath).append(".").append(values.get(key)).append("_U; \n").toString());
                sbuf.append("if (ev.value.length>5 || ev.value.indexOf(\":\")==-1) {\n");
                sbuf.append((new StringBuilder()).append("alert(\"").append(key).append("\");\n").append(formnamepath).append(".").append(values.get(key)).append(".focus();\n").toString());
                sbuf.append("return false;\n");
                sbuf.append("}\n");
                sbuf.append("emo = ev.value.substring(0,2);\n");
                sbuf.append("evo = ev.value.substring(3,5); \n");
                sbuf.append("if ( emo=='00') {\n");
                sbuf.append("emo = 1;\n");
                sbuf.append("}\n");
                sbuf.append("if ( evo=='00') {\n");
                sbuf.append("evo = 1;\n");
                sbuf.append("}\n");
                sbuf.append("if ( Number(emo)>24 || Number(evo)>59 || !isNum(emo) || !isNum(evo)) {\n");
                sbuf.append((new StringBuilder()).append("alert(\"").append(key).append("\");\n").append(formnamepath).append(".").append(values.get(key)).append(".focus();\n").toString());
                sbuf.append("return false;\n");
                sbuf.append("}\n");
            }

            sbuf.append("return true;\n}\n</script>");
            return sbuf.toString();
        } else
        {
            return "";
        }
    }

    public String getReuiredValuesSizeHashtable(String formnamepath, Hashtable values)
    {
        StringBuffer sbuf = new StringBuffer();
        if(values.size() > 0)
        {
            sbuf.append("<script language='javascript'></script>\n");
            sbuf.append("<script language='javascript'>\n");
            sbuf.append("function size() {\n");
            String key;
            String str[];
            for(Enumeration en = values.keys(); en.hasMoreElements(); sbuf.append((new StringBuilder()).append("alert('").append(key).append("").append(str[0]).append("');\n").append(formnamepath).append(".").append(values.get(key)).append(".focus();\n return false;\n}\n").toString()))
            {
                key = en.nextElement().toString();
                str = (String[])(String[])values.get(key);
                sbuf.append((new StringBuilder()).append("if (").append(formnamepath).append(".").append(str[1]).append(".value.length>").append(str[0]).append(" ) {\n").toString());
            }

            sbuf.append("return true;\n}\n</script>");
            return sbuf.toString();
        } else
        {
            return "";
        }
    }


}
