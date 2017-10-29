package com.popultrade.webapp;



	import javax.servlet.*;
	import javax.servlet.http.*;

import org.krysalis.barcode4j.impl.code128.Code128Bean;
import org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider;
import org.krysalis.barcode4j.tools.UnitConv;


	import java.io.*;
	import java.awt.Graphics2D.*;
import java.awt.image.BufferedImage;
import java.awt.*;
	//import com..linear.BarCode;

	public class BarCodeGenerator { 
	        /**
	        * Handle the HTTP POST method by sending an e-mail
	        */
	       // private boolean debug=false;
	       // public void init() throws ServletException  {	}
	        // MODIFY THIS METHOD TO RETRIEVE DATA TO ENCODE, CREATE THE BARCODE AND SET THE PARAMETERS
	        public void getChart (HttpServletRequest request)
	        {
	        	
	        	try {
	        	
	        	//Create the barcode bean
	        	Code128Bean bean = new Code128Bean();

	        	final int dpi = 150;

	        	//Configure the barcode generator
	        	bean.setModuleWidth(UnitConv.in2mm(1.0f / dpi)); //makes the narrow bar 
	        	                                                 //width exactly one pixel
	        //	bean.setWideFactor(3);
	        	bean.doQuietZone(false);

	        	//Open output file
	        	File outputFile = new File("out.png");
	        	OutputStream out = new FileOutputStream(outputFile);
	        	try {
	        	    //Set up the canvas provider for monochrome PNG output 
	        	    BitmapCanvasProvider canvas = new BitmapCanvasProvider(
	        	            out, "image/x-png", dpi, BufferedImage.TYPE_BYTE_BINARY, false, 0);

	        	    //Generate the barcode
	        	    bean.generateBarcode(canvas, "123456");

	        	    //Signal end of generation
	        	    canvas.finish();
	        	} finally {
	        	    out.close();
	        	}
	        	}
	        	catch (Exception ex) {
	        		System.out.println(ex.toString());
	        	}
	        	
	        }
	        
	}
	
	

