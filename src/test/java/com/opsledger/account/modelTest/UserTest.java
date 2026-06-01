package com.opsledger.account.modelTest;

import junit.framework.Assert;

import java.util.HashSet;
import java.util.Set;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.opsledger.account.model.Role;
import com.opsledger.account.model.User;

/** {@author imrant} !*/
public class UserTest {
	
	public static final Long EXPECTED_ID = 1L;
	public static final int EXPECTED_SIZE = 1;
    public static final String EXPECTED_USERNAME = "SampleUser01";
    public static final String EXPECTED_PASSWD = "SampleUser01";
    public static final String EXPECTED_USEREMAIL = "sample.user@opsledger.local";
    private User user;
    @Before
    public void setUp() throws Exception {
    	   	
    	Role role = new Role();
    	role.setId(1L);
        role.setName("Admin");
        Set<Role> roles = new HashSet<Role>();    	
        roles.add(role); 
    	
        user = new User();
        user.setId(1L);
        user.setUsername("SampleUser01");
        user.setPassword("SampleUser01");
        user.setUserEmail("sample.user@opsledger.local");
        user.setRoles(roles);
    }

    @After
    public void tearDown() throws Exception {
        System.out.println("Test Completed");

    }

    @Test
    public void testUserDetailsHappyFlow() throws Exception {
    	Assert.assertEquals(EXPECTED_ID, user.getId());
        Assert.assertEquals(EXPECTED_USERNAME, user.getUsername());
        Assert.assertEquals(EXPECTED_PASSWD, user.getPassword());
        Assert.assertEquals(EXPECTED_USEREMAIL, user.getUserEmail());
        Assert.assertEquals(EXPECTED_SIZE,user.getRoles().size());

    }
}
