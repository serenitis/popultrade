package com.popultrade.webapp;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.PrintStream;

import org.apache.tools.ant.BuildEvent;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.BuildListener;
import org.apache.tools.ant.DefaultLogger;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.ProjectHelper;
  
/**
 * @author srccodes.com
 * @version 1.0
 */
public class AntExecutor {

     
    /**
     * To execute a target specified in the Ant build.xml file
     * 
     * @param buildXmlFileFullPath
     * @param target
     */
    public  String executeAntTask(String buildXmlFileFullPath, String target,control con) {
       // boolean success = false;
    	
      	ByteArrayOutputStream os = new ByteArrayOutputStream();
    	PrintStream ps = new PrintStream(os);
    	
    	 
    	
        DefaultLogger consoleLogger = getConsoleLogger(ps);
 AntListener antl = new AntListener(9);
        // Prepare Ant project
        Project project = new Project();
        File buildFile = new File(buildXmlFileFullPath);
        project.setUserProperty("ant.file", con.ant_home);
        System.setProperty("JAVA.HOME", "C:/Program Files (x86)/Java/jdk1.7.0_09");
        project.setProperty("JAVA_HOME", "C:/Program Files (x86)/Java/jdk1.7.0_09");
        String output="";
        
       project.addBuildListener(consoleLogger);
 
        // Capture event for Ant script build start / stop / failure
        try {
            project.fireBuildStarted();
            project.init();
            ProjectHelper projectHelper = ProjectHelper.getProjectHelper();
            project.addReference("ant.projectHelper", projectHelper);
            projectHelper.parse(project, buildFile);
             
            // If no target specified then default target will be executed.
            String targetToExecute = (target != null && target.trim().length() > 0) ? target.trim() : project.getDefaultTarget();
            project.executeTarget(targetToExecute);
            project.fireBuildFinished(null);
            
            System.out.println("--------------------- 1");
             output = os.toString("UTF8");
            os.close();
            
            System.out.println(output);
            System.out.println("---------------------2");
           // success = true;
        } catch (Exception buildException) {
            project.fireBuildFinished(buildException);
            
            System.out.println("Ant build napaka: "+buildException.toString());
            
            throw new RuntimeException("!!! Unable to restart the IEHS App !!!", buildException);
        }
         
        return output;
    }
     
    /**
     * Logger to log output generated while executing ant script in console
     * 
     * @return
     */
    private  DefaultLogger getConsoleLogger(PrintStream pss) {
    	
  
    	
        DefaultLogger consoleLogger = new DefaultLogger();
        consoleLogger.setErrorPrintStream(pss);
        consoleLogger.setOutputPrintStream(pss);
        consoleLogger.setMessageOutputLevel(Project.MSG_INFO);
         
        return consoleLogger;
    }
     
    /**
     * Main method to test code
     * 
     * @param args
     */
    public String executeAnt(control con) {
        // Running default target of ant script
     //   executeAntTask(con.ant_build_file);
 
        System.out.println("-----------------------------");
         
        // Running specified target of ant script
        String rezu = executeAntTask(con.ant_build_file, "compile",con);
        
        return rezu;
        
    }
 
}














