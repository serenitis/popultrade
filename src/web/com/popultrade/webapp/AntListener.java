package com.popultrade.webapp;

import org.apache.tools.ant.BuildEvent;
import org.apache.tools.ant.BuildListener;
import org.apache.tools.ant.Project;

public class AntListener implements BuildListener, java.io.Serializable  {
	    /**
	 * 
	 */
	private static final long serialVersionUID = 4346568709786543531L;
		private int logLevel;
	    public StringBuffer sb = new StringBuffer();
	    /**
	     * Constructs a test listener which will ignore log events
	     * above the given level.
	     */
	    public AntListener(int logLevel) {
	        this.logLevel = logLevel;
	    }

	    /**
	     * Fired before any targets are started.
	     */
	    public void buildStarted(BuildEvent event) {
	    }

	    /**
	     * Fired after the last target has finished. This event
	     * will still be thrown if an error occurred during the build.
	     *
	     * @see BuildEvent#getException()
	     */
	    public void buildFinished(BuildEvent event) {
	    }

	    /**
	     * Fired when a target is started.
	     *
	     * @see BuildEvent#getTarget()
	     */
	    public void targetStarted(BuildEvent event) {
	        //System.out.println("targetStarted " + event.getTarget().getName());
	    }

	    /**
	     * Fired when a target has finished. This event will
	     * still be thrown if an error occurred during the build.
	     *
	     * @see BuildEvent#getException()
	     */
	    public void targetFinished(BuildEvent event) {
	        //System.out.println("targetFinished " + event.getTarget().getName());
	    }

	    /**
	     * Fired when a task is started.
	     *
	     * @see BuildEvent#getTask()
	     */
	    public void taskStarted(BuildEvent event) {
	        //System.out.println("taskStarted " + event.getTask().getTaskName());
	    }

	    /**
	     * Fired when a task has finished. This event will still
	     * be throw if an error occurred during the build.
	     *
	     * @see BuildEvent#getException()
	     */
	    public void taskFinished(BuildEvent event) {
	        //System.out.println("taskFinished " + event.getTask().getTaskName());
	    }

	    /**
	     * Fired whenever a message is logged.
	     *
	     * @see BuildEvent#getMessage()
	     * @see BuildEvent#getPriority()
	     */
	    public void messageLogged(BuildEvent event) {
	        if (event.getPriority() > logLevel) {
	            // ignore event
	          //  return;
	        }

	        if (event.getPriority() == Project.MSG_INFO ||
	            event.getPriority() == Project.MSG_WARN ||
	            event.getPriority() == Project.MSG_ERR) {
	        //    logBuffer.append(event.getMessage());
	        }
	        
	        sb.append(event.getMessage()+"<br>\r\n");
	        
	      //  fullLogBuffer.append(event.getMessage());
	    }
	
}
