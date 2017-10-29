package com.popultrade;


/**
 * Constant values used throughout the application.
 *
 * <p>
 * <a href="Constants.java.html"><i>View Source</i></a>
 * </p>
 *
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 */
public class Constants {
    //~ Static fields/initializers =============================================
   
    /** The name of the ResourceBundle used in this application */
    public static final String BUNDLE_KEY = "ApplicationResources";

    /** The encryption algorithm key to be used for passwords */
    public static final String ENC_ALGORITHM = "algorithm";

    /** A flag to indicate if passwords should be encrypted */
    public static final String ENCRYPT_PASSWORD = "encryptPassword";

    /** File separator from System properties */
    public static final String FILE_SEP = System.getProperty("file.separator");

    /** User home from System properties */
    public static final String USER_HOME = System.getProperty("user.home") + FILE_SEP;

    /** The name of the configuration hashmap stored in application scope. */
    public static final String CONFIG = "appConfig";

    /** 
     * Session scope attribute that holds the locale set by the user. By setting this key
     * to the same one that Struts uses, we get synchronization in Struts w/o having
     * to do extra work or have two session-level variables.
     */ 
    public static final String PREFERRED_LOCALE_KEY = "org.apache.struts.action.LOCALE";
    
    /**
     * The request scope attribute under which an editable user form is stored
     */
    public static final String USER_KEY = "userForm";

    /**
     * The request scope attribute that holds the user list
     */
    public static final String USER_LIST = "userList";

    /**
     * The request scope attribute for indicating a newly-registered user
     */
    public static final String REGISTERED = "registered";

    /**
     * The name of the Administrator role, as specified in web.xml
     */
    public static final String ADMIN_ROLE = "admin";

    /**
     * The name of the User role, as specified in web.xml
     */
    public static final String USER_ROLE = "user";

    /**
     * The name of the user's role list, a request-scoped attribute
     * when adding/editing a user.
     */
    public static final String USER_ROLES = "userRoles";

    /**
     * The name of the available roles list, a request-scoped attribute
     * when adding/editing a user.
     */
    public static final String AVAILABLE_ROLES = "availableRoles";













//Users-START
    /**
     * The request scope attribute that holds the users form.
     */
    public static final String USERS_KEY = "usersForm";

    /**
     * The request scope attribute that holds the users list
     */
    public static final String USERS_LIST = "usersList";
//Users-END


//Linki-START
    /**
     * The request scope attribute that holds the linki form.
     */
    public static final String LINKI_KEY = "linkiForm";

    /**
     * The request scope attribute that holds the linki list
     */
    public static final String LINKI_LIST = "linkiList";
//Linki-END


//Novice-START
    /**
     * The request scope attribute that holds the novice form.
     */
    public static final String NOVICE_KEY = "noviceForm";

    /**
     * The request scope attribute that holds the novice list
     */
    public static final String NOVICE_LIST = "noviceList";
//Novice-END


//Uploads-START
    /**
     * The request scope attribute that holds the uploads form.
     */
    public static final String UPLOADS_KEY = "uploadsForm";

    /**
     * The request scope attribute that holds the uploads list
     */
    public static final String UPLOADS_LIST = "uploadsList";
//Uploads-END


//Players-START
    /**
     * The request scope attribute that holds the players form.
     */
    public static final String PLAYERS_KEY = "playersForm";

    /**
     * The request scope attribute that holds the players list
     */
    public static final String PLAYERS_LIST = "playersList";
//Players-END


//Matches-START
    /**
     * The request scope attribute that holds the matches form.
     */
    public static final String MATCHES_KEY = "matchesForm";

    /**
     * The request scope attribute that holds the matches list
     */
    public static final String MATCHES_LIST = "matchesList";
//Matches-END





//Classific-START
    /**
     * The request scope attribute that holds the classific form.
     */
    public static final String CLASSIFIC_KEY = "classificForm";

    /**
     * The request scope attribute that holds the classific list
     */
    public static final String CLASSIFIC_LIST = "classificList";
//Classific-END


//Galerija-START
    /**
     * The request scope attribute that holds the galerija form.
     */
    public static final String GALERIJA_KEY = "galerijaForm";

    /**
     * The request scope attribute that holds the galerija list
     */
    public static final String GALERIJA_LIST = "galerijaList";
//Galerija-END


//GlavnaStatistika-START
    /**
     * The request scope attribute that holds the glavnaStatistika form.
     */
    public static final String GLAVNASTATISTIKA_KEY = "glavnaStatistikaForm";

    /**
     * The request scope attribute that holds the glavnaStatistika list
     */
    public static final String GLAVNASTATISTIKA_LIST = "glavnaStatistikaList";
//GlavnaStatistika-END


//GlavnaStatistikaImena-START
    /**
     * The request scope attribute that holds the glavnaStatistikaImena form.
     */
    public static final String GLAVNASTATISTIKAIMENA_KEY = "glavnaStatistikaImenaForm";

    /**
     * The request scope attribute that holds the glavnaStatistikaImena list
     */
    public static final String GLAVNASTATISTIKAIMENA_LIST = "glavnaStatistikaImenaList";
//GlavnaStatistikaImena-END


//GlavnaStatistikaKategorije-START
    /**
     * The request scope attribute that holds the glavnaStatistikaKategorije form.
     */
    public static final String GLAVNASTATISTIKAKATEGORIJE_KEY = "glavnaStatistikaKategorijeForm";

    /**
     * The request scope attribute that holds the glavnaStatistikaKategorije list
     */
    public static final String GLAVNASTATISTIKAKATEGORIJE_LIST = "glavnaStatistikaKategorijeList";
//GlavnaStatistikaKategorije-END


//Galerija_slike-START
    /**
     * The request scope attribute that holds the galerija_slike form.
     */
    public static final String GALERIJA_SLIKE_KEY = "galerija_slikeForm";

    /**
     * The request scope attribute that holds the galerija_slike list
     */
    public static final String GALERIJA_SLIKE_LIST = "galerija_slikeList";
//Galerija_slike-END


//Teksti-START
    /**
     * The request scope attribute that holds the teksti form.
     */
    public static final String TEKSTI_KEY = "tekstiForm";

    /**
     * The request scope attribute that holds the teksti list
     */
    public static final String TEKSTI_LIST = "tekstiList";
//Teksti-END


//MatchesPlayers-START
    /**
     * The request scope attribute that holds the matchesPlayers form.
     */
    public static final String MATCHESPLAYERS_KEY = "matchesPlayersForm";

    /**
     * The request scope attribute that holds the matchesPlayers list
     */
    public static final String MATCHESPLAYERS_LIST = "matchesPlayersList";
//MatchesPlayers-END


//Sifranti-START
    /**
     * The request scope attribute that holds the sifranti form.
     */
    public static final String SIFRANTI_KEY = "sifrantiForm";

    /**
     * The request scope attribute that holds the sifranti list
     */
    public static final String SIFRANTI_LIST = "sifrantiList";
//Sifranti-END





//PlayersSezona-START
    /**
     * The request scope attribute that holds the playersSezona form.
     */
    public static final String PLAYERSSEZONA_KEY = "playersSezonaForm";

    /**
     * The request scope attribute that holds the playersSezona list
     */
    public static final String PLAYERSSEZONA_LIST = "playersSezonaList";
//PlayersSezona-END


//Galerija_video-START
    /**
     * The request scope attribute that holds the galerija_video form.
     */
    public static final String GALERIJA_VIDEO_KEY = "galerija_videoForm";

    /**
     * The request scope attribute that holds the galerija_video list
     */
    public static final String GALERIJA_VIDEO_LIST = "galerija_videoList";
//Galerija_video-END


//Sms-START
    /**
     * The request scope attribute that holds the sms form.
     */
    public static final String SMS_KEY = "smsForm";

    /**
     * The request scope attribute that holds the sms list
     */
    public static final String SMS_LIST = "smsList";
//Sms-END





//UsersPodjetja-START
    /**
     * The request scope attribute that holds the usersPodjetja form.
     */
    public static final String USERSPODJETJA_KEY = "usersPodjetjaForm";

    /**
     * The request scope attribute that holds the usersPodjetja list
     */
    public static final String USERSPODJETJA_LIST = "usersPodjetjaList";
//UsersPodjetja-END








//Podjetja-START
    /**
     * The request scope attribute that holds the podjetja form.
     */
    public static final String PODJETJA_KEY = "podjetjaForm";

    /**
     * The request scope attribute that holds the podjetja list
     */
    public static final String PODJETJA_LIST = "podjetjaList";
//Podjetja-END


//Language-START
    /**
     * The request scope attribute that holds the language form.
     */
    public static final String LANGUAGE_KEY = "languageForm";

    /**
     * The request scope attribute that holds the language list
     */
    public static final String LANGUAGE_LIST = "languageList";
//Language-END


//Jeziki-START
    /**
     * The request scope attribute that holds the jeziki form.
     */
    public static final String JEZIKI_KEY = "jezikiForm";

    /**
     * The request scope attribute that holds the jeziki list
     */
    public static final String JEZIKI_LIST = "jezikiList";
//Jeziki-END


//Ladja-START
    /**
     * The request scope attribute that holds the ladja form.
     */
    public static final String LADJA_KEY = "ladjaForm";

    /**
     * The request scope attribute that holds the ladja list
     */
    public static final String LADJA_LIST = "ladjaList";
//Ladja-END


//Drzava-START
    /**
     * The request scope attribute that holds the drzava form.
     */
    public static final String DRZAVA_KEY = "drzavaForm";

    /**
     * The request scope attribute that holds the drzava list
     */
    public static final String DRZAVA_LIST = "drzavaList";
//Drzava-END


//Luka-START
    /**
     * The request scope attribute that holds the luka form.
     */
    public static final String LUKA_KEY = "lukaForm";

    /**
     * The request scope attribute that holds the luka list
     */
    public static final String LUKA_LIST = "lukaList";
//Luka-END


//Ladjar-START
    /**
     * The request scope attribute that holds the ladjar form.
     */
    public static final String LADJAR_KEY = "ladjarForm";

    /**
     * The request scope attribute that holds the ladjar list
     */
    public static final String LADJAR_LIST = "ladjarList";
//Ladjar-END





//Esd30-START
    /**
     * The request scope attribute that holds the esd30 form.
     */
    public static final String ESD30_KEY = "esd30Form";

    /**
     * The request scope attribute that holds the esd30 list
     */
    public static final String ESD30_LIST = "esd30List";
//Esd30-END


//Esd10-START
    /**
     * The request scope attribute that holds the esd10 form.
     */
    public static final String ESD10_KEY = "esd10Form";

    /**
     * The request scope attribute that holds the esd10 list
     */
    public static final String ESD10_LIST = "esd10List";
//Esd10-END


//Esd20-START
    /**
     * The request scope attribute that holds the esd20 form.
     */
    public static final String ESD20_KEY = "esd20Form";

    /**
     * The request scope attribute that holds the esd20 list
     */
    public static final String ESD20_LIST = "esd20List";
//Esd20-END


//Sifrant-START
    /**
     * The request scope attribute that holds the sifrant form.
     */
    public static final String SIFRANT_KEY = "sifrantForm";

    /**
     * The request scope attribute that holds the sifrant list
     */
    public static final String SIFRANT_LIST = "sifrantList";
//Sifrant-END





//Stranke-START
    /**
     * The request scope attribute that holds the stranke form.
     */
    public static final String STRANKE_KEY = "strankeForm";

    /**
     * The request scope attribute that holds the stranke list
     */
    public static final String STRANKE_LIST = "strankeList";
//Stranke-END


//Planprihodov-START
    /**
     * The request scope attribute that holds the planprihodov form.
     */
    public static final String PLANPRIHODOV_KEY = "planprihodovForm";

    /**
     * The request scope attribute that holds the planprihodov list
     */
    public static final String PLANPRIHODOV_LIST = "planprihodovList";
//Planprihodov-END


//Planprihodovarh-START
    /**
     * The request scope attribute that holds the planprihodovarh form.
     */
    public static final String PLANPRIHODOVARH_KEY = "planprihodovarhForm";

    /**
     * The request scope attribute that holds the planprihodovarh list
     */
    public static final String PLANPRIHODOVARH_LIST = "planprihodovarhList";
//Planprihodovarh-END


//Isd_dvh_gl-START
    /**
     * The request scope attribute that holds the isd_dvh_gl form.
     */
    public static final String ISD_DVH_GL_KEY = "isd_dvh_glForm";

    /**
     * The request scope attribute that holds the isd_dvh_gl list
     */
    public static final String ISD_DVH_GL_LIST = "isd_dvh_glList";
//Isd_dvh_gl-END


//Isd_dvh_pos-START
    /**
     * The request scope attribute that holds the isd_dvh_pos form.
     */
    public static final String ISD_DVH_POS_KEY = "isd_dvh_posForm";

    /**
     * The request scope attribute that holds the isd_dvh_pos list
     */
    public static final String ISD_DVH_POS_LIST = "isd_dvh_posList";
//Isd_dvh_pos-END


//Isd_dvh_vrs-START
    /**
     * The request scope attribute that holds the isd_dvh_vrs form.
     */
    public static final String ISD_DVH_VRS_KEY = "isd_dvh_vrsForm";

    /**
     * The request scope attribute that holds the isd_dvh_vrs list
     */
    public static final String ISD_DVH_VRS_LIST = "isd_dvh_vrsList";
//Isd_dvh_vrs-END


//Esd16-START
    /**
     * The request scope attribute that holds the esd16 form.
     */
    public static final String ESD16_KEY = "esd16Form";

    /**
     * The request scope attribute that holds the esd16 list
     */
    public static final String ESD16_LIST = "esd16List";
//Esd16-END


//Esd50-START
    /**
     * The request scope attribute that holds the esd50 form.
     */
    public static final String ESD50_KEY = "esd50Form";

    /**
     * The request scope attribute that holds the esd50 list
     */
    public static final String ESD50_LIST = "esd50List";
//Esd50-END


//Esd51-START
    /**
     * The request scope attribute that holds the esd51 form.
     */
    public static final String ESD51_KEY = "esd51Form";

    /**
     * The request scope attribute that holds the esd51 list
     */
    public static final String ESD51_LIST = "esd51List";
//Esd51-END


//Esd52-START
    /**
     * The request scope attribute that holds the esd52 form.
     */
    public static final String ESD52_KEY = "esd52Form";

    /**
     * The request scope attribute that holds the esd52 list
     */
    public static final String ESD52_LIST = "esd52List";
//Esd52-END


//Esd53-START
    /**
     * The request scope attribute that holds the esd53 form.
     */
    public static final String ESD53_KEY = "esd53Form";

    /**
     * The request scope attribute that holds the esd53 list
     */
    public static final String ESD53_LIST = "esd53List";
//Esd53-END


//Esd54-START
    /**
     * The request scope attribute that holds the esd54 form.
     */
    public static final String ESD54_KEY = "esd54Form";

    /**
     * The request scope attribute that holds the esd54 list
     */
    public static final String ESD54_LIST = "esd54List";
//Esd54-END


//Esd351-START
    /**
     * The request scope attribute that holds the esd351 form.
     */
    public static final String ESD351_KEY = "esd351Form";

    /**
     * The request scope attribute that holds the esd351 list
     */
    public static final String ESD351_LIST = "esd351List";
//Esd351-END


//Esd15-START
    /**
     * The request scope attribute that holds the esd15 form.
     */
    public static final String ESD15_KEY = "esd15Form";

    /**
     * The request scope attribute that holds the esd15 list
     */
    public static final String ESD15_LIST = "esd15List";
//Esd15-END


//Esd60-START
    /**
     * The request scope attribute that holds the esd60 form.
     */
    public static final String ESD60_KEY = "esd60Form";

    /**
     * The request scope attribute that holds the esd60 list
     */
    public static final String ESD60_LIST = "esd60List";
//Esd60-END


//Esd61-START
    /**
     * The request scope attribute that holds the esd61 form.
     */
    public static final String ESD61_KEY = "esd61Form";

    /**
     * The request scope attribute that holds the esd61 list
     */
    public static final String ESD61_LIST = "esd61List";
//Esd61-END


//Esd66-START
    /**
     * The request scope attribute that holds the esd66 form.
     */
    public static final String ESD66_KEY = "esd66Form";

    /**
     * The request scope attribute that holds the esd66 list
     */
    public static final String ESD66_LIST = "esd66List";
//Esd66-END


//Esd21-START
    /**
     * The request scope attribute that holds the esd21 form.
     */
    public static final String ESD21_KEY = "esd21Form";

    /**
     * The request scope attribute that holds the esd21 list
     */
    public static final String ESD21_LIST = "esd21List";
//Esd21-END


//Prevozniki-START
    /**
     * The request scope attribute that holds the prevozniki form.
     */
    public static final String PREVOZNIKI_KEY = "prevoznikiForm";

    /**
     * The request scope attribute that holds the prevozniki list
     */
    public static final String PREVOZNIKI_LIST = "prevoznikiList";
//Prevozniki-END


//Wse_prijave-START
    /**
     * The request scope attribute that holds the wse_prijave form.
     */
    public static final String WSE_PRIJAVE_KEY = "wse_prijaveForm";

    /**
     * The request scope attribute that holds the wse_prijave list
     */
    public static final String WSE_PRIJAVE_LIST = "wse_prijaveList";
//Wse_prijave-END


//Wse_log-START
    /**
     * The request scope attribute that holds the wse_log form.
     */
    public static final String WSE_LOG_KEY = "wse_logForm";

    /**
     * The request scope attribute that holds the wse_log list
     */
    public static final String WSE_LOG_LIST = "wse_logList";
//Wse_log-END





//Esd11-START
    /**
     * The request scope attribute that holds the esd11 form.
     */
    public static final String ESD11_KEY = "esd11Form";

    /**
     * The request scope attribute that holds the esd11 list
     */
    public static final String ESD11_LIST = "esd11List";
//Esd11-END


//Wse_log_pozicije-START
    /**
     * The request scope attribute that holds the wse_log_pozicije form.
     */
    public static final String WSE_LOG_POZICIJE_KEY = "wse_log_pozicijeForm";

    /**
     * The request scope attribute that holds the wse_log_pozicije list
     */
    public static final String WSE_LOG_POZICIJE_LIST = "wse_log_pozicijeList";
//Wse_log_pozicije-END


//Carinarnice-START
    /**
     * The request scope attribute that holds the carinarnice form.
     */
    public static final String CARINARNICE_KEY = "carinarniceForm";

    /**
     * The request scope attribute that holds the carinarnice list
     */
    public static final String CARINARNICE_LIST = "carinarniceList";
//Carinarnice-END


//Obvestila-START
    /**
     * The request scope attribute that holds the obvestila form.
     */
    public static final String OBVESTILA_KEY = "obvestilaForm";

    /**
     * The request scope attribute that holds the obvestila list
     */
    public static final String OBVESTILA_LIST = "obvestilaList";
//Obvestila-END


//FrameSize-START
    /**
     * The request scope attribute that holds the frameSize form.
     */
    public static final String FRAMESIZE_KEY = "frameSizeForm";

    /**
     * The request scope attribute that holds the frameSize list
     */
    public static final String FRAMESIZE_LIST = "frameSizeList";
//FrameSize-END


//Esd70-START
    /**
     * The request scope attribute that holds the esd70 form.
     */
    public static final String ESD70_KEY = "esd70Form";

    /**
     * The request scope attribute that holds the esd70 list
     */
    public static final String ESD70_LIST = "esd70List";
//Esd70-END


//Esd76-START
    /**
     * The request scope attribute that holds the esd76 form.
     */
    public static final String ESD76_KEY = "esd76Form";

    /**
     * The request scope attribute that holds the esd76 list
     */
    public static final String ESD76_LIST = "esd76List";
//Esd76-END


//LukSklad-START
    /**
     * The request scope attribute that holds the lukSklad form.
     */
    public static final String LUKSKLAD_KEY = "lukSkladForm";

    /**
     * The request scope attribute that holds the lukSklad list
     */
    public static final String LUKSKLAD_LIST = "lukSkladList";
//LukSklad-END


//Esd80-START
    /**
     * The request scope attribute that holds the esd80 form.
     */
    public static final String ESD80_KEY = "esd80Form";

    /**
     * The request scope attribute that holds the esd80 list
     */
    public static final String ESD80_LIST = "esd80List";
//Esd80-END


//Esd81-START
    /**
     * The request scope attribute that holds the esd81 form.
     */
    public static final String ESD81_KEY = "esd81Form";

    /**
     * The request scope attribute that holds the esd81 list
     */
    public static final String ESD81_LIST = "esd81List";
//Esd81-END


//Esd82-START
    /**
     * The request scope attribute that holds the esd82 form.
     */
    public static final String ESD82_KEY = "esd82Form";

    /**
     * The request scope attribute that holds the esd82 list
     */
    public static final String ESD82_LIST = "esd82List";
//Esd82-END


//Esd86-START
    /**
     * The request scope attribute that holds the esd86 form.
     */
    public static final String ESD86_KEY = "esd86Form";

    /**
     * The request scope attribute that holds the esd86 list
     */
    public static final String ESD86_LIST = "esd86List";
//Esd86-END


//Esd90-START
    /**
     * The request scope attribute that holds the esd90 form.
     */
    public static final String ESD90_KEY = "esd90Form";

    /**
     * The request scope attribute that holds the esd90 list
     */
    public static final String ESD90_LIST = "esd90List";
//Esd90-END


//Esd91-START
    /**
     * The request scope attribute that holds the esd91 form.
     */
    public static final String ESD91_KEY = "esd91Form";

    /**
     * The request scope attribute that holds the esd91 list
     */
    public static final String ESD91_LIST = "esd91List";
//Esd91-END


//Esd92-START
    /**
     * The request scope attribute that holds the esd92 form.
     */
    public static final String ESD92_KEY = "esd92Form";

    /**
     * The request scope attribute that holds the esd92 list
     */
    public static final String ESD92_LIST = "esd92List";
//Esd92-END


//Esd93-START
    /**
     * The request scope attribute that holds the esd93 form.
     */
    public static final String ESD93_KEY = "esd93Form";

    /**
     * The request scope attribute that holds the esd93 list
     */
    public static final String ESD93_LIST = "esd93List";
//Esd93-END


//Esd95-START
    /**
     * The request scope attribute that holds the esd95 form.
     */
    public static final String ESD95_KEY = "esd95Form";

    /**
     * The request scope attribute that holds the esd95 list
     */
    public static final String ESD95_LIST = "esd95List";
//Esd95-END


//Esd96-START
    /**
     * The request scope attribute that holds the esd96 form.
     */
    public static final String ESD96_KEY = "esd96Form";

    /**
     * The request scope attribute that holds the esd96 list
     */
    public static final String ESD96_LIST = "esd96List";
//Esd96-END


//Esd72-START
    /**
     * The request scope attribute that holds the esd72 form.
     */
    public static final String ESD72_KEY = "esd72Form";

    /**
     * The request scope attribute that holds the esd72 list
     */
    public static final String ESD72_LIST = "esd72List";
//Esd72-END


//Mail_message-START
    /**
     * The request scope attribute that holds the mail_message form.
     */
    public static final String MAIL_MESSAGE_KEY = "mail_messageForm";

    /**
     * The request scope attribute that holds the mail_message list
     */
    public static final String MAIL_MESSAGE_LIST = "mail_messageList";
//Mail_message-END


//Esd56-START
    /**
     * The request scope attribute that holds the esd56 form.
     */
    public static final String ESD56_KEY = "esd56Form";

    /**
     * The request scope attribute that holds the esd56 list
     */
    public static final String ESD56_LIST = "esd56List";
//Esd56-END


//Uvsd_datoteka-START
    /**
     * The request scope attribute that holds the uvsd_datoteka form.
     */
    public static final String UVSD_DATOTEKA_KEY = "uvsd_datotekaForm";

    /**
     * The request scope attribute that holds the uvsd_datoteka list
     */
    public static final String UVSD_DATOTEKA_LIST = "uvsd_datotekaList";
//Uvsd_datoteka-END


//PodjetjaUpload315-START
    /**
     * The request scope attribute that holds the podjetjaUpload315 form.
     */
    public static final String PODJETJAUPLOAD315_KEY = "podjetjaUpload315Form";

    /**
     * The request scope attribute that holds the podjetjaUpload315 list
     */
    public static final String PODJETJAUPLOAD315_LIST = "podjetjaUpload315List";
//PodjetjaUpload315-END


//Esd12-START
    /**
     * The request scope attribute that holds the esd12 form.
     */
    public static final String ESD12_KEY = "esd12Form";

    /**
     * The request scope attribute that holds the esd12 list
     */
    public static final String ESD12_LIST = "esd12List";
//Esd12-END


//TemplateHead-START
    /**
     * The request scope attribute that holds the templateHead form.
     */
    public static final String TEMPLATEHEAD_KEY = "templateHeadForm";

    /**
     * The request scope attribute that holds the templateHead list
     */
    public static final String TEMPLATEHEAD_LIST = "templateHeadList";
//TemplateHead-END


//Prevodi-START
    /**
     * The request scope attribute that holds the prevodi form.
     */
    public static final String PREVODI_KEY = "prevodiForm";

    /**
     * The request scope attribute that holds the prevodi list
     */
    public static final String PREVODI_LIST = "prevodiList";
//Prevodi-END


//TemplateClass-START
    /**
     * The request scope attribute that holds the templateClass form.
     */
    public static final String TEMPLATECLASS_KEY = "templateClassForm";

    /**
     * The request scope attribute that holds the templateClass list
     */
    public static final String TEMPLATECLASS_LIST = "templateClassList";
//TemplateClass-END


//TemplateList-START
    /**
     * The request scope attribute that holds the templateList form.
     */
    public static final String TEMPLATELIST_KEY = "templateListForm";

    /**
     * The request scope attribute that holds the templateList list
     */
    public static final String TEMPLATELIST_LIST = "templateListList";
//TemplateList-END


//TemplateClassClass_vrednosti-START
    /**
     * The request scope attribute that holds the templateClassClass_vrednosti form.
     */
    public static final String TEMPLATECLASSCLASS_VREDNOSTI_KEY = "templateClassClass_vrednostiForm";

    /**
     * The request scope attribute that holds the templateClassClass_vrednosti list
     */
    public static final String TEMPLATECLASSCLASS_VREDNOSTI_LIST = "templateClassClass_vrednostiList";
//TemplateClassClass_vrednosti-END


//TemplateClassClass-START
    /**
     * The request scope attribute that holds the templateClassClass form.
     */
    public static final String TEMPLATECLASSCLASS_KEY = "templateClassClassForm";

    /**
     * The request scope attribute that holds the templateClassClass list
     */
    public static final String TEMPLATECLASSCLASS_LIST = "templateClassClassList";
//TemplateClassClass-END


//TemplateView-START
    /**
     * The request scope attribute that holds the templateView form.
     */
    public static final String TEMPLATEVIEW_KEY = "templateViewForm";

    /**
     * The request scope attribute that holds the templateView list
     */
    public static final String TEMPLATEVIEW_LIST = "templateViewList";
//TemplateView-END


//TemplateUi-START
    /**
     * The request scope attribute that holds the templateUi form.
     */
    public static final String TEMPLATEUI_KEY = "templateUiForm";

    /**
     * The request scope attribute that holds the templateUi list
     */
    public static final String TEMPLATEUI_LIST = "templateUiList";
//TemplateUi-END


//TemplateUiDodatno-START
    /**
     * The request scope attribute that holds the templateUiDodatno form.
     */
    public static final String TEMPLATEUIDODATNO_KEY = "templateUiDodatnoForm";

    /**
     * The request scope attribute that holds the templateUiDodatno list
     */
    public static final String TEMPLATEUIDODATNO_LIST = "templateUiDodatnoList";
//TemplateUiDodatno-END


//TemplateGumbiParametri-START
    /**
     * The request scope attribute that holds the templateGumbiParametri form.
     */
    public static final String TEMPLATEGUMBIPARAMETRI_KEY = "templateGumbiParametriForm";

    /**
     * The request scope attribute that holds the templateGumbiParametri list
     */
    public static final String TEMPLATEGUMBIPARAMETRI_LIST = "templateGumbiParametriList";
//TemplateGumbiParametri-END


//TemplateGumbi-START
    /**
     * The request scope attribute that holds the templateGumbi form.
     */
    public static final String TEMPLATEGUMBI_KEY = "templateGumbiForm";

    /**
     * The request scope attribute that holds the templateGumbi list
     */
    public static final String TEMPLATEGUMBI_LIST = "templateGumbiList";
//TemplateGumbi-END


//TemplateDDPogoji-START
    /**
     * The request scope attribute that holds the templateDDPogoji form.
     */
    public static final String TEMPLATEDDPOGOJI_KEY = "templateDDPogojiForm";

    /**
     * The request scope attribute that holds the templateDDPogoji list
     */
    public static final String TEMPLATEDDPOGOJI_LIST = "templateDDPogojiList";
//TemplateDDPogoji-END


//TemplateDD-START
    /**
     * The request scope attribute that holds the templateDD form.
     */
    public static final String TEMPLATEDD_KEY = "templateDDForm";

    /**
     * The request scope attribute that holds the templateDD list
     */
    public static final String TEMPLATEDD_LIST = "templateDDList";
//TemplateDD-END


//TemplateFunkcija-START
    /**
     * The request scope attribute that holds the templateFunkcija form.
     */
    public static final String TEMPLATEFUNKCIJA_KEY = "templateFunkcijaForm";

    /**
     * The request scope attribute that holds the templateFunkcija list
     */
    public static final String TEMPLATEFUNKCIJA_LIST = "templateFunkcijaList";
//TemplateFunkcija-END


//TemplateFunkcijaStart-START
    /**
     * The request scope attribute that holds the templateFunkcijaStart form.
     */
    public static final String TEMPLATEFUNKCIJASTART_KEY = "templateFunkcijaStartForm";

    /**
     * The request scope attribute that holds the templateFunkcijaStart list
     */
    public static final String TEMPLATEFUNKCIJASTART_LIST = "templateFunkcijaStartList";
//TemplateFunkcijaStart-END


//TemplateMenu-START
    /**
     * The request scope attribute that holds the templateMenu form.
     */
    public static final String TEMPLATEMENU_KEY = "templateMenuForm";

    /**
     * The request scope attribute that holds the templateMenu list
     */
    public static final String TEMPLATEMENU_LIST = "templateMenuList";
//TemplateMenu-END


//TemplateHeadReset-START
    /**
     * The request scope attribute that holds the templateHeadReset form.
     */
    public static final String TEMPLATEHEADRESET_KEY = "templateHeadResetForm";

    /**
     * The request scope attribute that holds the templateHeadReset list
     */
    public static final String TEMPLATEHEADRESET_LIST = "templateHeadResetList";
//TemplateHeadReset-END


//TemplatePP-START
    /**
     * The request scope attribute that holds the templatePP form.
     */
    public static final String TEMPLATEPP_KEY = "templatePPForm";

    /**
     * The request scope attribute that holds the templatePP list
     */
    public static final String TEMPLATEPP_LIST = "templatePPList";
//TemplatePP-END


//Pnppnav0-START
    /**
     * The request scope attribute that holds the pnppnav0 form.
     */
    public static final String PNPPNAV0_KEY = "pnppnav0Form";

    /**
     * The request scope attribute that holds the pnppnav0 list
     */
    public static final String PNPPNAV0_LIST = "pnppnav0List";
//Pnppnav0-END


//Pnppnla0-START
    /**
     * The request scope attribute that holds the pnppnla0 form.
     */
    public static final String PNPPNLA0_KEY = "pnppnla0Form";

    /**
     * The request scope attribute that holds the pnppnla0 list
     */
    public static final String PNPPNLA0_LIST = "pnppnla0List";
//Pnppnla0-END


//Pnppdni0-START
    /**
     * The request scope attribute that holds the pnppdni0 form.
     */
    public static final String PNPPDNI0_KEY = "pnppdni0Form";

    /**
     * The request scope attribute that holds the pnppdni0 list
     */
    public static final String PNPPDNI0_LIST = "pnppdni0List";
//Pnppdni0-END


//Pnppinc0-START
    /**
     * The request scope attribute that holds the pnppinc0 form.
     */
    public static final String PNPPINC0_KEY = "pnppinc0Form";

    /**
     * The request scope attribute that holds the pnppinc0 list
     */
    public static final String PNPPINC0_LIST = "pnppinc0List";
//Pnppinc0-END


//Pnppinn0-START
    /**
     * The request scope attribute that holds the pnppinn0 form.
     */
    public static final String PNPPINN0_KEY = "pnppinn0Form";

    /**
     * The request scope attribute that holds the pnppinn0 list
     */
    public static final String PNPPINN0_LIST = "pnppinn0List";
//Pnppinn0-END


//Pnppnhm0-START
    /**
     * The request scope attribute that holds the pnppnhm0 form.
     */
    public static final String PNPPNHM0_KEY = "pnppnhm0Form";

    /**
     * The request scope attribute that holds the pnppnhm0 list
     */
    public static final String PNPPNHM0_LIST = "pnppnhm0List";
//Pnppnhm0-END


//Pnppnrd0-START
    /**
     * The request scope attribute that holds the pnppnrd0 form.
     */
    public static final String PNPPNRD0_KEY = "pnppnrd0Form";

    /**
     * The request scope attribute that holds the pnppnrd0 list
     */
    public static final String PNPPNRD0_LIST = "pnppnrd0List";
//Pnppnrd0-END


//Pnppnrv0-START
    /**
     * The request scope attribute that holds the pnppnrv0 form.
     */
    public static final String PNPPNRV0_KEY = "pnppnrv0Form";

    /**
     * The request scope attribute that holds the pnppnrv0 list
     */
    public static final String PNPPNRV0_LIST = "pnppnrv0List";
//Pnppnrv0-END


//Pnppzsl0-START
    /**
     * The request scope attribute that holds the pnppzsl0 form.
     */
    public static final String PNPPZSL0_KEY = "pnppzsl0Form";

    /**
     * The request scope attribute that holds the pnppzsl0 list
     */
    public static final String PNPPZSL0_LIST = "pnppzsl0List";
//Pnppzsl0-END


//Dokument-START
    /**
     * The request scope attribute that holds the dokument form.
     */
    public static final String DOKUMENT_KEY = "dokumentForm";

    /**
     * The request scope attribute that holds the dokument list
     */
    public static final String DOKUMENT_LIST = "dokumentList";
//Dokument-END


//Linija-START
    /**
     * The request scope attribute that holds the linija form.
     */
    public static final String LINIJA_KEY = "linijaForm";

    /**
     * The request scope attribute that holds the linija list
     */
    public static final String LINIJA_LIST = "linijaList";
//Linija-END


//Sp1pmap0-START
    /**
     * The request scope attribute that holds the sp1pmap0 form.
     */
    public static final String SP1PMAP0_KEY = "sp1pmap0Form";

    /**
     * The request scope attribute that holds the sp1pmap0 list
     */
    public static final String SP1PMAP0_LIST = "sp1pmap0List";
//Sp1pmap0-END


//Pnpperr0-START
    /**
     * The request scope attribute that holds the pnpperr0 form.
     */
    public static final String PNPPERR0_KEY = "pnpperr0Form";

    /**
     * The request scope attribute that holds the pnpperr0 list
     */
    public static final String PNPPERR0_LIST = "pnpperr0List";
//Pnpperr0-END


//Sp1mssz0-START
    /**
     * The request scope attribute that holds the sp1mssz0 form.
     */
    public static final String SP1MSSZ0_KEY = "sp1mssz0Form";

    /**
     * The request scope attribute that holds the sp1mssz0 list
     */
    public static final String SP1MSSZ0_LIST = "sp1mssz0List";
//Sp1mssz0-END


//Pnppszs0-START
    /**
     * The request scope attribute that holds the pnppszs0 form.
     */
    public static final String PNPPSZS0_KEY = "pnppszs0Form";

    /**
     * The request scope attribute that holds the pnppszs0 list
     */
    public static final String PNPPSZS0_LIST = "pnppszs0List";
//Pnppszs0-END


//Pnppspv0-START
    /**
     * The request scope attribute that holds the pnppspv0 form.
     */
    public static final String PNPPSPV0_KEY = "pnppspv0Form";

    /**
     * The request scope attribute that holds the pnppspv0 list
     */
    public static final String PNPPSPV0_LIST = "pnppspv0List";
//Pnppspv0-END


//Pnppop10-START
    /**
     * The request scope attribute that holds the pnppop10 form.
     */
    public static final String PNPPOP10_KEY = "pnppop10Form";

    /**
     * The request scope attribute that holds the pnppop10 list
     */
    public static final String PNPPOP10_LIST = "pnppop10List";
//Pnppop10-END


//Pnppop00-START
    /**
     * The request scope attribute that holds the pnppop00 form.
     */
    public static final String PNPPOP00_KEY = "pnppop00Form";

    /**
     * The request scope attribute that holds the pnppop00 list
     */
    public static final String PNPPOP00_LIST = "pnppop00List";
//Pnppop00-END


//Pnpnara0-START
    /**
     * The request scope attribute that holds the pnpnara0 form.
     */
    public static final String PNPNARA0_KEY = "pnpnara0Form";

    /**
     * The request scope attribute that holds the pnpnara0 list
     */
    public static final String PNPNARA0_LIST = "pnpnara0List";
//Pnpnara0-END


//Ktgi-START
    /**
     * The request scope attribute that holds the ktgi form.
     */
    public static final String KTGI_KEY = "ktgiForm";

    /**
     * The request scope attribute that holds the ktgi list
     */
    public static final String KTGI_LIST = "ktgiList";
//Ktgi-END


//Sd1pdbl0-START
    /**
     * The request scope attribute that holds the sd1pdbl0 form.
     */
    public static final String SD1PDBL0_KEY = "sd1pdbl0Form";

    /**
     * The request scope attribute that holds the sd1pdbl0 list
     */
    public static final String SD1PDBL0_LIST = "sd1pdbl0List";
//Sd1pdbl0-END


//Sd1pdgl0-START
    /**
     * The request scope attribute that holds the sd1pdgl0 form.
     */
    public static final String SD1PDGL0_KEY = "sd1pdgl0Form";

    /**
     * The request scope attribute that holds the sd1pdgl0 list
     */
    public static final String SD1PDGL0_LIST = "sd1pdgl0List";
//Sd1pdgl0-END


//Sd1pdoi0-START
    /**
     * The request scope attribute that holds the sd1pdoi0 form.
     */
    public static final String SD1PDOI0_KEY = "sd1pdoi0Form";

    /**
     * The request scope attribute that holds the sd1pdoi0 list
     */
    public static final String SD1PDOI0_LIST = "sd1pdoi0List";
//Sd1pdoi0-END


//Sd1pdvb0-START
    /**
     * The request scope attribute that holds the sd1pdvb0 form.
     */
    public static final String SD1PDVB0_KEY = "sd1pdvb0Form";

    /**
     * The request scope attribute that holds the sd1pdvb0 list
     */
    public static final String SD1PDVB0_LIST = "sd1pdvb0List";
//Sd1pdvb0-END


//Sd1perr0-START
    /**
     * The request scope attribute that holds the sd1perr0 form.
     */
    public static final String SD1PERR0_KEY = "sd1perr0Form";

    /**
     * The request scope attribute that holds the sd1perr0 list
     */
    public static final String SD1PERR0_LIST = "sd1perr0List";
//Sd1perr0-END


//Sd1pkar0-START
    /**
     * The request scope attribute that holds the sd1pkar0 form.
     */
    public static final String SD1PKAR0_KEY = "sd1pkar0Form";

    /**
     * The request scope attribute that holds the sd1pkar0 list
     */
    public static final String SD1PKAR0_LIST = "sd1pkar0List";
//Sd1pkar0-END


//Sd1pkon0-START
    /**
     * The request scope attribute that holds the sd1pkon0 form.
     */
    public static final String SD1PKON0_KEY = "sd1pkon0Form";

    /**
     * The request scope attribute that holds the sd1pkon0 list
     */
    public static final String SD1PKON0_LIST = "sd1pkon0List";
//Sd1pkon0-END


//Sd1pkte0-START
    /**
     * The request scope attribute that holds the sd1pkte0 form.
     */
    public static final String SD1PKTE0_KEY = "sd1pkte0Form";

    /**
     * The request scope attribute that holds the sd1pkte0 list
     */
    public static final String SD1PKTE0_LIST = "sd1pkte0List";
//Sd1pkte0-END


//Isocnt-START
    /**
     * The request scope attribute that holds the isocnt form.
     */
    public static final String ISOCNT_KEY = "isocntForm";

    /**
     * The request scope attribute that holds the isocnt list
     */
    public static final String ISOCNT_LIST = "isocntList";
//Isocnt-END


//Sd1vkte0-START
    /**
     * The request scope attribute that holds the sd1vkte0 form.
     */
    public static final String SD1VKTE0_KEY = "sd1vkte0Form";

    /**
     * The request scope attribute that holds the sd1vkte0 list
     */
    public static final String SD1VKTE0_LIST = "sd1vkte0List";
//Sd1vkte0-END


//Sd1ppri0-START
    /**
     * The request scope attribute that holds the sd1ppri0 form.
     */
    public static final String SD1PPRI0_KEY = "sd1ppri0Form";

    /**
     * The request scope attribute that holds the sd1ppri0 list
     */
    public static final String SD1PPRI0_LIST = "sd1ppri0List";
//Sd1ppri0-END


//Sd1povp0-START
    /**
     * The request scope attribute that holds the sd1povp0 form.
     */
    public static final String SD1POVP0_KEY = "sd1povp0Form";

    /**
     * The request scope attribute that holds the sd1povp0 list
     */
    public static final String SD1POVP0_LIST = "sd1povp0List";
//Sd1povp0-END


//Sd1pogd0-START
    /**
     * The request scope attribute that holds the sd1pogd0 form.
     */
    public static final String SD1POGD0_KEY = "sd1pogd0Form";

    /**
     * The request scope attribute that holds the sd1pogd0 list
     */
    public static final String SD1POGD0_LIST = "sd1pogd0List";
//Sd1pogd0-END


//Sd1povs0-START
    /**
     * The request scope attribute that holds the sd1povs0 form.
     */
    public static final String SD1POVS0_KEY = "sd1povs0Form";

    /**
     * The request scope attribute that holds the sd1povs0 list
     */
    public static final String SD1POVS0_LIST = "sd1povs0List";
//Sd1povs0-END


//Sd1pmar0-START
    /**
     * The request scope attribute that holds the sd1pmar0 form.
     */
    public static final String SD1PMAR0_KEY = "sd1pmar0Form";

    /**
     * The request scope attribute that holds the sd1pmar0 list
     */
    public static final String SD1PMAR0_LIST = "sd1pmar0List";
//Sd1pmar0-END


//Sd1pktf0-START
    /**
     * The request scope attribute that holds the sd1pktf0 form.
     */
    public static final String SD1PKTF0_KEY = "sd1pktf0Form";

    /**
     * The request scope attribute that holds the sd1pktf0 list
     */
    public static final String SD1PKTF0_LIST = "sd1pktf0List";
//Sd1pktf0-END


//Sd1povd0-START
    /**
     * The request scope attribute that holds the sd1povd0 form.
     */
    public static final String SD1POVD0_KEY = "sd1povd0Form";

    /**
     * The request scope attribute that holds the sd1povd0 list
     */
    public static final String SD1POVD0_LIST = "sd1povd0List";
//Sd1povd0-END


//Sd1pogz0-START
    /**
     * The request scope attribute that holds the sd1pogz0 form.
     */
    public static final String SD1POGZ0_KEY = "sd1pogz0Form";

    /**
     * The request scope attribute that holds the sd1pogz0 list
     */
    public static final String SD1POGZ0_LIST = "sd1pogz0List";
//Sd1pogz0-END


//Sd1pskl0-START
    /**
     * The request scope attribute that holds the sd1pskl0 form.
     */
    public static final String SD1PSKL0_KEY = "sd1pskl0Form";

    /**
     * The request scope attribute that holds the sd1pskl0 list
     */
    public static final String SD1PSKL0_LIST = "sd1pskl0List";
//Sd1pskl0-END


//Sp1pinc0-START
    /**
     * The request scope attribute that holds the sp1pinc0 form.
     */
    public static final String SP1PINC0_KEY = "sp1pinc0Form";

    /**
     * The request scope attribute that holds the sp1pinc0 list
     */
    public static final String SP1PINC0_LIST = "sp1pinc0List";
//Sp1pinc0-END


//Sd1vktf0-START
    /**
     * The request scope attribute that holds the sd1vktf0 form.
     */
    public static final String SD1VKTF0_KEY = "sd1vktf0Form";

    /**
     * The request scope attribute that holds the sd1vktf0 list
     */
    public static final String SD1VKTF0_LIST = "sd1vktf0List";
//Sd1vktf0-END


//Sdismsg-START
    /**
     * The request scope attribute that holds the sdismsg form.
     */
    public static final String SDISMSG_KEY = "sdismsgForm";

    /**
     * The request scope attribute that holds the sdismsg list
     */
    public static final String SDISMSG_LIST = "sdismsgList";
//Sdismsg-END


//Sp1ppre0-START
    /**
     * The request scope attribute that holds the sp1ppre0 form.
     */
    public static final String SP1PPRE0_KEY = "sp1ppre0Form";

    /**
     * The request scope attribute that holds the sp1ppre0 list
     */
    public static final String SP1PPRE0_LIST = "sp1ppre0List";
//Sp1ppre0-END


//Tipprem-START
    /**
     * The request scope attribute that holds the tipprem form.
     */
    public static final String TIPPREM_KEY = "tippremForm";

    /**
     * The request scope attribute that holds the tipprem list
     */
    public static final String TIPPREM_LIST = "tippremList";
//Tipprem-END


//Sp1pcim0-START
    /**
     * The request scope attribute that holds the sp1pcim0 form.
     */
    public static final String SP1PCIM0_KEY = "sp1pcim0Form";

    /**
     * The request scope attribute that holds the sp1pcim0 list
     */
    public static final String SP1PCIM0_LIST = "sp1pcim0List";
//Sp1pcim0-END


//Sp1mapt0-START
    /**
     * The request scope attribute that holds the sp1mapt0 form.
     */
    public static final String SP1MAPT0_KEY = "sp1mapt0Form";

    /**
     * The request scope attribute that holds the sp1mapt0 list
     */
    public static final String SP1MAPT0_LIST = "sp1mapt0List";
//Sp1mapt0-END


//Sp1pvag0-START
    /**
     * The request scope attribute that holds the sp1pvag0 form.
     */
    public static final String SP1PVAG0_KEY = "sp1pvag0Form";

    /**
     * The request scope attribute that holds the sp1pvag0 list
     */
    public static final String SP1PVAG0_LIST = "sp1pvag0List";
//Sp1pvag0-END


//Sp1psic0-START
    /**
     * The request scope attribute that holds the sp1psic0 form.
     */
    public static final String SP1PSIC0_KEY = "sp1psic0Form";

    /**
     * The request scope attribute that holds the sp1psic0 list
     */
    public static final String SP1PSIC0_LIST = "sp1psic0List";
//Sp1psic0-END


//Sp1pktf0-START
    /**
     * The request scope attribute that holds the sp1pktf0 form.
     */
    public static final String SP1PKTF0_KEY = "sp1pktf0Form";

    /**
     * The request scope attribute that holds the sp1pktf0 list
     */
    public static final String SP1PKTF0_LIST = "sp1pktf0List";
//Sp1pktf0-END


//Sp1pcmr0-START
    /**
     * The request scope attribute that holds the sp1pcmr0 form.
     */
    public static final String SP1PCMR0_KEY = "sp1pcmr0Form";

    /**
     * The request scope attribute that holds the sp1pcmr0 list
     */
    public static final String SP1PCMR0_LIST = "sp1pcmr0List";
//Sp1pcmr0-END


//Sifrantopis-START
    /**
     * The request scope attribute that holds the sifrantopis form.
     */
    public static final String SIFRANTOPIS_KEY = "sifrantopisForm";

    /**
     * The request scope attribute that holds the sifrantopis list
     */
    public static final String SIFRANTOPIS_LIST = "sifrantopisList";
//Sifrantopis-END


//Pnppmer0-START
    /**
     * The request scope attribute that holds the pnppmer0 form.
     */
    public static final String PNPPMER0_KEY = "pnppmer0Form";

    /**
     * The request scope attribute that holds the pnppmer0 list
     */
    public static final String PNPPMER0_LIST = "pnppmer0List";
//Pnppmer0-END


//Lukstor-START
    /**
     * The request scope attribute that holds the lukstor form.
     */
    public static final String LUKSTOR_KEY = "lukstorForm";

    /**
     * The request scope attribute that holds the lukstor list
     */
    public static final String LUKSTOR_LIST = "lukstorList";
//Lukstor-END


//Imco-START
    /**
     * The request scope attribute that holds the imco form.
     */
    public static final String IMCO_KEY = "imcoForm";

    /**
     * The request scope attribute that holds the imco list
     */
    public static final String IMCO_LIST = "imcoList";
//Imco-END


//TemplatePdfParametri-START
    /**
     * The request scope attribute that holds the templatePdfParametri form.
     */
    public static final String TEMPLATEPDFPARAMETRI_KEY = "templatePdfParametriForm";

    /**
     * The request scope attribute that holds the templatePdfParametri list
     */
    public static final String TEMPLATEPDFPARAMETRI_LIST = "templatePdfParametriList";
//TemplatePdfParametri-END


//Valute-START
    /**
     * The request scope attribute that holds the valute form.
     */
    public static final String VALUTE_KEY = "valuteForm";

    /**
     * The request scope attribute that holds the valute list
     */
    public static final String VALUTE_LIST = "valuteList";
//Valute-END


//UsersPrivilegije-START
    /**
     * The request scope attribute that holds the usersPrivilegije form.
     */
    public static final String USERSPRIVILEGIJE_KEY = "usersPrivilegijeForm";

    /**
     * The request scope attribute that holds the usersPrivilegije list
     */
    public static final String USERSPRIVILEGIJE_LIST = "usersPrivilegijeList";
//UsersPrivilegije-END


//TemplateUpload-START
    /**
     * The request scope attribute that holds the templateUpload form.
     */
    public static final String TEMPLATEUPLOAD_KEY = "templateUploadForm";

    /**
     * The request scope attribute that holds the templateUpload list
     */
    public static final String TEMPLATEUPLOAD_LIST = "templateUploadList";
//TemplateUpload-END


//TemplateTag-START
    /**
     * The request scope attribute that holds the templateTag form.
     */
    public static final String TEMPLATETAG_KEY = "templateTagForm";

    /**
     * The request scope attribute that holds the templateTag list
     */
    public static final String TEMPLATETAG_LIST = "templateTagList";
//TemplateTag-END


//Tipdispozic-START
    /**
     * The request scope attribute that holds the tipdispozic form.
     */
    public static final String TIPDISPOZIC_KEY = "tipdispozicForm";

    /**
     * The request scope attribute that holds the tipdispozic list
     */
    public static final String TIPDISPOZIC_LIST = "tipdispozicList";
//Tipdispozic-END


//Organizacijskeenote-START
    /**
     * The request scope attribute that holds the organizacijskeenote form.
     */
    public static final String ORGANIZACIJSKEENOTE_KEY = "organizacijskeenoteForm";

    /**
     * The request scope attribute that holds the organizacijskeenote list
     */
    public static final String ORGANIZACIJSKEENOTE_LIST = "organizacijskeenoteList";
//Organizacijskeenote-END


//Pnppstv0-START
    /**
     * The request scope attribute that holds the pnppstv0 form.
     */
    public static final String PNPPSTV0_KEY = "pnppstv0Form";

    /**
     * The request scope attribute that holds the pnppstv0 list
     */
    public static final String PNPPSTV0_LIST = "pnppstv0List";
//Pnppstv0-END


//Pnppnrs0-START
    /**
     * The request scope attribute that holds the pnppnrs0 form.
     */
    public static final String PNPPNRS0_KEY = "pnppnrs0Form";

    /**
     * The request scope attribute that holds the pnppnrs0 list
     */
    public static final String PNPPNRS0_LIST = "pnppnrs0List";
//Pnppnrs0-END


//Sd1pdoi1-START
    /**
     * The request scope attribute that holds the sd1pdoi1 form.
     */
    public static final String SD1PDOI1_KEY = "sd1pdoi1Form";

    /**
     * The request scope attribute that holds the sd1pdoi1 list
     */
    public static final String SD1PDOI1_LIST = "sd1pdoi1List";
//Sd1pdoi1-END


//Pnpnara1-START
    /**
     * The request scope attribute that holds the pnpnara1 form.
     */
    public static final String PNPNARA1_KEY = "pnpnara1Form";

    /**
     * The request scope attribute that holds the pnpnara1 list
     */
    public static final String PNPNARA1_LIST = "pnpnara1List";
//Pnpnara1-END











//Em1Country-START
    /**
     * The request scope attribute that holds the em1Country form.
     */
    public static final String EM1COUNTRY_KEY = "em1CountryForm";

    /**
     * The request scope attribute that holds the em1Country list
     */
    public static final String EM1COUNTRY_LIST = "em1CountryList";
//Em1Country-END


//Em1Client-START
    /**
     * The request scope attribute that holds the em1Client form.
     */
    public static final String EM1CLIENT_KEY = "em1ClientForm";

    /**
     * The request scope attribute that holds the em1Client list
     */
    public static final String EM1CLIENT_LIST = "em1ClientList";
//Em1Client-END


//Em1Clientgln1-START
    /**
     * The request scope attribute that holds the em1Clientgln1 form.
     */
    public static final String EM1CLIENTGLN1_KEY = "em1Clientgln1Form";

    /**
     * The request scope attribute that holds the em1Clientgln1 list
     */
    public static final String EM1CLIENTGLN1_LIST = "em1Clientgln1List";
//Em1Clientgln1-END


//Em1Clientgln2-START
    /**
     * The request scope attribute that holds the em1Clientgln2 form.
     */
    public static final String EM1CLIENTGLN2_KEY = "em1Clientgln2Form";

    /**
     * The request scope attribute that holds the em1Clientgln2 list
     */
    public static final String EM1CLIENTGLN2_LIST = "em1Clientgln2List";
//Em1Clientgln2-END


//Em1Group-START
    /**
     * The request scope attribute that holds the em1Group form.
     */
    public static final String EM1GROUP_KEY = "em1GroupForm";

    /**
     * The request scope attribute that holds the em1Group list
     */
    public static final String EM1GROUP_LIST = "em1GroupList";
//Em1Group-END


//Em1User-START
    /**
     * The request scope attribute that holds the em1User form.
     */
    public static final String EM1USER_KEY = "em1UserForm";

    /**
     * The request scope attribute that holds the em1User list
     */
    public static final String EM1USER_LIST = "em1UserList";
//Em1User-END


//Em1UserClient-START
    /**
     * The request scope attribute that holds the em1UserClient form.
     */
    public static final String EM1USERCLIENT_KEY = "em1UserClientForm";

    /**
     * The request scope attribute that holds the em1UserClient list
     */
    public static final String EM1USERCLIENT_LIST = "em1UserClientList";
//Em1UserClient-END


//Em1Usergln1-START
    /**
     * The request scope attribute that holds the em1Usergln1 form.
     */
    public static final String EM1USERGLN1_KEY = "em1Usergln1Form";

    /**
     * The request scope attribute that holds the em1Usergln1 list
     */
    public static final String EM1USERGLN1_LIST = "em1Usergln1List";
//Em1Usergln1-END


//Em1Usergln2-START
    /**
     * The request scope attribute that holds the em1Usergln2 form.
     */
    public static final String EM1USERGLN2_KEY = "em1Usergln2Form";

    /**
     * The request scope attribute that holds the em1Usergln2 list
     */
    public static final String EM1USERGLN2_LIST = "em1Usergln2List";
//Em1Usergln2-END


//Em1Eventlog-START
    /**
     * The request scope attribute that holds the em1Eventlog form.
     */
    public static final String EM1EVENTLOG_KEY = "em1EventlogForm";

    /**
     * The request scope attribute that holds the em1Eventlog list
     */
    public static final String EM1EVENTLOG_LIST = "em1EventlogList";
//Em1Eventlog-END


//Em1ArchiveLog-START
    /**
     * The request scope attribute that holds the em1ArchiveLog form.
     */
    public static final String EM1ARCHIVELOG_KEY = "em1ArchiveLogForm";

    /**
     * The request scope attribute that holds the em1ArchiveLog list
     */
    public static final String EM1ARCHIVELOG_LIST = "em1ArchiveLogList";
//Em1ArchiveLog-END


//Em1ArchiveLogStatus-START
    /**
     * The request scope attribute that holds the em1ArchiveLogStatus form.
     */
    public static final String EM1ARCHIVELOGSTATUS_KEY = "em1ArchiveLogStatusForm";

    /**
     * The request scope attribute that holds the em1ArchiveLogStatus list
     */
    public static final String EM1ARCHIVELOGSTATUS_LIST = "em1ArchiveLogStatusList";
//Em1ArchiveLogStatus-END


//Em1EventlogD10n-START
    /**
     * The request scope attribute that holds the em1EventlogD10n form.
     */
    public static final String EM1EVENTLOGD10N_KEY = "em1EventlogD10nForm";

    /**
     * The request scope attribute that holds the em1EventlogD10n list
     */
    public static final String EM1EVENTLOGD10N_LIST = "em1EventlogD10nList";
//Em1EventlogD10n-END


//Em1EventlogMail-START
    /**
     * The request scope attribute that holds the em1EventlogMail form.
     */
    public static final String EM1EVENTLOGMAIL_KEY = "em1EventlogMailForm";

    /**
     * The request scope attribute that holds the em1EventlogMail list
     */
    public static final String EM1EVENTLOGMAIL_LIST = "em1EventlogMailList";
//Em1EventlogMail-END


//Xm1KvItem-START
    /**
     * The request scope attribute that holds the xm1KvItem form.
     */
    public static final String XM1KVITEM_KEY = "xm1KvItemForm";

    /**
     * The request scope attribute that holds the xm1KvItem list
     */
    public static final String XM1KVITEM_LIST = "xm1KvItemList";
//Xm1KvItem-END


//Em1Event-START
    /**
     * The request scope attribute that holds the em1Event form.
     */
    public static final String EM1EVENT_KEY = "em1EventForm";

    /**
     * The request scope attribute that holds the em1Event list
     */
    public static final String EM1EVENT_LIST = "em1EventList";
//Em1Event-END


//Em1EventText-START
    /**
     * The request scope attribute that holds the em1EventText form.
     */
    public static final String EM1EVENTTEXT_KEY = "em1EventTextForm";

    /**
     * The request scope attribute that holds the em1EventText list
     */
    public static final String EM1EVENTTEXT_LIST = "em1EventTextList";
//Em1EventText-END


//Em1SubEvent-START
    /**
     * The request scope attribute that holds the em1SubEvent form.
     */
    public static final String EM1SUBEVENT_KEY = "em1SubEventForm";

    /**
     * The request scope attribute that holds the em1SubEvent list
     */
    public static final String EM1SUBEVENT_LIST = "em1SubEventList";
//Em1SubEvent-END


//Em1SubEventText-START
    /**
     * The request scope attribute that holds the em1SubEventText form.
     */
    public static final String EM1SUBEVENTTEXT_KEY = "em1SubEventTextForm";

    /**
     * The request scope attribute that holds the em1SubEventText list
     */
    public static final String EM1SUBEVENTTEXT_LIST = "em1SubEventTextList";
//Em1SubEventText-END


//Em1EventlogSms-START
    /**
     * The request scope attribute that holds the em1EventlogSms form.
     */
    public static final String EM1EVENTLOGSMS_KEY = "em1EventlogSmsForm";

    /**
     * The request scope attribute that holds the em1EventlogSms list
     */
    public static final String EM1EVENTLOGSMS_LIST = "em1EventlogSmsList";
//Em1EventlogSms-END


//Em1ClientContact-START
    /**
     * The request scope attribute that holds the em1ClientContact form.
     */
    public static final String EM1CLIENTCONTACT_KEY = "em1ClientContactForm";

    /**
     * The request scope attribute that holds the em1ClientContact list
     */
    public static final String EM1CLIENTCONTACT_LIST = "em1ClientContactList";
//Em1ClientContact-END


//Em1DocumentLog-START
    /**
     * The request scope attribute that holds the em1DocumentLog form.
     */
    public static final String EM1DOCUMENTLOG_KEY = "em1DocumentLogForm";

    /**
     * The request scope attribute that holds the em1DocumentLog list
     */
    public static final String EM1DOCUMENTLOG_LIST = "em1DocumentLogList";
//Em1DocumentLog-END


//Em1D6TLogEvent-START
    /**
     * The request scope attribute that holds the em1D6TLogEvent form.
     */
    public static final String EM1D6TLOGEVENT_KEY = "em1D6TLogEventForm";

    /**
     * The request scope attribute that holds the em1D6TLogEvent list
     */
    public static final String EM1D6TLOGEVENT_LIST = "em1D6TLogEventList";
//Em1D6TLogEvent-END


//Em1DocumentType-START
    /**
     * The request scope attribute that holds the em1DocumentType form.
     */
    public static final String EM1DOCUMENTTYPE_KEY = "em1DocumentTypeForm";

    /**
     * The request scope attribute that holds the em1DocumentType list
     */
    public static final String EM1DOCUMENTTYPE_LIST = "em1DocumentTypeList";
//Em1DocumentType-END


//Xm1EdiDocument-START
    /**
     * The request scope attribute that holds the xm1EdiDocument form.
     */
    public static final String XM1EDIDOCUMENT_KEY = "xm1EdiDocumentForm";

    /**
     * The request scope attribute that holds the xm1EdiDocument list
     */
    public static final String XM1EDIDOCUMENT_LIST = "xm1EdiDocumentList";
//Xm1EdiDocument-END


//Em1ClientLog-START
    /**
     * The request scope attribute that holds the em1ClientLog form.
     */
    public static final String EM1CLIENTLOG_KEY = "em1ClientLogForm";

    /**
     * The request scope attribute that holds the em1ClientLog list
     */
    public static final String EM1CLIENTLOG_LIST = "em1ClientLogList";
//Em1ClientLog-END


//Em1ClientD6TFormat-START
    /**
     * The request scope attribute that holds the em1ClientD6TFormat form.
     */
    public static final String EM1CLIENTD6TFORMAT_KEY = "em1ClientD6TFormatForm";

    /**
     * The request scope attribute that holds the em1ClientD6TFormat list
     */
    public static final String EM1CLIENTD6TFORMAT_LIST = "em1ClientD6TFormatList";
//Em1ClientD6TFormat-END





//Em1ClientPlog-START
    /**
     * The request scope attribute that holds the em1ClientPlog form.
     */
    public static final String EM1CLIENTPLOG_KEY = "em1ClientPlogForm";

    /**
     * The request scope attribute that holds the em1ClientPlog list
     */
    public static final String EM1CLIENTPLOG_LIST = "em1ClientPlogList";
//Em1ClientPlog-END


//Em1EdiDocument-START
    /**
     * The request scope attribute that holds the em1EdiDocument form.
     */
    public static final String EM1EDIDOCUMENT_KEY = "em1EdiDocumentForm";

    /**
     * The request scope attribute that holds the em1EdiDocument list
     */
    public static final String EM1EDIDOCUMENT_LIST = "em1EdiDocumentList";
//Em1EdiDocument-END


//Em1UserEvent-START
    /**
     * The request scope attribute that holds the em1UserEvent form.
     */
    public static final String EM1USEREVENT_KEY = "em1UserEventForm";

    /**
     * The request scope attribute that holds the em1UserEvent list
     */
    public static final String EM1USEREVENT_LIST = "em1UserEventList";
//Em1UserEvent-END


//TemplateMailList-START
    /**
     * The request scope attribute that holds the templateMailList form.
     */
    public static final String TEMPLATEMAILLIST_KEY = "templateMailListForm";

    /**
     * The request scope attribute that holds the templateMailList list
     */
    public static final String TEMPLATEMAILLIST_LIST = "templateMailListList";
//TemplateMailList-END


//Em1ClientEventP-START
    /**
     * The request scope attribute that holds the em1ClientEventP form.
     */
    public static final String EM1CLIENTEVENTP_KEY = "em1ClientEventPForm";

    /**
     * The request scope attribute that holds the em1ClientEventP list
     */
    public static final String EM1CLIENTEVENTP_LIST = "em1ClientEventPList";
//Em1ClientEventP-END


//Em1UserProject-START
    /**
     * The request scope attribute that holds the em1UserProject form.
     */
    public static final String EM1USERPROJECT_KEY = "em1UserProjectForm";

    /**
     * The request scope attribute that holds the em1UserProject list
     */
    public static final String EM1USERPROJECT_LIST = "em1UserProjectList";
//Em1UserProject-END


//Em1UserProjectC-START
    /**
     * The request scope attribute that holds the em1UserProjectC form.
     */
    public static final String EM1USERPROJECTC_KEY = "em1UserProjectCForm";

    /**
     * The request scope attribute that holds the em1UserProjectC list
     */
    public static final String EM1USERPROJECTC_LIST = "em1UserProjectCList";
//Em1UserProjectC-END


//Em1UserProjectE-START
    /**
     * The request scope attribute that holds the em1UserProjectE form.
     */
    public static final String EM1USERPROJECTE_KEY = "em1UserProjectEForm";

    /**
     * The request scope attribute that holds the em1UserProjectE list
     */
    public static final String EM1USERPROJECTE_LIST = "em1UserProjectEList";
//Em1UserProjectE-END


//Xm1KvText-START
    /**
     * The request scope attribute that holds the xm1KvText form.
     */
    public static final String XM1KVTEXT_KEY = "xm1KvTextForm";

    /**
     * The request scope attribute that holds the xm1KvText list
     */
    public static final String XM1KVTEXT_LIST = "xm1KvTextList";
//Xm1KvText-END


//Em1ClientRlog-START
    /**
     * The request scope attribute that holds the em1ClientRlog form.
     */
    public static final String EM1CLIENTRLOG_KEY = "em1ClientRlogForm";

    /**
     * The request scope attribute that holds the em1ClientRlog list
     */
    public static final String EM1CLIENTRLOG_LIST = "em1ClientRlogList";
//Em1ClientRlog-END


//UsersColumns-START
    /**
     * The request scope attribute that holds the usersColumns form.
     */
    public static final String USERSCOLUMNS_KEY = "usersColumnsForm";

    /**
     * The request scope attribute that holds the usersColumns list
     */
    public static final String USERSCOLUMNS_LIST = "usersColumnsList";
//UsersColumns-END


//Em1_earc_by-START
    /**
     * The request scope attribute that holds the em1_earc_by form.
     */
    public static final String EM1_EARC_BY_KEY = "em1_earc_byForm";

    /**
     * The request scope attribute that holds the em1_earc_by list
     */
    public static final String EM1_EARC_BY_LIST = "em1_earc_byList";
//Em1_earc_by-END





//Em1_earc_by_bp-START
    /**
     * The request scope attribute that holds the em1_earc_by_bp form.
     */
    public static final String EM1_EARC_BY_BP_KEY = "em1_earc_by_bpForm";

    /**
     * The request scope attribute that holds the em1_earc_by_bp list
     */
    public static final String EM1_EARC_BY_BP_LIST = "em1_earc_by_bpList";
//Em1_earc_by_bp-END


//Em1_earc_nad_ii-START
    /**
     * The request scope attribute that holds the em1_earc_nad_ii form.
     */
    public static final String EM1_EARC_NAD_II_KEY = "em1_earc_nad_iiForm";

    /**
     * The request scope attribute that holds the em1_earc_nad_ii list
     */
    public static final String EM1_EARC_NAD_II_LIST = "em1_earc_nad_iiList";
//Em1_earc_nad_ii-END


//Em1_earc_nad_iv-START
    /**
     * The request scope attribute that holds the em1_earc_nad_iv form.
     */
    public static final String EM1_EARC_NAD_IV_KEY = "em1_earc_nad_ivForm";

    /**
     * The request scope attribute that holds the em1_earc_nad_iv list
     */
    public static final String EM1_EARC_NAD_IV_LIST = "em1_earc_nad_ivList";
//Em1_earc_nad_iv-END


//Em1_earc_su-START
    /**
     * The request scope attribute that holds the em1_earc_su form.
     */
    public static final String EM1_EARC_SU_KEY = "em1_earc_suForm";

    /**
     * The request scope attribute that holds the em1_earc_su list
     */
    public static final String EM1_EARC_SU_LIST = "em1_earc_suList";
//Em1_earc_su-END


//TemplateFrame-START
    /**
     * The request scope attribute that holds the templateFrame form.
     */
    public static final String TEMPLATEFRAME_KEY = "templateFrameForm";

    /**
     * The request scope attribute that holds the templateFrame list
     */
    public static final String TEMPLATEFRAME_LIST = "templateFrameList";
//TemplateFrame-END


//TemplateCustomClass-START
    /**
     * The request scope attribute that holds the templateCustomClass form.
     */
    public static final String TEMPLATECUSTOMCLASS_KEY = "templateCustomClassForm";

    /**
     * The request scope attribute that holds the templateCustomClass list
     */
    public static final String TEMPLATECUSTOMCLASS_LIST = "templateCustomClassList";
//TemplateCustomClass-END


//TemplateClassPP-START
    /**
     * The request scope attribute that holds the templateClassPP form.
     */
    public static final String TEMPLATECLASSPP_KEY = "templateClassPPForm";

    /**
     * The request scope attribute that holds the templateClassPP list
     */
    public static final String TEMPLATECLASSPP_LIST = "templateClassPPList";
//TemplateClassPP-END


//TemplateCssDefault-START
    /**
     * The request scope attribute that holds the templateCssDefault form.
     */
    public static final String TEMPLATECSSDEFAULT_KEY = "templateCssDefaultForm";

    /**
     * The request scope attribute that holds the templateCssDefault list
     */
    public static final String TEMPLATECSSDEFAULT_LIST = "templateCssDefaultList";
//TemplateCssDefault-END


//TemplateMenun-START
    /**
     * The request scope attribute that holds the templateMenun form.
     */
    public static final String TEMPLATEMENUN_KEY = "templateMenunForm";

    /**
     * The request scope attribute that holds the templateMenun list
     */
    public static final String TEMPLATEMENUN_LIST = "templateMenunList";
//TemplateMenun-END


//TemplateSearch-START
    /**
     * The request scope attribute that holds the templateSearch form.
     */
    public static final String TEMPLATESEARCH_KEY = "templateSearchForm";

    /**
     * The request scope attribute that holds the templateSearch list
     */
    public static final String TEMPLATESEARCH_LIST = "templateSearchList";
//TemplateSearch-END


//TemplateObjektiBaza-START
    /**
     * The request scope attribute that holds the templateObjektiBaza form.
     */
    public static final String TEMPLATEOBJEKTIBAZA_KEY = "templateObjektiBazaForm";

    /**
     * The request scope attribute that holds the templateObjektiBaza list
     */
    public static final String TEMPLATEOBJEKTIBAZA_LIST = "templateObjektiBazaList";
//TemplateObjektiBaza-END





//TemplateTables-START
    /**
     * The request scope attribute that holds the templateTables form.
     */
    public static final String TEMPLATETABLES_KEY = "templateTablesForm";

    /**
     * The request scope attribute that holds the templateTables list
     */
    public static final String TEMPLATETABLES_LIST = "templateTablesList";
//TemplateTables-END


//TemplateTablesCol-START
    /**
     * The request scope attribute that holds the templateTablesCol form.
     */
    public static final String TEMPLATETABLESCOL_KEY = "templateTablesColForm";

    /**
     * The request scope attribute that holds the templateTablesCol list
     */
    public static final String TEMPLATETABLESCOL_LIST = "templateTablesColList";
//TemplateTablesCol-END


//TemplateTablesGen-START
    /**
     * The request scope attribute that holds the templateTablesGen form.
     */
    public static final String TEMPLATETABLESGEN_KEY = "templateTablesGenForm";

    /**
     * The request scope attribute that holds the templateTablesGen list
     */
    public static final String TEMPLATETABLESGEN_LIST = "templateTablesGenList";
//TemplateTablesGen-END


//TemplateXml-START
    /**
     * The request scope attribute that holds the templateXml form.
     */
    public static final String TEMPLATEXML_KEY = "templateXmlForm";

    /**
     * The request scope attribute that holds the templateXml list
     */
    public static final String TEMPLATEXML_LIST = "templateXmlList";
//TemplateXml-END


//TemplateAttribute-START
    /**
     * The request scope attribute that holds the templateAttribute form.
     */
    public static final String TEMPLATEATTRIBUTE_KEY = "templateAttributeForm";

    /**
     * The request scope attribute that holds the templateAttribute list
     */
    public static final String TEMPLATEATTRIBUTE_LIST = "templateAttributeList";
//TemplateAttribute-END


//UsersParametri-START
    /**
     * The request scope attribute that holds the usersParametri form.
     */
    public static final String USERSPARAMETRI_KEY = "usersParametriForm";

    /**
     * The request scope attribute that holds the usersParametri list
     */
    public static final String USERSPARAMETRI_LIST = "usersParametriList";
//UsersParametri-END


//TemplateXmlelements-START
    /**
     * The request scope attribute that holds the templateXmlelements form.
     */
    public static final String TEMPLATEXMLELEMENTS_KEY = "templateXmlelementsForm";

    /**
     * The request scope attribute that holds the templateXmlelements list
     */
    public static final String TEMPLATEXMLELEMENTS_LIST = "templateXmlelementsList";
//TemplateXmlelements-END


//TemplateXmlapp-START
    /**
     * The request scope attribute that holds the templateXmlapp form.
     */
    public static final String TEMPLATEXMLAPP_KEY = "templateXmlappForm";

    /**
     * The request scope attribute that holds the templateXmlapp list
     */
    public static final String TEMPLATEXMLAPP_LIST = "templateXmlappList";
//TemplateXmlapp-END


//TemplateConversion-START
    /**
     * The request scope attribute that holds the templateConversion form.
     */
    public static final String TEMPLATECONVERSION_KEY = "templateConversionForm";

    /**
     * The request scope attribute that holds the templateConversion list
     */
    public static final String TEMPLATECONVERSION_LIST = "templateConversionList";
//TemplateConversion-END


//TemplateConversions-START
    /**
     * The request scope attribute that holds the templateConversions form.
     */
    public static final String TEMPLATECONVERSIONS_KEY = "templateConversionsForm";

    /**
     * The request scope attribute that holds the templateConversions list
     */
    public static final String TEMPLATECONVERSIONS_LIST = "templateConversionsList";
//TemplateConversions-END


//TemplateJsDb-START
    /**
     * The request scope attribute that holds the templateJsDb form.
     */
    public static final String TEMPLATEJSDB_KEY = "templateJsDbForm";

    /**
     * The request scope attribute that holds the templateJsDb list
     */
    public static final String TEMPLATEJSDB_LIST = "templateJsDbList";
//TemplateJsDb-END


//Gt1dbchange-START
    /**
     * The request scope attribute that holds the gt1dbchange form.
     */
    public static final String GT1DBCHANGE_KEY = "gt1dbchangeForm";

    /**
     * The request scope attribute that holds the gt1dbchange list
     */
    public static final String GT1DBCHANGE_LIST = "gt1dbchangeList";
//Gt1dbchange-END


//Codes-START
    /**
     * The request scope attribute that holds the codes form.
     */
    public static final String CODES_KEY = "codesForm";

    /**
     * The request scope attribute that holds the codes list
     */
    public static final String CODES_LIST = "codesList";
//Codes-END


//TemplatePages-START
    /**
     * The request scope attribute that holds the templatePages form.
     */
    public static final String TEMPLATEPAGES_KEY = "templatePagesForm";

    /**
     * The request scope attribute that holds the templatePages list
     */
    public static final String TEMPLATEPAGES_LIST = "templatePagesList";
//TemplatePages-END


//TemplateRepository-START
    /**
     * The request scope attribute that holds the templateRepository form.
     */
    public static final String TEMPLATEREPOSITORY_KEY = "templateRepositoryForm";

    /**
     * The request scope attribute that holds the templateRepository list
     */
    public static final String TEMPLATEREPOSITORY_LIST = "templateRepositoryList";
//TemplateRepository-END


//PgnClients-START
    /**
     * The request scope attribute that holds the pgnClients form.
     */
    public static final String PGNCLIENTS_KEY = "pgnClientsForm";

    /**
     * The request scope attribute that holds the pgnClients list
     */
    public static final String PGNCLIENTS_LIST = "pgnClientsList";
//PgnClients-END


//PgnClientsSendFrom-START
    /**
     * The request scope attribute that holds the pgnClientsSendFrom form.
     */
    public static final String PGNCLIENTSSENDFROM_KEY = "pgnClientsSendFromForm";

    /**
     * The request scope attribute that holds the pgnClientsSendFrom list
     */
    public static final String PGNCLIENTSSENDFROM_LIST = "pgnClientsSendFromList";
//PgnClientsSendFrom-END


//PgnClientsGetFrom-START
    /**
     * The request scope attribute that holds the pgnClientsGetFrom form.
     */
    public static final String PGNCLIENTSGETFROM_KEY = "pgnClientsGetFromForm";

    /**
     * The request scope attribute that holds the pgnClientsGetFrom list
     */
    public static final String PGNCLIENTSGETFROM_LIST = "pgnClientsGetFromList";
//PgnClientsGetFrom-END


//PgnClientsGetFromSrc-START
    /**
     * The request scope attribute that holds the pgnClientsGetFromSrc form.
     */
    public static final String PGNCLIENTSGETFROMSRC_KEY = "pgnClientsGetFromSrcForm";

    /**
     * The request scope attribute that holds the pgnClientsGetFromSrc list
     */
    public static final String PGNCLIENTSGETFROMSRC_LIST = "pgnClientsGetFromSrcList";
//PgnClientsGetFromSrc-END


//PgnClientsSendFromSrc-START
    /**
     * The request scope attribute that holds the pgnClientsSendFromSrc form.
     */
    public static final String PGNCLIENTSSENDFROMSRC_KEY = "pgnClientsSendFromSrcForm";

    /**
     * The request scope attribute that holds the pgnClientsSendFromSrc list
     */
    public static final String PGNCLIENTSSENDFROMSRC_LIST = "pgnClientsSendFromSrcList";
//PgnClientsSendFromSrc-END


//PgnLog-START
    /**
     * The request scope attribute that holds the pgnLog form.
     */
    public static final String PGNLOG_KEY = "pgnLogForm";

    /**
     * The request scope attribute that holds the pgnLog list
     */
    public static final String PGNLOG_LIST = "pgnLogList";
//PgnLog-END


//PgnClientsReceiveFrom-START
    /**
     * The request scope attribute that holds the pgnClientsReceiveFrom form.
     */
    public static final String PGNCLIENTSRECEIVEFROM_KEY = "pgnClientsReceiveFromForm";

    /**
     * The request scope attribute that holds the pgnClientsReceiveFrom list
     */
    public static final String PGNCLIENTSRECEIVEFROM_LIST = "pgnClientsReceiveFromList";
//PgnClientsReceiveFrom-END


//PgnClientsReceiveFromSrc-START
    /**
     * The request scope attribute that holds the pgnClientsReceiveFromSrc form.
     */
    public static final String PGNCLIENTSRECEIVEFROMSRC_KEY = "pgnClientsReceiveFromSrcForm";

    /**
     * The request scope attribute that holds the pgnClientsReceiveFromSrc list
     */
    public static final String PGNCLIENTSRECEIVEFROMSRC_LIST = "pgnClientsReceiveFromSrcList";
//PgnClientsReceiveFromSrc-END


//PgnLogClient-START
    /**
     * The request scope attribute that holds the pgnLogClient form.
     */
    public static final String PGNLOGCLIENT_KEY = "pgnLogClientForm";

    /**
     * The request scope attribute that holds the pgnLogClient list
     */
    public static final String PGNLOGCLIENT_LIST = "pgnLogClientList";
//PgnLogClient-END


//PgnProblemSolved-START
    /**
     * The request scope attribute that holds the pgnProblemSolved form.
     */
    public static final String PGNPROBLEMSOLVED_KEY = "pgnProblemSolvedForm";

    /**
     * The request scope attribute that holds the pgnProblemSolved list
     */
    public static final String PGNPROBLEMSOLVED_LIST = "pgnProblemSolvedList";
//PgnProblemSolved-END


//Pgnclientsschedule-START
    /**
     * The request scope attribute that holds the pgnclientsschedule form.
     */
    public static final String PGNCLIENTSSCHEDULE_KEY = "pgnclientsscheduleForm";

    /**
     * The request scope attribute that holds the pgnclientsschedule list
     */
    public static final String PGNCLIENTSSCHEDULE_LIST = "pgnclientsscheduleList";
//Pgnclientsschedule-END

}
