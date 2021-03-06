package com.popultrade.webapp.action;

import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import com.popultrade.Constants;
import com.popultrade.model.Address;
import com.popultrade.model.User;
import com.popultrade.service.RoleManager;
import com.popultrade.service.UserManager;

import com.dumbster.smtp.SimpleSmtpServer;

public class SignupFormTest extends BasePageTestCase {
    private SignupForm page;
    
    public void setUp() throws Exception {
        super.setUp();        
        page = (SignupForm) getPage(SignupForm.class);
        
        // unfortunately this is a required step if you're calling getMessage
        page.setBundle(ResourceBundle.getBundle(MESSAGES));
        page.setValidationDelegate(new Validator());
        Map global = new HashMap();
        global.put(BaseEngine.APPLICATION_CONTEXT_KEY, ctx);
        page.setGlobal(global);
        
        // these can be mocked if you want a more "pure" unit test
        page.setUserManager((UserManager) ctx.getBean("userManager"));
        page.setRoleManager((RoleManager) ctx.getBean("roleManager"));
    }
    
    public void testExecute() throws Exception {
        page.setRequestCycle(getCycle(request, response));
        User user = new User();
        user.setUsername("self-registered");
        user.setPassword("Password1");
        user.setConfirmPassword("Password1");
        user.setFirstName("First");
        user.setLastName("Last");
        
        Address address = new Address();
        address.setCity("Denver");
        address.setProvince("CO");
        address.setCountry("USA");
        address.setPostalCode("80210");        
        user.setAddress(address);
        
        user.setEmail("self-registered@raibledesigns.com");
        user.setWebsite("http://raibledesigns.com");
        user.setPasswordHint("Password is one with you.");
        page.setUser(user);
        
        // start SMTP Server
        SimpleSmtpServer server = SimpleSmtpServer.start(2525);
        
        page.setRequestCycle(getCycle(request, response));
        page.save(page.getRequestCycle());
        
        assertFalse(page.hasErrors());
        
        // verify an account information e-mail was sent
        server.stop();
        assertTrue(server.getReceivedEmailSize() == 1);

        // verify that success messages are in the session
        assertNotNull(page.getSession().getAttribute(Constants.REGISTERED));
    }
}
