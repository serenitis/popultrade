package com.popultrade.webapp;

import javax.imageio.ImageIO;
import javax.imageio.ImageWriter;
import javax.imageio.ImageWriteParam;
import javax.imageio.IIOImage;
import javax.imageio.stream.FileImageOutputStream;
import javax.swing.ImageIcon;

import java.awt.image.BufferedImage;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.geom.Rectangle2D;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.File; 
import java.util.Iterator;

/**
 * Java2D Bicubic image resize example
 */


/* ---- za cropat
 *       int top = Integer.valueOf(req.getParameter("t")).intValue();
        int left = Integer.valueOf(req.getParameter("l")).intValue();
        int width = Integer.valueOf(req.getParameter("w")).intValue();
        int height = Integer.valueOf(req.getParameter("h")).intValue();
        String imagePath = getServletContext().getRealPath("") + System.getProperty("file.separator")  + req.getParameter("i");
        
        BufferedImage outImage = ImageIO.read(new File(imagePath));
        BufferedImage cropped = outImage.getSubimage(left, top, width, height);
        
        ByteArrayOutputStream croppedOut = new ByteArrayOutputStream();
        ImageIO.write(cropped, req.getParameter("f"), croppedOut);
        
        resp.setContentType("image/" + (req.getParameter("f").equals("jpg") ? "jpeg": req.getParameter("f")));
        
        ServletOutputStream out = resp.getOutputStream();
        out.write(croppedOut.toByteArray());
        out.flush();
        out.close();
 * 
 */

public class ImageResize implements java.io.Serializable  {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1890909878667457456L;




	public  void resize(String inputimage,String outputimage,int width,int height) {
        try {
            BufferedImage source = ImageIO.read(new File(inputimage));
          
            BufferedImage resized = resize(source,width,height,RenderingHints.VALUE_INTERPOLATION_BICUBIC);
            
            writeJPEG(resized,outputimage);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    
    public  void resize(String inputimage,String outputimage,int width) {
        try {
            BufferedImage source = ImageIO.read(new File(inputimage));
          
            int wid = source.getWidth();
            
            /// wid = 100%
            /// width = x
            
            int proc = (width*100)/(wid*100);
            
            
            
            BufferedImage resized = resize(source,width,0,RenderingHints.VALUE_INTERPOLATION_BICUBIC);
            
            writeJPEG(resized,outputimage);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    
    
    
    public  BufferedImage resizeHeight(BufferedImage source, int destWidth, int destHeight, Object interpolation) {
        if (source == null)
            throw new NullPointerException("source image is NULL!");
        if (destWidth <= 0 && destHeight <= 0)
            throw new IllegalArgumentException("destination width & height are both <=0!");
        int sourceWidth = source.getWidth();
        int sourceHeight = source.getHeight();
        double xScale = ((double) destWidth) / (double) sourceWidth;
        double yScale = ((double) destHeight) / (double) sourceHeight;
        if (destWidth <= 0) {
            xScale = yScale;
            destWidth = (int) Math.rint(xScale * sourceWidth);
        }
        if (destHeight <= 0) {
            yScale = xScale;
            destHeight = (int) Math.rint(yScale * sourceHeight);
        }
        GraphicsConfiguration gc = getDefaultConfiguration();
        BufferedImage result = gc.createCompatibleImage(destWidth, destHeight, source.getColorModel().getTransparency());
        Graphics2D g2d = null;
        try {
            g2d = result.createGraphics();
            g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, interpolation);
            AffineTransform at =
                    AffineTransform.getScaleInstance(xScale, yScale);
            g2d.drawRenderedImage(source, at);
        } finally {
            if (g2d != null)
                g2d.dispose();
        }
        return result;
    }
    
    
    
    
    
    
    
    

    public  BufferedImage resize(BufferedImage source, int destWidth, int destHeight, Object interpolation) {
        if (source == null)
            throw new NullPointerException("source image is NULL!");
        if (destWidth <= 0 && destHeight <= 0)
            throw new IllegalArgumentException("destination width & height are both <=0!");
        int sourceWidth = source.getWidth();
        int sourceHeight = source.getHeight();
        double xScale = ((double) destWidth) / (double) sourceWidth;
        double yScale = ((double) destHeight) / (double) sourceHeight;
        if (destWidth <= 0) {
            xScale = yScale;
            destWidth = (int) Math.rint(xScale * sourceWidth);
        } 
        if (destHeight <= 0) {
            yScale = xScale;
            destHeight = (int) Math.rint(yScale * sourceHeight);
        }
        GraphicsConfiguration gc = getDefaultConfiguration();
        BufferedImage result = gc.createCompatibleImage(destWidth, destHeight, source.getColorModel().getTransparency());
        Graphics2D g2d = null;
        try {
            g2d = result.createGraphics();
            g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, interpolation);
            AffineTransform at =
                    AffineTransform.getScaleInstance(xScale, yScale);
            g2d.drawRenderedImage(source, at);
        } finally {
            if (g2d != null)
                g2d.dispose();
        }
        return result;
    }

    public  GraphicsConfiguration getDefaultConfiguration() {
        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        GraphicsDevice gd = ge.getDefaultScreenDevice();
        return gd.getDefaultConfiguration();
    }


    public  void writeJPEG(BufferedImage input, String name) throws IOException {
        Iterator iter =
                ImageIO.getImageWritersByFormatName("JPG");
        if (iter.hasNext()) {
            ImageWriter writer = (ImageWriter) iter.next();
            ImageWriteParam iwp =
                    writer.getDefaultWriteParam();
            iwp.setCompressionMode(
                    ImageWriteParam.MODE_EXPLICIT);
            iwp.setCompressionQuality(0.95f);
            File outFile = new File(name);
            FileImageOutputStream output =
                    new FileImageOutputStream(outFile);
            writer.setOutput(output);
            IIOImage image =
                    new IIOImage(input, null, null);
            writer.write(null, image, iwp);
            output.close();
        }
    }
    
    
    public boolean cropImage(String imagePath,int t,int l,int w,int h,String imagetype,String fileout) {
    	 int top = t;
         int left = l;
         int width = w;
         int height = h;
        try {
         BufferedImage outImage = ImageIO.read(new File(imagePath));
         BufferedImage cropped = outImage.getSubimage(left, top, width, height);
         
         //ByteArrayOutputStream croppedOut = new ByteArrayOutputStream();
         ImageIO.write(cropped, imagetype, new File(fileout));
         
         
         
        }
        catch (Exception ex) {
        	System.out.println("Napaka pri cropanju slike :"+ex.toString());
        	return  false;
        }
         return true;
         //resp.setContentType("image/" + (imagetype.equals("jpg") ? "jpeg": imagetype));
         
         //ServletOutputStream out = resp.getOutputStream();
         //out.write(croppedOut.toByteArray());
         //out.flush();
         //out.close();
    }
    
    
    
    /////////////////////////////
    ////////// dodam watermark
    /////////////////////////////
    
    public boolean addWatermark(String filename,String watermarko,int font_size,int watermark_x,int watermark_y,String logo,int logo_x,int logo_y,int logo_w,int logo_h,String output) {
        try
        {
            File file = new File(filename);
            if (!file.exists())
            {
                
                return false;
            }

            ImageIcon photo = new ImageIcon(filename);

            ImageIcon logoo = new ImageIcon(logo);
       //     BufferedImage bufferedImageLogo = new BufferedImage(logoo.getIconWidth(),
             //       logoo.getIconHeight(),
            //        BufferedImage.TYPE_INT_RGB);
            
          
            
            //Create an image 200 x 200
            BufferedImage bufferedImage = new BufferedImage(photo.getIconWidth(),
                    photo.getIconHeight(),
                    BufferedImage.TYPE_INT_RGB);
            
            System.out.println(photo.getIconWidth() + " width image ");
            System.out.println(photo.getIconHeight() + " height image ");
            
            
            /// zracunam procente vecave oz manjsanja
            
            /// 500 = x
            /// photo.getIconWidth() = 100
            /// 50000/photo.getIconWidth() = x
            /// 
            /// watermark_x = x
            /// xx  = 100
            
            /// xx = watermark_x*100/x
            
            
            int x = 50000/photo.getIconWidth();
            int xx = watermark_x*100/x;
            
            System.out.println("pravi x: "+xx);
            
            
            int yy = watermark_y*100/x;
            
            System.out.println("pravi y: "+yy);
            int xxx=0;
            int yyy=0;
            if (!logo.equals("")) {
            xxx = logo_x*100/x;
            yyy = logo_y*100/x;
            
            xxx = xxx + (logo_w*100/x)-logo_w-(logo_w/2);
            yyy = yyy + (logo_h*100/x)-logo_h-(logo_h/2);
            
            }
            
            Graphics2D g2d = (Graphics2D) bufferedImage.getGraphics();

            g2d.drawImage(photo.getImage(), 0, 0, null);

            //Create an alpha composite of 50%
            AlphaComposite alpha = AlphaComposite.getInstance(AlphaComposite.SRC_OVER,0.5f);
            g2d.setComposite(alpha);

            g2d.setColor(Color.white);
            g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
                                 RenderingHints.VALUE_TEXT_ANTIALIAS_ON);

            g2d.setFont(new Font("Verdana", Font.BOLD, (font_size*10)));
            
            
            if (!logo.equals("")) {
            g2d.drawImage(logoo.getImage(), xxx, yyy, logo_w, 
            		logo_h, null);
            }
            

            String watermark = watermarko;

            FontMetrics fontMetrics = g2d.getFontMetrics();
            Rectangle2D rect = fontMetrics.getStringBounds(watermark, g2d);

            g2d.drawString(watermark,
                            xx,
                            		yy);
            
            //g2d.dr

            //Free graphic resources
            g2d.dispose();

            //Set the mime type of the image
            //res.setContentType("image/jpg");
File out = new File(output);
            //Write the image as a jpg
            //OutputStream out = res.getOutputStream();
            ImageIO.write(bufferedImage, "jpg", out);
           // out.close();
        }
        catch (IOException ioe){
        System.out.println("Napaka pri dodajanju watermarka: "+ioe.toString());
        return false;
        }
        return true;
    }
    
    
    
    
    public boolean addWatermark(String filename,String logo) {
        try
        {
            File file = new File(filename);
            if (!file.exists())
            {

                return false; 
            }

            ImageIcon photo = new ImageIcon(filename);

            ImageIcon logoo = new ImageIcon(logo);
       //     BufferedImage bufferedImageLogo = new BufferedImage(logoo.getIconWidth(),
             //       logoo.getIconHeight(),
            //        BufferedImage.TYPE_INT_RGB);



            //Create an image 200 x 200
            BufferedImage bufferedImage = new BufferedImage(photo.getIconWidth(),
                    photo.getIconHeight(),
                    BufferedImage.TYPE_INT_RGB);

            System.out.println(photo.getIconWidth() + " width image ");
            System.out.println(photo.getIconHeight() + " height image ");


            /// zracunam procente vecave oz manjsanja

            /// 500 = x
            /// photo.getIconWidth() = 100
            /// 50000/photo.getIconWidth() = x
            ///
            /// watermark_x = x
            /// xx  = 100

            /// xx = watermark_x*100/x

            
            int xf = 50000/photo.getIconWidth();
            int xx = 25*100/xf;
            
            System.out.println("pravi x: "+xx);
            
            
            int yy = (25*100/xf)+10;
            
            System.out.println("pravi y: "+yy);

            double x = photo.getIconWidth()*0.2;
            double y = photo.getIconHeight()*0.2;

           double xxx=0;
            double yyy=0;

            xxx = photo.getIconWidth()-x;
            yyy = photo.getIconHeight()-y;
 


            Graphics2D g2d = (Graphics2D) bufferedImage.getGraphics();

            g2d.drawImage(photo.getImage(), 0, 0, null);

            //Create an alpha composite of 50%
            AlphaComposite alpha = AlphaComposite.getInstance(AlphaComposite.SRC_OVER,0.2f);
            g2d.setComposite(alpha);
            
            g2d.setColor(Color.white);
            g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
                                 RenderingHints.VALUE_TEXT_ANTIALIAS_ON);

           // g2d.setFont(new Font("Verdana", Font.BOLD, (2*10)));
            
            

            //// visino na podlagi \velikosti watermarka

            /// logoo.getIconWidth() = 100
            /// sirina = xx

            double xxm =(x/ logoo.getIconWidth())/2;


            if (!logo.equals("")) {
            g2d.drawImage(logoo.getImage(), (int)xxx, (int)yyy, ((int)x)/2,
                        (int)(logoo.getIconHeight()*xxm), null);
            }

            //g2d.dr
            

           // FontMetrics fontMetrics = g2d.getFontMetrics();
           // Rectangle2D rect = fontMetrics.getStringBounds(user_id, g2d);

           // g2d.drawString(user_id,
             //               xx,
               //             		yy);
            
            //Free graphic resources
            g2d.dispose();

            //Set the mime type of the image
            //res.setContentType("image/jpg");
File out = new File(filename);
            //Write the image as a jpg
            //OutputStream out = res.getOutputStream();
            ImageIO.write(bufferedImage, "jpg", out);
           // out.close();
        }
        catch (IOException ioe){
        System.out.println("Napaka pri dodajanju watermarka: "+ioe.toString());
        return false;
        }
        return true;
    }

    
    
    
    
    
    
    

}  

