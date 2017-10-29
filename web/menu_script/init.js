function init(){
if(!window.standards) return;
if(window.inited) return;
//////////////////////////////////  GLOBAL OFFSET VARIABLES //////////////////////////////	
	if(bw.wIE || bw.ns){
		menuOffsetTop = 3; // first level menu. smaller number is more up
		menuOffsetLeft = 2; // first level menu. smaller number is more right.
	}
	else if(bw.mIE){
		menuOffsetTop = -1; // first level menu. smaller number is more right
		menuOffsetLeft = -6; // first level menu. smaller number is more right
	}
	submenuOffsetTop = -14 ;// smaller number is closer to top

	if(bw.wIE) submenuOffsetLeft = -12; // left-side menu. smaller number is closer to menu
	else if(bw.mIE) submenuOffsetLeft = -4; // left-side menu. smaller number is closer to menu

	submenuOffsetRight = 0;// right-side menu.  smaller number is closer to menu.
//////////////////////////////////  GLOBAL OFFSET VARIABLES //////////////////////////////	


	var uiMenubar = new Menubar();

	var stbMenu = new Menu('SimplytheBest');
	uiMenubar.add(stbMenu);
	stbMenu.add(new MenuItem('Main index','http://simplythebest.net'));
	stbMenu.add(new MenuItem('Affiliate programs','http://simplythebest.net/affiliates/'));
	stbMenu.add(new MenuItem('CGI scripts','http://simplythebest.net/scripts/perl_scripts/'));
	stbMenu.add(new MenuItem('Device drivers','http://simplythebest.net/drivers/drivers.html'));

	stbMenu.addSeparator("#000388");
	stbDHTMLMenu = new Menu('DHTML scripts');
	stbDHTMLMenu.add(new MenuItem('Main index','http://simplythebest.net/scripts/DHTML_scripts/'));
	stbDHTMLMenu.add(new MenuItem('Animation','http://simplythebest.net/scripts/DHTML_scripts/dhtml_animation.html'));
	stbDHTMLMenu.add(new MenuItem('Background scripts','http://simplythebest.net/scripts/DHTML_scripts/dhtml_background.html'));
	stbDHTMLMenu.add(new MenuItem('Buttons','http://simplythebest.net/scripts/DHTML_scripts/dhtml_buttons.html'));
	stbDHTMLMenu.add(new MenuItem('Calculators','http://simplythebest.net/scripts/DHTML_scripts/dhtml_calculators.html'));
	stbDHTMLMenu.add(new MenuItem('E-mail scripts','http://simplythebest.net/scripts/DHTML_scripts/dhtml_email.html'));
	stbDHTMLMenu.add(new MenuItem('Enhancements','http://simplythebest.net/scripts/DHTML_scripts/dhtml_enhancements.html'));
	stbDHTMLMenu.add(new MenuItem('Forms','http://simplythebest.net/scripts/DHTML_scripts/dhtml_forms.html'));
	stbDHTMLMenu.add(new MenuItem('Image rotations','http://simplythebest.net/scripts/DHTML_scripts/dhtml_images.html'));
	stbDHTMLMenu.add(new MenuItem('Menus','http://simplythebest.net/scripts/DHTML_scripts/dhtml_menu_scripts.html'));
	stbDHTMLMenu.add(new MenuItem('Messages','http://simplythebest.net/scripts/DHTML_scripts/dhtml_messages.html'));
	stbDHTMLMenu.add(new MenuItem('Password protection','http://simplythebest.net/scripts/DHTML_scripts/dhtml_passwords.html'));
	stbDHTMLMenu.add(new MenuItem('Scrollers','http://simplythebest.net/scripts/DHTML_scripts/dhtml_scroller_scripts.html'));
	stbMenu.add(stbDHTMLMenu);
	stbMenu.addSeparator("#000388");

	stbMenu.add(new MenuItem("Free fonts",'http://simplythebest.net/fonts/'));
	stbMenu.add(new MenuItem("Hosting providers",'http://simplythebest.net/hosting/'));
	stbMenu.add(new MenuItem("Information library",'http://simplythebest.net/info/'));
	stbMenu.add(new MenuItem("Music directory",'http://simplythebest.net/music/'));
	stbMenu.add(new MenuItem("Shareware",'http://simplythebest.net/shareware/'));
	stbMenu.add(new MenuItem("Shopping",'http://simplythebest.net/shop/'));
	stbMenu.add(new MenuItem("Metasearch",'http://simplythebest.net/search/'));

	uiMenubar.add(plmMenu = new Menu('PlanMagic'));
	plmMenu.add(new MenuItem('Main business page','http://planmagic.com'));
	
	plmMenu.addSeparator("#000388");
	plmProdMenu = new Menu('Business software');
	plmProdMenu.help="Windows, Menus, Tabs, Scrollers";//appears in statusbar

	plmProdMenu.add(new MenuItem('Business plan','http://planmagic.com/business_planning.html'));
	plmProdMenu.add(new MenuItem('Marketing plan','http://planmagic.com/marketing_planning.html'));
	plmProdMenu.add(new MenuItem('Financial plan','http://planmagic.com/finance.html'));
	plmProdMenu.add(new MenuItem('Web marketing plan','http://planmagic.com/webquest.html'));
	plmProdMenu.add(new MenuItem('Restaurant plan','http://plan-a-restaurant.com'));
	plmMenu.add(plmProdMenu);
	plmMenu.addSeparator("#000388");
	
	plmMenu.add(new MenuItem('Download page','http://planmagic.com/download.html'));
	plmMenu.add(new MenuItem('Register','http://planmagic.com/register.html'));
	plmMenu.add(new MenuItem('Contact us','http://planmagic.com/contact.html'));	

	webMenu = new Menu('Web Designs');
	webMenu.add(new MenuItem('Main index','http://simplythebest.net/web_builder/'));
	webMenu.add(new MenuItem('Design','http://simplythebest.net/web_builder/design.htm'));
	webMenu.add(new MenuItem('Marketing','http://simplythebest.net/web_builder/marketing.htm'));
	webMenu.add(new MenuItem('Promotion','http://simplythebest.net/web_builder/promotion.htm'));
	webMenu.add(new MenuItem('E-commerce','http://simplythebest.net/web_builder/ecommerce.htm'));
	webMenu.add(new MenuItem('Programming','http://simplythebest.net/web_builder/programming.htm'));
	webMenu.add(new MenuItem('Portfolio','http://simplythebest.net/web_builder/portfolio.htm'));
	uiMenubar.add(webMenu);

	wqpMenu = new Menu('WebQuestPro');
	wqpMenu.add(new MenuItem('Web marketing plan','http://webquestpro.com/web_marketing.html'));
	wqpMenu.add(new MenuItem('Targeted design','http://webquestpro.com/mdesign.htm'));
	wqpMenu.add(new MenuItem('Online marketing','http://webquestpro.com/mmarketing.htm'));
	wqpMenu.add(new MenuItem('Online success','http://webquestpro.com/msuccess.htm'));
	uiMenubar.add(wqpMenu);
	uiMenubar.useMouseOver();
	document.body.appendChild(uiMenubar);
	
	// setWidth method added april 2, 2002.
	uiMenubar.setWidth("auto",0);
	
	window.inited = true;
}