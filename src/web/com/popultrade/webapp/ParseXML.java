package com.popultrade.webapp;


import java.io.File;
import java.io.FileReader;
import java.io.InputStream;

import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;



public class ParseXML {


private  int zaporedjee = 15;
	private   com.popultrade.dao.TemplateXmlDAO daog =null; //(com.popultrade.dao.TemplateXmlDAO)contextUtil.getBeanDao("templateXmlDAO",servletcontext);
	private   com.popultrade.dao.TemplateAttributeDAO daoga =null; 
	private  Long id_conversion;
	
	private boolean preberiVseTage(InputStream xml_file,ContextUtil contextUtil,ServletContext servletcontext) throws Exception {
		
		
		DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory
		        .newInstance();
		    DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
		    Document document = docBuilder.parse(xml_file);
System.out.println(document.getDocumentElement().getNodeName());

//// zapisem v bazo prvega
daog = (com.popultrade.dao.TemplateXmlDAO)contextUtil.getBeanDao("templateXmlDAO",servletcontext);
daoga = (com.popultrade.dao.TemplateAttributeDAO)contextUtil.getBeanDao("templateAttributeDAO",servletcontext); 




		    dodelajNode(document.getDocumentElement(),"-",contextUtil,servletcontext,new Long("0"),document.getDocumentElement().getNodeName(),true);
		    
		    
		
		
		return true;
	}
	

	private  void dodelajNode(Node node,String veja,ContextUtil contextUtil,ServletContext servletcontext,Long id_nad,String path,boolean prvi) {
	    // do something with the current node instead of System.out
	 //   System.out.println(node.getNodeName());
		com.popultrade.model.TemplateXml vsebgg =new com.popultrade.model.TemplateXml();
		NodeList nodeList = node.getChildNodes();
		if (!prvi) {
		zaporedjee+=20;

	//	com.popultrade.model.TemplateXml vsebgg =new com.popultrade.model.TemplateXml();
		vsebgg.setDescription("Element: "+node.getNodeName());
		vsebgg.setPath(path +"/" +node.getNodeName());
		vsebgg.setTag_name(node.getNodeName());
		vsebgg.setId_nad(id_nad);
		vsebgg.setId_conversion(id_conversion);
		vsebgg.setZaporedje(zaporedjee);
		
		if (nodeList.getLength()==0) {
			vsebgg.setType("1"); 
		}
		
		daog.saveTemplateXml(vsebgg);
		path =path+"/"+ node.getNodeName();
		
		
		
		
		}
		else {
			
			//// prvi element, ima id_nad null in id_conversion ima vrednost

			vsebgg.setDescription("Root");
			vsebgg.setPath(node.getNodeName());
			vsebgg.setTag_name(node.getNodeName());
			vsebgg.setZaporedje(15);
			vsebgg.setId_conversion(id_conversion);

			daog.saveTemplateXml(vsebgg);
			id_nad = vsebgg.getId();
			path = node.getNodeName();
		}
		
		
		
	 	if (node.getAttributes().getLength()>0) {
    		
        	NamedNodeMap nnm=	node.getAttributes();
        	int zapok = 5;
        	for (int ii=0;ii<nnm.getLength();ii++) {
        		
        		Node noat = (Node)nnm.item(ii);
        		
        		if (noat!=null) {
        			System.out.println(" N:"+ noat.getNodeName());
        			
        			/// attributes
        			com.popultrade.model.TemplateAttribute vsa =new com.popultrade.model.TemplateAttribute();
        			vsa.setDescription("Attribute: "+noat.getNodeName());
        			vsa.setPath(path +"/@" +noat.getNodeName());
        			vsa.setTag_name(noat.getNodeName());
        			vsa.setId_nad(vsebgg.getId());
        			vsa.setZaporedje(zapok);
        			daoga.saveTemplateAttribute(vsa);
        			zapok +=5;
        			
        		}
        		
        	}

        	}
        	else {
        		System.out.println();
        	}
		
		
		
		
		
	    
	    for (int i = 0; i < nodeList.getLength(); i++) {
	        Node currentNode = nodeList.item(i);
	        if (currentNode.getNodeType() == Node.ELEMENT_NODE) {
	            //calls this method for all the children which is Element
	        	
	        	System.out.print(veja+currentNode.getNodeName());
	        	
	       
	        	 
	        	dodelajNode(currentNode,veja+"-",contextUtil,servletcontext,vsebgg.getId(),path,false);
	        	
	        	
	        	
	        }
	    }
	}
	
	
	
	
	
	
	/// dobim path id templatexml tabele
	
	public String getPathFromIdTag(Long id,ContextUtil contextUtil,ServletContext servletcontext) throws Exception {
		
		String rett= "";
		daog = (com.popultrade.dao.TemplateXmlDAO)contextUtil.getBeanDao("templateXmlDAO",servletcontext);
		
		
		com.popultrade.model.TemplateXml temx = daog.getTemplateXml(id);
		
		
		if (temx.getId_nad()!=null) {
			String ret = getPathFromIdTag(temx.getId_nad(),contextUtil,servletcontext);
			System.out.println("ICSEM "+temx.getId_nad());
			if (!ret.equals("")) {
			rett =ret + "/"+temx.getTag_name() ;
			}
			
		}
		else {
			rett= temx.getTag_name();
		}

		return rett;
	}
	
	
	/// dobim path id templatexml tabele
	
	public String getPathFromIdAttribute(Long id,ContextUtil contextUtil,ServletContext servletcontext) throws Exception {
		
		String rett= "";
		com.popultrade.dao.TemplateAttributeDAO daox = (com.popultrade.dao.TemplateAttributeDAO)contextUtil.getBeanDao("templateAttributeDAO",servletcontext);
		
		
		com.popultrade.model.TemplateAttribute temx = daox.getTemplateAttribute(id);
		
		
		if (temx.getId_nad()!=null) {
			String ret = getPathFromIdTag(temx.getId_nad(),contextUtil,servletcontext);
			System.out.println("ICSEM "+temx.getId_nad());
			if (!ret.equals("")) {
			rett =ret + "/"+temx.getTag_name() ;
			}
			
		}
		else {
			rett= temx.getTag_name();
		}

		return rett;
	}
	
	

	
	
	public boolean getXMLStructure(InputStream xml_file,ContextUtil contextUtil,ServletContext servletcontext,Long id_conversion) {
		// TODO Auto-generated method stub
System.out.println("Ciao");
this.id_conversion=id_conversion;

try {
	this.preberiVseTage(xml_file,contextUtil,servletcontext);
} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	return false;
}
return true;

	}

}
