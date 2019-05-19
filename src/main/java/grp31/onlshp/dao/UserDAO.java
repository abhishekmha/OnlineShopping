package grp31.onlshp.dao;

import java.util.List;

import grp31.onlshp.pojo.User;

public interface UserDAO {

	void addUser(User p);

	void updateUser(User p);

	List<User> listUsers();

	void removeUser(String email);

	User getUserByEmail(String email);

	byte validateLogin(String email, String password);

	boolean validateRegister(String email);

	User getLoggedInUser(int id);

	int getUserId(String email);
}
