package grp31.onlshp.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import grp31.onlshp.dao.UserDAO;
import grp31.onlshp.pojo.User;

@Service
public class UserServiceImpl implements UserService {
	
	private UserDAO userDAO;

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	@Override
	@Transactional
	public void addUser(String username, String email, String password, int age, String type) {
		User u = new User();
		u.setUsername(username);
		u.setEmail(email);
		u.setPassword(password);
		u.setAge(age);
		u.setType(type);		
		this.userDAO.addUser(u);
	}

	@Override
	@Transactional
	public void updateUser(User p) {
		this.userDAO.updateUser(p);
	}
	
	@Override
	@Transactional
	public User getUserByEmail(String email) {
		return this.userDAO.getUserByEmail(email);
	}

	@Override
	@Transactional
	public List<User> listUsers() {
		return this.userDAO.listUsers();
	}

	@Override
	@Transactional
	public User getLoggedInUser(int id) {
		return this.userDAO.getLoggedInUser(id);
	}

	@Override
	@Transactional
	public void removeUser(String email) {
		this.userDAO.removeUser(email);
	}

	@Override
	@Transactional
	public byte validateLogin(String email, String password) throws SQLException {
		System.out.println("checking user credentials");
	    return userDAO.validateLogin(email, password);	    
	}

	@Override
	@Transactional
	public boolean validateRegiser(String email) throws SQLException {
		System.out.println("checking new user credentials");
	    return userDAO.validateRegister(email);
	}

	@Override
	@Transactional
	public int getUserId(String email) {
		return userDAO.getUserId(email);
	}
}
